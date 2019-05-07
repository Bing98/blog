package top.weishilei.blog.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.domain.Tag;
import top.weishilei.blog.service.TagService;

import java.util.List;

/**
 * 标签Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/tag")
public class AdminTagController {
    @Autowired
    private TagService tagService;

    @GetMapping
    public ModelAndView tag(Integer id) {
        ModelAndView modelAndView = new ModelAndView("admin/post/tag");
        List<Tag> list = tagService.selectAll();
        modelAndView.addObject("list", list);
        if (id != null && id > 0) {
            Tag tag = tagService.selectById(id);
            modelAndView.addObject("tag", tag);
        }
        return modelAndView;
    }

    @PostMapping
    @ResponseBody
    public String tag(Tag tag) {
        String name = tag.getName();
        if (StringUtils.isBlank(name)) {
            return Result.failCode("标签名称不能为空！", Result.PARAMTER_IS_EMPTY);
        }
        if (tagService.isExistsByName(name)) {
            return Result.failCode("标签名称已存在！", Result.TAG_NAME_IS_EXISTS);
        }

        tag = tagService.insert(tag);
        boolean isSuccess = tag != null;

        return isSuccess ? Result.success(tag.getId()) : Result.fail();
    }

    @ResponseBody
    @PostMapping("/update")
    public String update(Tag tag) {
        String name = tag.getName();
        if (StringUtils.isBlank(name)) {
            return Result.failCode("分类名称不能为空！", Result.PARAMTER_IS_EMPTY);
        }

        return tagService.update(tag) > 0 ? Result.success() : Result.fail();
    }
    @ResponseBody
    @DeleteMapping
    public String delete(Integer id) {
        if (id == null || id <= 0) {
            return Result.fail();
        }

        boolean isSuccess = tagService.delete(id);
        return isSuccess ? Result.success() : Result.fail();
    }

}
