package top.weishilei.blog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Comment;
import top.weishilei.blog.domain.Post;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.impl.CommentServiceImpl;
import top.weishilei.blog.service.impl.PostServiceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 留言管理
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/comment")
public class AdminCommentController extends BaseController {
    @Autowired
    private PostServiceImpl postService;
    @Autowired
    private CommentServiceImpl commentService;

    /**
     * 显示留言
     * @param page
     * @param size
     * @param id 帖子id
     * @param showType 显示类型，2：未审核，1：已审核，3：显示全部
     * @return
     */
    @GetMapping
    @RequestMapping
    public ModelAndView comment(@RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "10") int size,
                                @RequestParam(defaultValue = "3") Integer showType,
                                @RequestParam(defaultValue = "-1") Integer id) {
        ModelAndView modelAndView = new ModelAndView("admin/comment/comment");
        List<Post> postList = postService.selectByStatus(1);
        postList.addAll(postService.selectByStatus(3));
        modelAndView.addObject("postList", postList);
        PageHelper.startPage(page,size, "id desc");

        List<Comment> commentList = null;
        if (id == -1 && showType == 3) {//查询全部
            commentList = commentService.selectAll();
        } else if (id != -1 && showType == 3) {//根据帖子id查询
            commentList = commentService.selectByPostId(id);
        } else if (id != -1 && showType != 3) {//根据帖子id和状态查询
            commentList = commentService.selectByPostIdAndStatus(id, showType);
        } else if (id == -1 && showType != 3) {//根据状态查询
            commentList = commentService.selectByStatus(showType);
        }

        getRequest().setAttribute("postId", id);
        getRequest().setAttribute("showType", showType);
        PageInfo<Comment> result = new PageInfo<>(commentList);
        modelAndView.addObject("result", result);
        getRequest().setAttribute("id", id);
        getRequest().setAttribute("showType", showType);

        return modelAndView;
    }

    @ResponseBody
    @GetMapping("/updateStatus")
    public String update(String ids) {
        List<Integer> idList = arrayToList(ids);
        if (idList == null) {
            return Result.fail();
        }

        boolean isSuccess = commentService.updateStatus(1, idList) > 0;
        if (isSuccess) {
            Map<Integer, Integer> idCommentCount = new HashMap<>();
            for (Integer id : idList) {
                Integer postId = commentService.selectById(id).getPostId();
                if (idCommentCount.containsKey(postId)) {
                    Integer count = idCommentCount.get(postId);
                    idCommentCount.put(postId, ++count);
                } else {
                    idCommentCount.put(postId, 1);
                }
            }

            for (Integer id : idCommentCount.keySet()) {
                Post post = postService.selecyById(id);
                Integer count = idCommentCount.get(id);
                postService.updateCommentCount(post.getId(), post.getCommentCount() + count);
            }
        }

        return isSuccess ? Result.success() : Result.fail();
    }

    @ResponseBody
    @GetMapping("/delete")
    public String delete(String ids) {
        List<Integer> idList = arrayToList(ids);
        if (idList == null) {
            return Result.fail();
        }

        for (Integer id : idList) {
            try {
                List<Integer> temp = new ArrayList<>();
                temp.add(id);
                Integer postId = commentService.selectById(id).getPostId();
                Integer count = postService.selecyById(postId).getCommentCount();
                boolean isSuccess = commentService.delete(temp) > 0;
                if (isSuccess) {
                    postService.updateCommentCount(postId, --count);
                }
            } catch (Exception e) {
                continue;
            }
        }

        return Result.success();
    }
}
