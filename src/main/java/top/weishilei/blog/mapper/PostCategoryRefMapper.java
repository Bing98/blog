package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.weishilei.blog.domain.PostCategoryRef;

import java.util.List;

/**
 * 帖子分类映射关系
 * @author weishilei
 */
@Mapper
public interface PostCategoryRefMapper {
    Integer insert(@Param("postCategoryRef") List<PostCategoryRef> postCategoryRef);

    List<PostCategoryRef> selectByPostId(Integer id);

    List<PostCategoryRef> selectByCategoryId(Integer id);

    Integer deleteByPostId(Integer id);

    Integer deleteByCategoryId(Integer id);
}
