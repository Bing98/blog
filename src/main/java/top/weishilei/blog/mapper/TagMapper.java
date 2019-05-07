package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.weishilei.blog.domain.Tag;

import java.util.List;

/**
 * 标签Mapper
 * @author weishilei
 */
@Mapper
public interface TagMapper {
    Tag selectByName(String name);

    Integer insert(Tag tag);

    Integer delete(Integer id);

    Integer update(Tag tag);

    List<Tag> selectAll();

    Tag selectById(Integer id);
}
