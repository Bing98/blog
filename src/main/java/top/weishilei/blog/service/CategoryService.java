package top.weishilei.blog.service;

import top.weishilei.blog.domain.Category;

import java.util.List;

/**
 * 分类Service
 * @author weishilei
 */
public interface CategoryService {
    /**
     * 插入
     * @param category
     * @return
     */
    Category insert(Category category);

    /**
     * 查询全部
     * @return
     */
    List<Category> selectAll();

    /**
     * 根据id查询
     * @param id
     * @return
     */
    Category selectById(Integer id);

    /**
     * 删除
     * @param id
     * @return
     */
    Boolean delete(Integer id);

    /**
     * 根据名称查询
     * @param name
     * @return
     */
    Boolean isExistsByName(String name);

    /**
     * 修改
     * @param category
     * @return
     */
    Integer update(Category category);

    /**
     * 根据名称查找
     * @param name
     * @return
     */
    Category selectByName(String name);
}
