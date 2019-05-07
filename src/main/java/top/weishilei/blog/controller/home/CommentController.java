package top.weishilei.blog.controller.home;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Comment;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.CommentService;

/**
 * 留言Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/comment")
public class CommentController extends BaseController {
    @Autowired
    private CommentService commentService;

    @PostMapping
    @ResponseBody
    public String comment(Comment comment) {
        Integer postId = comment.getPostId();
        if (postId == null || postId < 1) {
            return Result.fail("未知错误！");
        }
        String name = comment.getName();
        if (StringUtils.isBlank(name)) {
            return Result.fail("姓名不能为空!");
        }
        String email = comment.getEmail();
        if (StringUtils.isBlank(email)) {
            return Result.fail("邮箱不能为空！");
        }
        String content = comment.getContent();
        if (StringUtils.isBlank(content)) {
            return Result.fail("内容不能为空！");
        }
        comment.setIp(getIpAddr());
        boolean isSuccess = commentService.insert(comment) > 0;

        return isSuccess ? Result.success() : Result.fail();
    }
}
