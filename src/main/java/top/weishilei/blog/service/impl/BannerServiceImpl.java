package top.weishilei.blog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Banner;
import top.weishilei.blog.mapper.BannerMapper;
import top.weishilei.blog.service.BannerService;

import java.util.List;

/**
 * 横幅图Service实现类
 * @author weishilei
 */
@Service
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerMapper bannerMapper;

    @Override
    public List<Banner> selectOrderBySort() {
        return bannerMapper.selectOrderBySort();
    }

    @Override
    public Integer update(Banner banner) {
        if (banner == null) {
            return 0;
        }

        return bannerMapper.update(banner);
    }

    @Override
    public Integer delete(Integer id) {
        if (id == null || id < 1) {
            return 0;
        }

        return bannerMapper.delete(id);
    }

    @Override
    public Integer insert(Banner banner) {
        if (banner == null) {
            return null;
        }

        return bannerMapper.insert(banner);
    }

    @Override
    public Integer deleteByImageId(Integer id) {
        if (id == null || id < 1) {
            return 0;
        }

        return bannerMapper.deleteByImageId(id);
    }

    @Override
    public Integer deleteByPostId(Integer id) {
        if (id == null || id < 1) {
            return 0;
        }

        return bannerMapper.deleteByPostId(id);
    }

    @Override
    public Banner selectById(Integer id) {
        if (id == null || id < 1) {
            return null;
        }

        return bannerMapper.selectById(id);
    }
}
