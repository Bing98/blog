package top.weishilei.blog.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.domain.Category;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.CategoryService;

import java.util.List;

/**
 * 分类Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/category")
public class AdminCategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public ModelAndView category(Integer id) {
        ModelAndView modelAndView = new ModelAndView("admin/post/category");
        List<Category> list = categoryService.selectAll();
        modelAndView.addObject("list", list);
        if (id != null && id > 0) {
            Category category = categoryService.selectById(id);
            modelAndView.addObject("category", category);
        }

        return modelAndView;
    }

    @PostMapping
    @ResponseBody
    public String category(Category category) {
        String name = category.getName();
        if (StringUtils.isBlank(name)) {
            return Result.failCode("分类名称不能为空！", Result.PARAMTER_IS_EMPTY);
        }
        if (categoryService.isExistsByName(name)) {
            return Result.failCode("分类名称已存在！", Result.CATEGORY_NAME_IS_EXISTS);
        }

        category = categoryService.insert(category);
        boolean isSuccess = category != null;
        return isSuccess ? Result.success(category.getId()) : Result.fail();
    }

    @ResponseBody
    @PostMapping("/update")
    public String update(Category category) {
        String name = category.getName();
        if (StringUtils.isBlank(name)) {
            return Result.failCode("分类名称不能为空！", Result.PARAMTER_IS_EMPTY);
        }

        return categoryService.update(category) > 0 ? Result.success() : Result.fail();
    }

    @ResponseBody
    @DeleteMapping
    public String delete(Integer id) {
        if (id == null || id <= 0) {
            return Result.fail();
        }

        boolean isSuccess = categoryService.delete(id);
        return isSuccess ? Result.success() : Result.fail();
    }

}
