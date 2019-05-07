package top.weishilei.blog.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Link;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.impl.LinkServiceImpl;

import java.util.List;

/**
 * 链接Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/link")
public class AdminLinkContrller extends BaseController {
    @Autowired
    private LinkServiceImpl linkService;

    @GetMapping
    public ModelAndView link(@RequestParam(defaultValue = "3") Integer showType) {
        ModelAndView modelAndView = new ModelAndView("admin/link/link");
        List<Link> linkList = null;
        if (showType != 1 && showType != 2) {
            linkList = linkService.select();
        } else {
            linkList = linkService.selectByStatus(showType);
        }

        getRequest().setAttribute("showType", showType);
        return modelAndView.addObject("linkList", linkList);
    }

    @ResponseBody
    @GetMapping("/delete")
    public String delte(String ids) {
        List<Integer> idList = arrayToList(ids);
        if (idList == null) {
            return Result.fail();
        }

        boolean isSuccess = linkService.delete(idList) > 0;
        return isSuccess ? Result.success() : Result.fail();
    }

    @ResponseBody
    @GetMapping("/updateStatus")
    public String update(String ids) {
        List<Integer> idList = arrayToList(ids);
        if (idList == null) {
            return Result.fail();
        }

        boolean isSuccess = linkService.updateByStatus(2, idList) > 0;
        return isSuccess ? Result.success() : Result.fail();
    }

}
