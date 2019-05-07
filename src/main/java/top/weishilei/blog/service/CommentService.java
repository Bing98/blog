package top.weishilei.blog.service;

import top.weishilei.blog.domain.Comment;
import java.util.List;

/**
 * 留言Service
 */
public interface CommentService {
    /**
     * 根据帖子id查找
     * @param id
     * @return
     */
    List<Comment> selectByPostId(Integer id);

    /**
     * 新增
     * @param comment
     * @return
     */
    Integer insert(Comment comment);

    /**
     * 修改状态
     * @param status
     * @param ids
     * @return
     */
    Integer updateStatus(Integer status, List<Integer> ids);

    /**
     * 根据帖子id和状态查询留言
     * @param id
     * @param status
     * @return
     */
    List<Comment> selectByPostIdAndStatus(Integer id, Integer status);

    /**
     * 根据帖子id查询
     * @param id
     * @return
     */
    Comment selectById(Integer id);

    /**
     * 根据id删除留言
     * @param ids
     * @return
     */
    Integer delete(List<Integer> ids);

    /**
     * 显示全部留言
     * @return
     */
    List<Comment> selectAll();

    /**
     * 根据状态查询留言
     * @param status
     * @return
     */
    List<Comment> selectByStatus(Integer status);
}
