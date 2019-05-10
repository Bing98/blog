package top.weishilei.blog.controller.home;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.*;
import top.weishilei.blog.mapper.PostCategoryRefMapper;
import top.weishilei.blog.mapper.PostTagRefMapper;
import top.weishilei.blog.service.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 主页Controller
 * @author weishilei
 */
@Controller
public class HomeController extends BaseController {
    @Autowired
    private PostService postService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private TagService tagService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private PostTagRefMapper postTagRefMapper;
    @Autowired
    private PostCategoryRefMapper postCategoryRefMapper;
    @Autowired
    private LinkService linkService;
    @Autowired
    private BannerService bannerService;

    @GetMapping("/index")
    public ModelAndView index(@RequestParam(value = "page", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = "10") int size) {
        ModelAndView modelAndView = new ModelAndView("home/index");
        setResponseHomeData(modelAndView, page, size);
        modelAndView.addObject("bannerList", bannerService.selectOrderBySort());

        return modelAndView;
    }

    @GetMapping("/link")
    public ModelAndView link() {
        ModelAndView modelAndView = new ModelAndView("home/link");
        setResponseCommonData(modelAndView);
        List<Link> result = linkService.selectByStatus(2);
        modelAndView.addObject("result", result);

        return modelAndView;
    }

    @GetMapping("/about")
    public ModelAndView about(@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        ModelAndView modelAndView = new ModelAndView("home/about");
        List<Post> aboutPostList = postService.selectByStatus(3);
        Post aboutPost = new Post();
        modelAndView.addObject("result", null);
        if (aboutPostList != null && aboutPostList.size() > 0) {
            aboutPost = aboutPostList.get(0);
            PageHelper.startPage(page,size,"id desc");

            List<Comment> commentList = commentService.selectByPostIdAndStatus(aboutPost.getId(), 1);
            PageInfo<Comment> result = new PageInfo<>(commentList);
            modelAndView.addObject("result", result);
        }
        modelAndView.addObject("aboutPost", aboutPost);
        setResponseCommonData(modelAndView);

        return modelAndView;
    }


    @GetMapping("/search")
    public ModelAndView search(String keyword,
                               @RequestParam(value = "page", defaultValue = "1") int page,
                               @RequestParam(value = "size", defaultValue = "10") int size) {
        ModelAndView modelAndView = new ModelAndView("home/search");
        if (StringUtils.isBlank(keyword)) {
            setResponseHomeData(modelAndView, page, size);
            return modelAndView;
        }
        PageHelper.startPage(page,size,"id desc");
        List<Post> postList = postService.selectSearchByTitle(keyword);
        PageInfo<Post> result = new PageInfo<>(postList);
        modelAndView.addObject("result", result);
        getRequest().setAttribute("keyword", keyword);
        setResponseCommonData(modelAndView);

        return modelAndView;
    }

    @GetMapping("/archives")
    public ModelAndView archives(String date) {
        if (StringUtils.isBlank(date)) {
            return new ModelAndView("redirect:/index");
        }

        List<Post> result = postService.selectByYear(date);
        ModelAndView modelAndView = new ModelAndView("home/tag_category_archives");
        getRequest().setAttribute("name", date);
        modelAndView.addObject("type", "Archives");
        modelAndView.addObject("result", result);
        setResponseCommonData(modelAndView);

        return modelAndView;
    }

    @GetMapping("/detail")
    public ModelAndView detail(Integer id,
                               @RequestParam(value = "page", defaultValue = "1") int page,
                               @RequestParam(value = "size", defaultValue = "10") int size) {
        if (id == null || id < 1 || postService.selecyById(id) == null) {
            return new ModelAndView("redirect:/index");
        }

        ModelAndView modelAndView = new ModelAndView("home/detail");
        PageHelper.startPage(page,size,"id desc");
        List<Comment> commentList = commentService.selectByPostIdAndStatus(id, 1);
        PageInfo<Comment> result = new PageInfo<>(commentList);
        Post post = postService.selecyById(id);
        postService.updateViewCount(id, post.getViewCount() + 1);
        modelAndView.addObject("post", post);
        modelAndView.addObject("result", result);
        setResponseDetailData(modelAndView, id);

        return modelAndView;
    }

    @GetMapping("/tag")
    public ModelAndView tag(String name) {
        if (StringUtils.isBlank(name)) {
            return new ModelAndView("redirect:/index");
        }
        Tag tag = tagService.selectByName(name);
        if (tag == null) {
            return new ModelAndView("redirect:/index");
        }

        List<PostTagRef> postTagRefList = postTagRefMapper.selectByTagId(tag.getId());
        List<Post> result = new ArrayList<>();
        for (PostTagRef postTagRef : postTagRefList) {
            Integer id = postTagRef.getPostId();
            Post post = postService.selecyById(id);
            result.add(post);
        }

        getRequest().setAttribute("name", name);
        ModelAndView modelAndView = new ModelAndView("home/tag_category_archives");
        modelAndView.addObject("result", result);
        modelAndView.addObject("type", "Tag");
        setResponseCommonData(modelAndView);

        return modelAndView;
    }

    @GetMapping("/category")
    public ModelAndView category(String name) {
        if (StringUtils.isBlank(name)) {
            return new ModelAndView("redirect:/index");
        }
        Category category = categoryService.selectByName(name);
        if (category == null) {
            return new ModelAndView("redirect:/index");
        }

        List<PostCategoryRef> postCategoryRefList = postCategoryRefMapper.selectByCategoryId(category.getId());
        List<Post> result = new ArrayList<>();
        for (PostCategoryRef postCategoryRef : postCategoryRefList) {
            Integer id = postCategoryRef.getPostId();
            Post post = postService.selecyById(id);
            result.add(post);
        }

        getRequest().setAttribute("name", name);
        ModelAndView modelAndView = new ModelAndView("home/tag_category_archives");
        modelAndView.addObject("result", result);
        modelAndView.addObject("type", "Category");
        setResponseCommonData(modelAndView);

        return modelAndView;
    }

    /**
     * 设置通用数据
     * @param modelAndView
     */
    private void setResponseCommonData(ModelAndView modelAndView) {
        List<Tag> tagList = tagService.selectAll();
        List<Category> categoryList = categoryService.selectAll();
        List<String> year = postService.selectYear();
        List<Post> recentPost = postService.selectRecentPost();

        modelAndView.addObject("tagList", tagList);
        modelAndView.addObject("categoryList", categoryList);
        modelAndView.addObject("year", year);
        modelAndView.addObject("recentPost", recentPost);
    }

    /**
     * 设置帖子详细需要的数据
     * @param modelAndView
     * @param id
     */
    private void setResponseDetailData(ModelAndView modelAndView, Integer id) {
        List<Comment> comments = commentService.selectByPostId(id);
        modelAndView.addObject("comments", comments);
        setResponseCommonData(modelAndView);
    }

    /**
     * 设置主页需要的数据
     * @param modelAndView
     * @param page
     * @param size
     */
    private void setResponseHomeData(ModelAndView modelAndView, int page, int size) {
        PageHelper.startPage(page,size,"id desc");
        List<Post> postList = postService.selectByStatus(1);
        PageInfo<Post> result = new PageInfo<>(postList);
        modelAndView.addObject("result", result);
        setResponseCommonData(modelAndView);
    }

}