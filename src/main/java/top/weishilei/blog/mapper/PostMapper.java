package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.weishilei.blog.domain.Post;

import java.util.List;

/**
 * 帖子Mapper
 * @author weishilei
 */
@Mapper
public interface PostMapper {
    Integer insert(Post post);

    Integer deleteById(@Param("ids") List<Integer> ids);

    Integer update(Post post);

    Integer updateStatus(@Param("ids") List<Integer> ids, @Param("status") Integer status);

    List<Post> selectAll();

    List<Post> selectByStatus(Integer status);

    Post selectById(Integer id);

    Post selectByTitle(String title);

    Integer updateViewCount(@Param("id") Integer id, @Param("viewCount") Integer viewCount);

    Integer updateCommentCount(@Param("id") Integer id, @Param("commentCount") Integer commentCount);

    List<String> selectYear();

    List<Post> selectByYear(String year);

    List<Post> selectByIds(@Param("ids") List<Integer> ids);

    List<Post> selectRecentPost();

    List<Post> selectSearchByTitle(String keyword);
}
