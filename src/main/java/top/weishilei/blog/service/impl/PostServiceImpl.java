package top.weishilei.blog.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.*;
import top.weishilei.blog.dto.PostParam;
import top.weishilei.blog.mapper.*;
import top.weishilei.blog.service.PostService;

import java.util.ArrayList;
import java.util.List;

/**
 * 帖子Service实现类
 * @author weishilei
 */
@Service
public class PostServiceImpl implements PostService {
    @Autowired
    private PostMapper postMapper;
    @Autowired
    private PostCategoryRefMapper postCategoryRefMapper;
    @Autowired
    private PostTagRefMapper postTagRefMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private BannerMapper bannerMapper;

    @Override
    public Post selectByTitle(String title) {
        if (StringUtils.isBlank(title)) {
            return null;
        }

        Post post = postMapper.selectByTitle(title);
        if (post != null) {
            Integer id = post.getId();
            post.setTags(selectTagByPostId(id));
            post.setCategoryes(selectCategoryByPostId(id));
        }

        return post;
    }

    @Override
    public Post insert(PostParam postParam) {
        String title = postParam.getTitle();
        Integer status = postParam.getStatus();
        if (StringUtils.isBlank(title) || status == null || (status != 1 && status != 2)) {
            return null;
        }
        Post post = assemblyPost(postParam);
        postMapper.insert(post);
        insertTagAndCategory(postParam, post.getId());

        return post;
    }

    @Override
    public Boolean isExistsByTitle(String name) {
        return postMapper.selectByTitle(name) != null;
    }

    @Override
    public List<Post> selectAll() {
        return postMapper.selectAll();
    }

    @Override
    public Integer deleteById(List<Integer> ids) {
        if (ids == null || ids.size() < 1) {
            return 0;
        }

        for (Integer id : ids) {
            postTagRefMapper.deleteByPostId(id);
            postCategoryRefMapper.deleteByPostId(id);
            commentMapper.deleteByPostId(id);
            bannerMapper.deleteByPostId(id);
        }

        return postMapper.deleteById(ids);
    }

    @Override
    public Post selecyById(Integer id) {
        if (id == null || id < 1) {
            return null;
        }
        Post post = postMapper.selectById(id);
        if (post != null) {
            post.setTags(selectTagByPostId(id));
            post.setCategoryes(selectCategoryByPostId(id));
        }

        return post;
    }

    @Override
    public List<Post> selectByStatus(Integer status) {
        if (status == null || (status != 1 && status != 2 && status != 3)) {
            return null;
        }

        return postMapper.selectByStatus(status);
    }

    @Override
    public Integer updateStatus(List<Integer> ids, Integer status) {
        if (ids == null || ids.size() < 1) {
            return 0;
        }

        return postMapper.updateStatus(ids, status);
    }

    @Override
    public Integer update(PostParam postParam) {
        Post post = assemblyPost(postParam);
        postTagRefMapper.deleteByPostId(post.getId());
        postCategoryRefMapper.deleteByPostId(post.getId());
        insertTagAndCategory(postParam, post.getId());

        return postMapper.update(post);
    }

    @Override
    public Integer update(Post post) {
        return postMapper.update(post);
    }

    @Override
    public Post insert(Post post) {
        postMapper.insert(post);
        return post;
    }


    @Override
    public Integer updateViewCount(Integer id, Integer viewCount) {
        if (id == null || id < 1 || viewCount == null || viewCount < 1) {
            return 0;
        }

        return postMapper.updateViewCount(id, viewCount);
    }

    @Override
    public Integer updateCommentCount(Integer id, Integer commentCount) {
        if (id == null || id < 1 || commentCount == null || commentCount < 0) {
            return 0;
        }

        return postMapper.updateCommentCount(id, commentCount);
    }

    @Override
    public List<String> selectYear() {
        return postMapper.selectYear();
    }

    @Override
    public List<Post> selectByYear(String year) {
        if (StringUtils.isBlank(year)) {
            return null;
        }

        return postMapper.selectByYear(year);
    }

    @Override
    public List<Post> selectByIds(List<Integer> ids) {
        return postMapper.selectByIds(ids);
    }

    @Override
    public List<Post> selectRecentPost() {
        return postMapper.selectRecentPost();
    }

    @Override
    public List<Post> selectSearchByTitle(String title) {
        if (StringUtils.isBlank(title)) {
            return null;
        }
        
        return postMapper.selectSearchByTitle(title);
    }

    /**
     * 组装Post
     * @param postParam
     * @return
     */
    private Post assemblyPost(PostParam postParam) {
        Post post = new Post();
        post.setAuthor(postParam.getAuthor());
        post.setTitle(postParam.getTitle());
        post.setUserId(postParam.getUserId());
        post.setStatus(postParam.getStatus());
        post.setContent(postParam.getContent());
        post.setMarkDownContent(postParam.getMarkDownContent());
        if (postParam.getId() != null) {
            post.setId(postParam.getId());
        }

        return post;
    }

    /**
     * 根据帖子id获取分类
     * @param id
     * @return
     */
    private List<Category> selectCategoryByPostId(Integer id) {
        List<Category> list = new ArrayList<>();
        List<PostCategoryRef> postCategoryRefList = postCategoryRefMapper.selectByPostId(id);
        for (PostCategoryRef postCategoryRef : postCategoryRefList) {
            Category category = categoryMapper.selectById(postCategoryRef.getCategoryId());
            assembly(category);
            list.add(category);
        }

        return list;
    }

    /**
     * 根据帖子id获取标签
     * @param id
     * @return
     */
    private List<Tag> selectTagByPostId(Integer id) {
        List<Tag> list = new ArrayList<>();
        List<PostTagRef> postTagRefList = postTagRefMapper.selectByPostId(id);
        for (PostTagRef postTagRef : postTagRefList) {
            Tag tag = tagMapper.selectById(postTagRef.getTagId());
            assembly(tag);
            list.add(tag);
        }

        return list;
    }

    /**
     * 插入标签，分类和帖子的映射
     * @param postParam
     * @param id
     */
    private void insertTagAndCategory(PostParam postParam, Integer id) {
        if (id == null) {
            return;
        }

        List<String> tagList = postParam.getTag();
        if (tagList != null && tagList.size() > 0) {
            List<PostTagRef> list = new ArrayList<>();
            for (String name : tagList) {
                name = name.replace("\"", "").replace("]", "").replace("[", "");
                if (StringUtils.isBlank(name)) {
                    continue;
                }
                Tag tag = tagMapper.selectByName(name);
                list.add(new PostTagRef(tag.getId(), id));
            }
            if (list.size() > 0) {
                postTagRefMapper.insert(list);
            }
        }

        List<String> categoryList = postParam.getCategory();
        if (categoryList != null && categoryList.size() > 0) {
            List<PostCategoryRef> list = new ArrayList<>();
            for (String name : categoryList) {
                name = name.replace("\"", "").replace("]", "").replace("[", "");
                if (StringUtils.isBlank(name)) {
                    continue;
                }
                Category category = categoryMapper.selectByName(name);
                list.add(new PostCategoryRef(category.getId(), id));
            }
            if (list.size() > 0) {
                postCategoryRefMapper.insert(list);
            }
        }
    }

    private void assembly(Category category) {
        int id = category.getId();
        int size = postCategoryRefMapper.selectByCategoryId(id).size();
        category.setPostNumber(size);
    }

    private void assembly(Tag tag) {
        int id = tag.getId();
        int size = postTagRefMapper.selectByTagId(id).size();
        tag.setPostNumber(size);
    }

}
