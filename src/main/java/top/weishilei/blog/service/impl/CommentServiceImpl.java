package top.weishilei.blog.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Comment;
import top.weishilei.blog.mapper.CommentMapper;
import top.weishilei.blog.service.CommentService;
import top.weishilei.blog.utils.CommonUtils;

import java.util.Date;
import java.util.List;

/**
 * 留言Service实现类
 * @author weishilei
 */
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<Comment> selectByPostId(Integer id) {
        if (id == null || id < 1) {
            return null;
        }

        return commentMapper.selectByPostId(id);
    }

    @Override
    public Integer insert(Comment comment) {
        if (comment == null) {
            return 0;
        }

        assemblyComment(comment);
        return commentMapper.insert(comment);
    }

    @Override
    public Integer updateStatus(Integer status, List<Integer> ids) {
        if (ids == null || ids.size() < 1 || (status != 1 && status != 2)) {
            return 0;
        }

        return commentMapper.updateStatus(status, ids);
    }

    @Override
    public List<Comment> selectByPostIdAndStatus(Integer id, Integer status) {
        if (id == null || id < 1 || (status != 1 && status != 2)) {
            return null;
        }

        return commentMapper.selectByPostIdAndStatus(id, status);
    }

    @Override
    public Comment selectById(Integer id) {
        if (id == null || id < 1) {
            return null;
        }

        return commentMapper.selectById(id);
    }

    @Override
    public Integer delete(List<Integer> ids) {
        if (ids == null || ids.size() < 1) {
            return 0;
        }

        return commentMapper.delete(ids);
    }

    @Override
    public List<Comment> selectAll() {
        return commentMapper.selectAll();
    }

    @Override
    public List<Comment> selectByStatus(Integer status) {
        if (status == null || (status != 1 && status != 2)) {
            return null;
        }

        return commentMapper.selectByStatus(status);
    }

    /**
     * 组装Comment，防止Xss攻击
     * @param comment
     */
    private void assemblyComment(Comment comment) {
        comment.setStatus(2);
        comment.setCreateTime(new Date());
        String content = comment.getContent();

        Integer pid = comment.getPid();
        if (pid > 0) {
            Comment pComment = selectById(pid);
            String pContent = pComment.getContent();
            String pName = pComment.getName();
            String ele = String.format("<blockquote class='layui-elem-quote layui-quote-nm'>回复<a href='#%d'>%s</a>的留言：<br>%s</blockquote>",pid, pName, pContent);
            content = ele + "<br>" + content;
        }

        content = CommonUtils.preventXss(content.replace("\n", "<br>"));
        comment.setContent(content);

        String name = CommonUtils.preventXss(comment.getName());
        comment.setName(name);

        String email = CommonUtils.preventXss(comment.getEmail());
        comment.setEmail(email);

        String url = comment.getUrl();
        if (!StringUtils.isBlank(url)) {
            comment.setUrl(CommonUtils.preventXss(url));
        }
    }
}
