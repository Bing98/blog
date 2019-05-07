package top.weishilei.blog.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Tag;
import top.weishilei.blog.mapper.PostTagRefMapper;
import top.weishilei.blog.mapper.TagMapper;
import top.weishilei.blog.service.TagService;

import java.util.List;

/**
 * 标签Service实现类
 * @author weishilei
 */
@Service
public class TagServiceImpl implements TagService {
    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private PostTagRefMapper postTagRefMapper;

    @Override
    public Tag insert(Tag tag) {
        if (tag == null || isExistsByName(tag.getName())) {
            return null;
        }

        tagMapper.insert(tag);
        return tag;
    }

    @Override
    public List<Tag> selectAll() {
        List<Tag> list = tagMapper.selectAll();
        for (Tag t : list) {
            assembly(t);
        }

        return list;
    }

    @Override
    public Tag selectById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }

        Tag tag = tagMapper.selectById(id);
        assembly(tag);
        return tag;
    }

    @Override
    public Boolean delete(Integer id) {
        if (id == null || id <= 0) {
            return false;
        }

        postTagRefMapper.deleteByTagId(id);
        return tagMapper.delete(id) == 1;
    }

    @Override
    public Boolean isExistsByName(String name) {
        return tagMapper.selectByName(name) != null;
    }

    @Override
    public Integer update(Tag tag) {
        if (tag == null) {
            return 0;
        }

        return tagMapper.update(tag);
    }

    @Override
    public Tag selectByName(String name) {
        if (StringUtils.isBlank(name)) {
            return null;
        }

        return tagMapper.selectByName(name);
    }

    /**
     * 组装Tag
     * @param tag
     */
    private void assembly(Tag tag) {
        int id = tag.getId();
        int size = postTagRefMapper.selectByTagId(id).size();
        tag.setPostNumber(size);
    }
}
