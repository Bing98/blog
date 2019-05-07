package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.weishilei.blog.domain.Image;

import java.util.List;

/**
 * 图片Mapper
 * @author weishilei
 */
@Mapper
public interface ImageMapper {
    List<Image> select();
    
    Integer insert(Image image);

    Integer delete(Integer id);
}
