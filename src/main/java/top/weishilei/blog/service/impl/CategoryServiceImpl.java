package top.weishilei.blog.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Category;
import top.weishilei.blog.mapper.CategoryMapper;
import top.weishilei.blog.mapper.PostCategoryRefMapper;
import top.weishilei.blog.service.CategoryService;

import java.util.List;

/**
 * 分类Service实现类
 * @author weishilei
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private PostCategoryRefMapper postCategoryRefMapper;

    @Override
    public Category insert(Category category) {
        if (category == null || isExistsByName(category.getName())) {
            return null;
        }

        categoryMapper.insert(category);
        return category;
    }

    @Override
    public List<Category> selectAll() {
        List<Category> list = categoryMapper.selectAll();
        for (Category c : list) {
            assembly(c);
        }

        return list;
    }

    @Override
    public Category selectById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }

        Category category = categoryMapper.selectById(id);
        assembly(category);

        return category;
    }

    @Override
    public Boolean delete(Integer id) {
        if (id == null || id <= 0) {
            return false;
        }

        postCategoryRefMapper.deleteByCategoryId(id);
        return categoryMapper.delete(id) == 1;
    }

    @Override
    public Boolean isExistsByName(String name) {
        return categoryMapper.selectByName(name) != null;
    }

    @Override
    public Integer update(Category category) {
        if (category == null) {
            return 0;
        }

        return categoryMapper.update(category);
    }

    @Override
    public Category selectByName(String name) {
        if (StringUtils.isBlank(name)) {
            return null;
        }

        return categoryMapper.selectByName(name);
    }

    /**
     * 组装Category
     * @param category
     */
    private void assembly(Category category) {
        int id = category.getId();
        int size = postCategoryRefMapper.selectByCategoryId(id).size();
        category.setPostNumber(size);
    }
}
