package top.weishilei.blog.service;

import top.weishilei.blog.domain.Banner;

import java.util.List;

/**
 * 横幅图Service
 * @author weishilei
 */
public interface BannerService {
    List<Banner> selectOrderBySort();

    Integer update(Banner banner);

    Integer delete(Integer id);

    Integer insert(Banner banner);

    Integer deleteByImageId(Integer id);

    Integer deleteByPostId(Integer id);

    Banner selectById(Integer id);
}
