package top.weishilei.blog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.*;
import top.weishilei.blog.dto.PostParam;
import top.weishilei.blog.service.CategoryService;
import top.weishilei.blog.service.PostService;
import top.weishilei.blog.service.TagService;
import top.weishilei.blog.service.UserService;

import java.util.ArrayList;
import java.util.List;

/**
 * 帖子Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/post")
public class AdminPostController extends BaseController {
    @Autowired
    private TagService tagService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private PostService postService;
    @Autowired
    private UserService userService;

    @GetMapping
    public ModelAndView post(@RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = "10") int size) {
        ModelAndView modelAndView = new ModelAndView("admin/post/post-list");
        PageHelper.startPage(page,size,"id desc");
        List<Post> postList = postService.selectByStatus(1);
        PageInfo<Post> result = new PageInfo<>(postList);
        modelAndView.addObject("result", result);

        return modelAndView;
    }

    @PostMapping
    @ResponseBody
    public String post(PostParam postParam) {
        String msg = verify(postParam, false);
        if (msg != "success") {
            return msg;
        }

        assemblyPostParam(postParam);
        Post post = postService.insert(postParam);
        boolean isSuccess = post != null;

        return isSuccess ? Result.success(post.getId()) : Result.fail();
    }

    @GetMapping("writer")
    public ModelAndView writer(Integer id) {
        ModelAndView modelAndView = new ModelAndView("admin/post/post-writer");
        List<Tag> tagList = tagService.selectAll();
        List<Category> categoryList = categoryService.selectAll();
        modelAndView.addObject("tagList", tagList);
        modelAndView.addObject("categoryList", categoryList);
        Post post = postService.selecyById(id);
        if (post != null) {
            modelAndView.addObject("post", post);
        }
        return modelAndView;
    }

    @DeleteMapping
    @ResponseBody
    public String delete(String id) {
        if (StringUtils.isBlank(id)) {
            return Result.failCode("参数为空！", Result.PARAMTER_IS_EMPTY);
        }

        String[] array = id.split(",");
        List<Integer> ids = new ArrayList<>();
        for (String str : array) {
            try {
                ids.add(Integer.valueOf(str));
            } catch (Exception e) {
                continue;
            }
        }
        if (ids.size() > 0) {
            postService.deleteById(ids);
        }

        return Result.success();
    }

    @GetMapping("/draftBox")
    public ModelAndView draftBox(@RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "size", defaultValue = "10") int size) {
        ModelAndView modelAndView = new ModelAndView("admin/post/draftBox");
        PageHelper.startPage(page,size,"id desc");
        List<Post> postList = postService.selectByStatus(2);
        PageInfo<Post> result = new PageInfo<>(postList);
        modelAndView.addObject("result", result);

        return modelAndView;
    }

    @ResponseBody
    @GetMapping("/updateStatus")
    public String updateStatus(String id, Integer status) {
        if (StringUtils.isBlank(id) || status == null || (status != 1 && status != 2)) {
            return Result.failCode("参数不正确！", Result.PARAMTER_IS_NOT_RIGHT);
        }
        List<Integer> ids = new ArrayList<>();
        String[] array = id.split(",");
        for (String str : array) {
            try {
                ids.add(Integer.valueOf(str));
            } catch (Exception e) {
                continue;
            }
        }
        boolean isSuccess = postService.updateStatus(ids, status) > 0;

        return isSuccess ? Result.success() : Result.fail();
    }

    @ResponseBody
    @PostMapping("/update")
    public String update(PostParam postParam) {
        String msg = verify(postParam, true);
        if (msg != "success") {
            return msg;
        }
        assemblyPostParam(postParam);

        return postService.update(postParam) > 0 ? Result.success() : Result.fail();
    }

    /**
     * 组装PostParam
     * @param postParam
     */
    private void assemblyPostParam(PostParam postParam) {
        String name = getSession().getAttribute("superName").toString();
        User user = userService.selectUserByName(name);
        postParam.setAuthor(name);
        postParam.setUserId(user.getId());
    }

    /**
     * 验证PostParam
     * @param postParam
     * @return
     */
    private String verify(PostParam postParam, boolean isUpdate) {
        String title = postParam.getTitle();
        Integer status = postParam.getStatus();
        if (StringUtils.isBlank(title) || status == null) {
            return Result.failCode("参数不能为空！", Result.PARAMTER_IS_EMPTY);
        }
        if (!isUpdate) {
            if (postService.isExistsByTitle(title)) {
                return Result.failCode("标题存在！", Result.POST_TITLE_IS_EXISTS);
            }
        }
        if (status != 1 && status != 2) {
            return Result.failCode("参数不正确！", Result.PARAMTER_IS_NOT_RIGHT);
        }

        return "success";
    }
}
