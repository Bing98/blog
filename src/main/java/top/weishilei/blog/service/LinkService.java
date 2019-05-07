package top.weishilei.blog.service;

import top.weishilei.blog.domain.Link;

import java.util.List;

/**
 * 友情链接Service
 * @author weishilei
 */
public interface LinkService {
    /**
     * 新增
     * @param link
     * @return
     */
    Integer insert(Link link);

    /**
     * 查询全部
     * @return
     */
    List<Link> select();

    /**
     * 根据状态查询
     * @param status
     * @return
     */
    List<Link> selectByStatus(Integer status);

    /**
     * 修改状态
     * @param status
     * @param ids
     * @return
     */
    Integer updateByStatus(Integer status, List<Integer> ids);

    /**
     * 根据id删除
     * @param ids
     * @return
     */
    Integer delete(List<Integer> ids);
}
