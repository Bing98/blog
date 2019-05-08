package top.weishilei.blog.service;

import top.weishilei.blog.domain.Image;

import java.util.List;

/**
 * 图片Service
 */
public interface ImageService {
    /**
     * 查询全部
     * @return
     */
    List<Image> select();

    /**
     * 新增图片
     * @param image
     * @return
     */
    Integer insert(Image image);

    /**
     * 根据id删除
     * @param id
     * @return
     */
    Integer delete(Integer id);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    Image selectById(Integer id);
}
