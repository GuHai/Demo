package com.yskj.controller.auth;

import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.auth.Role;
import com.yskj.service.auth.RoleService;
import com.yskj.service.base.AbstractService;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 角色控制层
 *
 * @author:Administrator
 * @create 2018-01-19 18:18
 */
@Controller
@RequestMapping("/roleController")
public class RoleController extends BaseController {
    @Autowired
    private RoleService roleService;

    private final static Logger logger = LoggerFactory.getLogger(RoleController.class);

    public AbstractService getService() {
        return null;
    }

    /**
     * 新增角色页面
     * @return
     */
    @RequiresPermissions("Role")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String role(Model model){
        PageParam pageParam =  new PageParam();
        try {
            model.addAttribute("roles",roleService.findPage(pageParam));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "system/role";
    }

    /**
     *新增角色
     */
    @RequestMapping(value = "/addRole", method = RequestMethod.POST, produces = {
            "application/json; charset=utf-8"})
    @ResponseBody
    public Result addRole(Role role ){
        Result result = new Result();
        try {
            roleService.add(role);
            result.setMsg("新增角色成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    /**
     *新增
     * @param shirorole
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Role shirorole ){
        return super.add(shirorole);
    }

    /**
     * 删除
     * @param shirorole
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Role shirorole ){
        return super.delete(shirorole);
    }

    /**
     * 修改
     * @param shirorole
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Role shirorole ){
        return super.update(shirorole);
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
}
