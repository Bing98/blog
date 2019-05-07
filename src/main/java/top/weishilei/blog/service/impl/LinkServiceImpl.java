package top.weishilei.blog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Link;
import top.weishilei.blog.mapper.LinkMapper;
import top.weishilei.blog.service.LinkService;

import java.util.List;

/**
 * 友情链接Service实现类
 * @author weishilei
 */
@Service
public class LinkServiceImpl implements LinkService {
    @Autowired
    private LinkMapper linkMapper;

    @Override
    public Integer insert(Link link) {
        if (link == null) {
            return 0;
        }

        return linkMapper.insert(link);
    }

    @Override
    public List<Link> select() {
        return linkMapper.select();
    }

    @Override
    public List<Link> selectByStatus(Integer status) {
        if (status == null || (status != 1 && status != 2)) {
            return null;
        }

        return linkMapper.selectByStatus(status);
    }

    @Override
    public Integer updateByStatus(Integer status, List<Integer> ids) {
        if (status == null || (status != 1 && status != 2) || ids == null || ids.size() < 1) {
            return null;
        }

        return linkMapper.updateByStatus(status, ids);
    }

    @Override
    public Integer delete(List<Integer> ids) {
        if (ids == null || ids.size() < 1) {
            return 0;
        }

        return linkMapper.delete(ids);
    }
}
