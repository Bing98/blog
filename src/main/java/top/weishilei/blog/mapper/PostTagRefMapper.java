package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.weishilei.blog.domain.PostTagRef;

import java.util.List;

/**
 * 帖子标签映射关系
 * @author weishilei
 */
@Mapper
public interface PostTagRefMapper {
    Integer insert(@Param("postTagRef") List<PostTagRef> postTagRef);

    List<PostTagRef> selectByPostId(Integer id);

    List<PostTagRef> selectByTagId(Integer id);

    Integer deleteByPostId(Integer id);

    Integer deleteByTagId(Integer id);
}
