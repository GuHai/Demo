package com.yskj.controller;import com.yskj.controller.base.BaseController;import com.yskj.models.PageParam;import com.yskj.models.QueryParam;import com.yskj.models.Educational;import com.yskj.service.EducationalService;import com.yskj.utils.Result;import org.apache.shiro.authz.annotation.RequiresPermissions;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.RequestBody;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestMethod;import org.springframework.web.bind.annotation.ResponseBody;import org.slf4j.Logger;import org.slf4j.LoggerFactory;@Controller@RequestMapping(value = "/EducationalController")public class EducationalController extends BaseController{	@Autowired	private EducationalService educationalService;	private final static Logger logger = LoggerFactory.getLogger(EducationalController.class);	 public EducationalService getService() {         return this.educationalService;     }	 /**     * 页面     * @return String     */    @RequiresPermissions("Educational")    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String index(Model model){        return "educational";    }     /**     *新增     * @param educational     * @return Result     */    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result add(Educational educational ){         return super.add(educational);    }    /**     * 删除     * @param educational     * @return Result     */    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result delete(Educational educational ){        return super.delete(educational);    }     /**     * 修改     * @param educational     * @return Result     */    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result update(Educational educational ){        return super.update(educational);    }    /**     * 查询页面     * @param pageParam     * @return Result     */    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findPage(@RequestBody  PageParam pageParam ){       return super.findPage(pageParam);    }     /**     * 查询集合     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findList(@RequestBody  QueryParam queryParam ){        return super.findList(queryParam);    }    /**    * 模糊查询页面    * @param pageParam    * @return Result    */    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikePage(@RequestBody  PageParam pageParam ){         return super.findLikePage(pageParam);    }    /**     * 查询集合，模糊查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikeList(@RequestBody  QueryParam queryParam ){        return super.findLikeList(queryParam);    }     /**     * 唯一查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result one(@RequestBody  QueryParam queryParam ){        return super.one(queryParam);    }    /**     * 唯一查询通过ID     * @param id     * @return Result     */    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result get(String id ){        return super.get(id);    }}