package top.weishilei.blog.service;

import top.weishilei.blog.domain.Tag;

import java.util.List;

/**
 * 标签Service
 * @author weishilei
 */
public interface TagService {
    /**
     * 插入
     * @param tag
     * @return
     */
    Tag insert(Tag tag);

    /**
     * 查询全部
     * @return
     */
    List<Tag> selectAll();

    /**
     * 根据id查询
     * @param id
     * @return
     */
    Tag selectById(Integer id);

    /**
     * 删除
     * @param id
     * @return
     */
    Boolean delete(Integer id);

    /**
     * 根据名称查找
     * @param name
     * @return
     */
    Boolean isExistsByName(String name);

    /**
     * 修改
     * @param tag
     * @return
     */
    Integer update(Tag tag);

    /**
     * 根据名称查找
     * @param name
     * @return
     */
    Tag selectByName(String name);
}
