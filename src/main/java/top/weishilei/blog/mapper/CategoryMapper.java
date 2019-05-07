package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.weishilei.blog.domain.Category;

import java.util.List;

/**
 * 分类Mapper
 * @author weishilei
 */
@Mapper
public interface CategoryMapper {
    Category selectByName(String name);

    Integer insert(Category category);

    Integer delete(Integer id);

    Integer update(Category category);

    List<Category> selectAll();

    Category selectById(Integer id);
}
