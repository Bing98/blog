package top.weishilei.blog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Log;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.domain.User;
import top.weishilei.blog.service.LogService;
import top.weishilei.blog.service.UserService;
import top.weishilei.blog.service.impl.CategoryServiceImpl;
import top.weishilei.blog.service.impl.CommentServiceImpl;
import top.weishilei.blog.service.impl.PostServiceImpl;
import top.weishilei.blog.service.impl.TagServiceImpl;
import top.weishilei.blog.utils.LogUtils;
import top.weishilei.blog.utils.SystemUtils;

import java.util.List;
import java.util.Map;

/**
 * 后台controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {
    @Autowired
    private UserService userService;
    @Autowired
    private LogService logService;
    @Autowired
    private PostServiceImpl postService;
    @Autowired
    private CommentServiceImpl commentService;
    @Autowired
    private TagServiceImpl tagService;
    @Autowired
    private CategoryServiceImpl categoryService;

    @GetMapping("/login")
    public ModelAndView login() {
        if (getSession().getAttribute("superName") != null) {
            return new ModelAndView("redirect:/admin/index");
        }

        return new ModelAndView("admin/login");
    }

    @GetMapping("/index")
    public ModelAndView index() {
        return new ModelAndView("admin/index");
    }

    @ResponseBody
    @PostMapping("/login")
    public String login(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            return Result.failCode("参数不能为空！", Result.PARAMTER_IS_EMPTY);
        }
        int id = userService.verifyAdmin(username, password);
        if (id < 0) {
            return Result.failCode("用户名或密码错误！", Result.USER_LOGIN_FAIL);
        }
        logService.insert(new Log(username + LogUtils.LOGIN.getContent(), id, getRequest().getRemoteAddr()));
        getSession().setAttribute("superName", username);

        return Result.success();
    }

    @GetMapping("/welcome")
    public ModelAndView welcome(@RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "10") int size) {
        ModelAndView modelAndView = new ModelAndView("admin/welcome");
        PageHelper.startPage(page,size,"id desc");
        Map<String, String> info = SystemUtils.getSystemInfo();
        modelAndView.addObject("systemInfo", info);
        List<Log> logs = logService.select();
        PageInfo<Log> result = new PageInfo<>(logs);
        Integer postCount = postService.selectAll().size();
        Integer tagCount = tagService.selectAll().size();
        Integer categoryCount = categoryService.selectAll().size();
        Integer comentCount = commentService.selectAll().size();
        modelAndView.addObject("postCount", postCount);
        modelAndView.addObject("tagCount", tagCount);
        modelAndView.addObject("categoryCount", categoryCount);
        modelAndView.addObject("comentCount", comentCount);
        modelAndView.addObject("result", result);

        return modelAndView;
    }

    @GetMapping("/logout")
    public ModelAndView logout() {
        String name = getSession().getAttribute("superName").toString();
        getSession().removeAttribute("superName");
        logService.insert(new Log(name + LogUtils.LOGOUT.getContent(), userService.selectUserByName(name).getId(), getRequest().getRemoteAddr()));

        return new ModelAndView("admin/login");
    }

}