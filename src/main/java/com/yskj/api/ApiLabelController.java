package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.Label;
import com.yskj.service.LabelService;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
@RequestMapping(value = "/api/LabelController")
public class ApiLabelController extends BaseController{

	@Autowired
	private LabelService labelService;

	private final static Logger logger = LoggerFactory.getLogger(ApiLabelController.class);

	 public LabelService getService() {
         return this.labelService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("Label")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "label";
    }

     /**
     *新增
     * @param label
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Label label ){
         return super.add(label);
    }

    /**
     * 删除
     * @param label
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Label label ){
        return super.delete(label);
    }

     /**
     * 修改
     * @param label
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Label label ){
        return super.update(label);
    }

    /**
     * 查询页面
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findPage(@RequestBody PageParam pageParam ){
       return super.findPage(pageParam);
    }

     /**
     * 查询集合
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findList(@RequestBody QueryParam queryParam ){
        return super.findList(queryParam);
    }


    /**
    * 模糊查询页面
    * @param pageParam
    * @return Result
    */
    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikePage(@RequestBody PageParam pageParam ){
         return super.findLikePage(pageParam);
    }


    /**
     * 查询集合，模糊查询
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikeList(@RequestBody QueryParam queryParam ){
        return super.findLikeList(queryParam);
    }

     /**
     * 唯一查询
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result one(@RequestBody QueryParam queryParam ){
        return super.one(queryParam);
    }

    /**
     * 唯一查询通过ID
     * @param id
     * @return Result
     */
    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result get(String id ){
        return super.get(id);
    }

}
