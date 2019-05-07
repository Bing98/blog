package top.weishilei.blog.controller.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.domain.User;
import top.weishilei.blog.service.UserService;

/**
 * 用户Controller
 * @author weishilei
 */
@Controller
public class UserController extends BaseController {
    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public ModelAndView login() {
        return new ModelAndView("home/user/login");
    }

    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("home/user/register");
    }

    @ResponseBody
    @PostMapping("/register")
    public String register(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        String email = user.getEmail();
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password) || StringUtils.isBlank(email)) {
            return Result.failCode("参数不能为空！", Result.PARAMTER_IS_EMPTY);
        }
        if (userService.isExistsUserByName(username)) {
            return Result.failCode("用户名称已存在！", Result.USER_NAME_IS_EXISTS);
        }
        if (userService.isExistsUserByEmail(email)) {
            return Result.failCode("邮箱已存在！", Result.USER_EMAIL_IS_EXISTS);
        }

        return userService.insertUser(user) ? Result.success() : Result.fail();
    }

    @ResponseBody
    @PostMapping("/login")
    public String login(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            return Result.failCode("参数不能为空！", Result.PARAMTER_IS_EMPTY);
        }

        int id = userService.verifyUser(username, password);
        if (id < 0) {
            return Result.failCode("用户名或密码错误！", Result.USER_LOGIN_FAIL);
        }

        getSession().setAttribute("username", username);
        return Result.success();
    }

    @GetMapping("/logout")
    public ModelAndView logout() {
        getSession().removeAttribute("username");
        return new ModelAndView("redirect:/index");
    }
}
