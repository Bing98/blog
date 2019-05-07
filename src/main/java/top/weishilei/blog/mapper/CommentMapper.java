package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.weishilei.blog.domain.Comment;

import java.util.List;

/**
 * 留言Mapper
 * @author weishilei
 */
@Mapper
public interface CommentMapper {
    List<Comment> selectByPostId(Integer id);

    List<Comment> selectByPostIdAndStatus(@Param("id") Integer id, @Param("status") Integer status);

    List<Comment> selectByStatus(Integer status);

    Comment selectById(Integer id);

    Integer insert(Comment comment);

    Integer updateStatus(@Param("status") Integer status, @Param("ids") List<Integer> ids);

    Integer deleteByPostId(Integer id);

    Integer delete(@Param("ids") List<Integer> ids);

    List<Comment> selectAll();
}
