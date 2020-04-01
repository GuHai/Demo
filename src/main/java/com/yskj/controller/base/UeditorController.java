package com.yskj.controller.base;

import com.yskj.models.*;
import com.yskj.service.*;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.HttpUtils;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 富文本编辑器
 *
 * @author:Administrator
 * @create 2018-04-10 14:29
 */
@Controller
@RequestMapping("/UeditorController")
public class UeditorController extends BaseController {
    @Autowired
    private NewsService newsService;
    @Autowired
    private VersionService versionService;
    @Autowired
    private MessageTemplateService messageTemplateService;
    @Autowired
    private LinkService linkService;
    @Autowired
    private ArticleService articleService;

    private final static Logger logger = LoggerFactory.getLogger(UeditorController.class);

    public NewsService getService() {
        return this.newsService;
    }

    @RequestMapping("/ueditor")
    public String ueditor(Model m){
        return "/ueditor";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"text/html; charset=utf-8"})
    public String add( Model model,String editorValue ,String title,String description,String id,Integer version){
        News news = new News();
        news.setContent(editorValue);
        news.setTitle(title);
        news.setDescription(description);
        if(StringUtils.isNotEmpty(id))
            news.setId(id);
        if(version!=null)
            news.setVersion(version);
        try {
            newsService.persistence(news);
            news = newsService.get(news.getId());
            news.setPublishTime(DateUtils.format(news.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
            model.addAttribute("news",news);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return "/ueditorshow";
    }

    @RequestMapping("/news")
    public String news(Model model,HttpServletResponse response){
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        QueryParam queryParam  = new QueryParam();
        queryParam.setOrderByClause(" order by n.updateTime desc ");
        PrintWriter out = null;
        try {
            News news = newsService.one(queryParam);
            if(news!=null){
                news.setPublishTime(DateUtils.format(news.getCreateTime(),"yyyy-MM-dd"));
                model.addAttribute("news",news);
            }else{
                news = new News();
                news.setTitle("无文章");
                news.setContent("敬请期待...");
                news.setDescription("未提交任何文章");
                model.addAttribute("news",news);
            }
            model.addAttribute("gzh", DictCacheService.GzhID);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(out!=null){
                out.close();
            }
        }
        return "/news";
    }

    @RequestMapping("/edit")
    public String edit(Model model,HttpServletResponse response){
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        QueryParam queryParam  = new QueryParam();
        queryParam.put("createBy", IJobSecurityUtils.getLoginUserId());
        queryParam.setOrderByClause(" order by n.updateTime desc ");
        PrintWriter out = null;
        try {
            News news = newsService.one(queryParam);
            model.addAttribute("news",news);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(out!=null){
                out.close();
            }
        }
        return "/ueditor";
    }

    @RequestMapping("/addVersionPage")
    public String addVersionPage(){
        return "/edit_version";
    }
    @RequestMapping(value = "/addVersion", method = RequestMethod.POST, produces = {"text/html; charset=utf-8"})
    public String addVersion( Model model,String editorValue ,String title,String description,String versionNo){
        Version news = new Version();
        news.setContent(editorValue);
        news.setTitle(title);
        news.setDescription(description);
        news.setVersionNo(versionNo);
        try {
            versionService.add(news);
            news = versionService.get(news.getId());
            news.setPublishTime(DateUtils.format(news.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
            model.addAttribute("news",news);
            messageTemplateService.noticeVersion(news);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return "/version";
    }


    @RequestMapping("/version")
    public String version(Model model,HttpServletResponse response){
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        QueryParam queryParam  = new QueryParam();
        queryParam.setOrderByClause(" order by v.updateTime desc ");
        PrintWriter out = null;
        try {
            Version news = versionService.one(queryParam);
            if(news!=null){
                news.setPublishTime(DateUtils.format(news.getCreateTime(),"yyyy-MM-dd"));
                model.addAttribute("news",news);
            }else{
                news = new Version();
                news.setTitle("没有推送信息");
                news.setContent("敬请期待...");
                news.setDescription("未提交任何版本更新");
                model.addAttribute("news",news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(out!=null){
                out.close();
            }
        }
        return "/version";
    }


    @RequestMapping(value = "/website/{id}", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String website( Model model,@PathVariable String id){
        model.addAttribute("id",id);
        return "/h5/forward";
    }

    @RequestMapping(value = "/html/{id}", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public void  html(Model model, @PathVariable String id , HttpServletResponse response)throws Exception{
        Link link = linkService.get(id);
        String html ="找不到网站";
        if(link!=null){
            if(link.getInit()==false){//还么有处理过图片和路径替换
                html =HttpUtils.get(link.getLink());
                Matcher matcher = Pattern.compile("<img[^>]+/>").matcher(html);
                List<String> listImgUrl = new ArrayList<String>();
                int i = 0;
                while (matcher.find()) {
                    listImgUrl.add(matcher.group());
                }
                for(String img : listImgUrl) {
                    Matcher imgmatch = Pattern.compile("https:\"?(.*?)(\"|>|\\s+)").matcher(img);
                    while (imgmatch.find()) {
                        String url  = imgmatch.group().substring(0, imgmatch.group().length() - 1);
                        URL uri = new URL(url);
                        InputStream in = uri.openStream();
                        File fold = new File(DictCacheService.UploadPath+File.separator+"iJob"+File.separator+"images"+File.separator+"resource"+File.separator+link.getId());
                        if (!fold.exists()) {
                            fold.mkdirs();
                        }
                        String filename = (i++)+".gif";
                        FileOutputStream fo = new FileOutputStream(new File(fold.getPath()+File.separator+filename));
                        byte[] buf = new byte[1024];
                        int length = 0;
                        while ((length = in.read(buf, 0, buf.length)) != -1) {
                            fo.write(buf, 0, length);
                        }
                        in.close();
                        fo.close();
                        html = html.replace(url, DictCacheService.UploadUrl +"/iJob/images/resource/"+link.getId()+"/"+filename);
                    }
                }
                link.setContent(html);
                link.setInit(Boolean.TRUE);
                linkService.update(link);
            }else{ //每次查看都会更新版本号，作为浏览次数
                html = link.getContent();
                Link updatelink = new Link();
                updatelink.setId(link.getId());
                updatelink.setVersion(link.getVersion());
                linkService.update(updatelink);
            }
        }
        response.getWriter().print(html);
    }


    @RequestMapping("/article/{posi}")
    public String article(@PathVariable Integer posi,  Model model,HttpServletResponse response){
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        QueryParam queryParam  = new QueryParam();
        queryParam.put("posi",posi);
        PrintWriter out = null;
        try {
            Article article = articleService.one(queryParam);
            if(article!=null){
                article.setPublishTime(DateUtils.format(article.getCreateTime(),"yyyy-MM-dd"));
                article.setAuthor("I Job");
                model.addAttribute("article",article);
            }else{
                article = new Article();
                article.setTitle("无文章");
                article.setImage("");
                article.setContent("敬请期待...");
                article.setDescription("未提交任何文章");
                model.addAttribute("article",article);
            }
            model.addAttribute("gzh", DictCacheService.GzhID);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(out!=null){
                out.close();
            }
        }
        return "/article";
    }


    @RequestMapping("/article_edit/{posi}")
    public String articleEdit(@PathVariable Integer posi,  Model model,HttpServletResponse response){

        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        QueryParam queryParam  = new QueryParam();
        queryParam.put("posi",posi);
        PrintWriter out = null;
        try {
            Article article = articleService.one(queryParam);
            if(article!=null){
                article.setPublishTime(DateUtils.format(article.getCreateTime(),"yyyy-MM-dd"));
                article.setAuthor("I Job");
                model.addAttribute("article",article);
            }else{
                article =  new Article();
                article.setPosi(posi);
                model.addAttribute("article",article);
            }
            model.addAttribute("gzh", DictCacheService.GzhID);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(out!=null){
                out.close();
            }
        }
        return "/article_edit";
    }

    @RequestMapping("/article_add/{posi}")
    public String articleAdd( Model model,String editorValue ,String title,String description,String id,Integer version,Integer posi,String image){

        Article article = new Article();
        article.setContent(editorValue);
        article.setTitle(title);
        article.setDescription(description);
        article.setPosi(posi);
        article.setImage(image);
        if(StringUtils.isNotEmpty(id))
            article.setId(id);
        if(version!=null)
            article.setVersion(version);
        try {
            articleService.persistence(article);
            article = articleService.get(article.getId());
            article.setPublishTime(DateUtils.format(article.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
            model.addAttribute("article",article);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return "/article";
    }
}
