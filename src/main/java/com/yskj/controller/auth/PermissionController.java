package com.yskj.controller.auth;

import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.auth.Permission;
import com.yskj.service.auth.PermissionService;
import com.yskj.utils.IJobUtils;
import com.yskj.utils.Result;
import com.yskj.utils.StringUtils;
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
 * 权限控制层
 *
 * @author:Administrator
 * @create 2018-01-19 18:18
 */
@Controller
@RequestMapping("/permissionController")
public class PermissionController extends BaseController {
    private final static Logger logger = LoggerFactory.getLogger(PermissionController.class);

    @Autowired
    private PermissionService permissionService;

    public PermissionService getService() {
        return this.permissionService;
    }


    /**
     * 新增权限页面
     * @return
     */
    @RequiresPermissions("Permission")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String permission(Model model){
        try{
            model.addAttribute("permissionfirst",permissionService.findPermissionByDepth(1));
            PageParam pageParam = new PageParam();
            model.addAttribute("permissions",permissionService.findPage(pageParam));
        }catch (Exception e){
            e.printStackTrace();
        }
        return "system/permission";
    }

    /**
     *新增权限
     */
    @RequestMapping(value = "/addPermission", method = RequestMethod.POST, produces = {
            "application/json; charset=utf-8"})
    @ResponseBody
    public Result addPermission(Permission permission ){
        Result result = new Result();
        try {
            if(StringUtils.isNotEmpty(permission.getParentId())){
                QueryParam queryParam = new QueryParam();
                queryParam.put("parentId",permission.getParentId());
                Permission maxPermission = permissionService.getMaxSortChild(queryParam);
                Permission parentPermission = permissionService.get(permission.getParentId());
                if(parentPermission==null){
                    parentPermission = new Permission();
                    parentPermission.setDepth(0);
                    parentPermission.setSort("");
                }
                String sort = "";
                if(maxPermission!=null){
                    sort = maxPermission.getSort();
                }
                permission.setSort(parentPermission.getSort()+IJobUtils.getNextSort(sort,4));
                permission.setDepth(parentPermission.getDepth()+1);
            }
            permissionService.add(permission);
            result.setMsg("新增权限成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(Result.ERROR,"新增权限失败"+e.getMessage());
        }
        return result;
    }



    /**
     *新增
     * @param shiropermission
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Permission shiropermission ){
        return super.add(shiropermission);
    }

    /**
     * 删除
     * @param shiropermission
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Permission shiropermission ){
        return super.delete(shiropermission);
    }

    /**
     * 修改
     * @param shiropermission
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Permission shiropermission ){
        return super.update(shiropermission);
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
