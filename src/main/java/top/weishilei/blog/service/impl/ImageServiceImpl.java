package top.weishilei.blog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Image;
import top.weishilei.blog.mapper.ImageMapper;
import top.weishilei.blog.service.ImageService;

import java.util.List;

/**
 * 图片Service实现类
 * @author weishilei
 */
@Service
public class ImageServiceImpl implements ImageService {
    @Autowired
    private ImageMapper imageMapper;

    @Override
    public List<Image> select() {
        return imageMapper.select();
    }

    @Override
    public Integer insert(Image image) {
        if (image == null) {
            return 0;
        }

        return imageMapper.insert(image);
    }

    @Override
    public Integer delete(Integer id) {
        if (id == null || id < 1) {
            return 0;
        }

        return imageMapper.delete(id);
    }
}
