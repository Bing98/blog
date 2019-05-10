package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.weishilei.blog.domain.Banner;

import java.util.List;

/**
 * 横幅图Mapper
 * @author weishilei
 */
@Mapper
public interface BannerMapper {
    List<Banner> selectOrderBySort();

    Integer update(Banner banner);

    Integer delete(Integer id);

    Integer deleteByImageId(Integer id);

    Integer deleteByPostId(Integer id);

    Integer insert(Banner banner);

    Banner selectById(Integer id);
}
