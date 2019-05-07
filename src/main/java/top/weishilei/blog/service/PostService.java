package top.weishilei.blog.service;

import top.weishilei.blog.domain.Post;
import top.weishilei.blog.dto.PostParam;

import java.util.List;

/**
 * 帖子Service
 * @author weishilei
 */
public interface PostService {
    /**
     * 根据标题查询
     * @param title
     * @return
     */
    Post selectByTitle(String title);

    /**
     * 插入
     * @param postParam
     * @return
     */
    Post insert(PostParam postParam);

    Post insert(Post post);

    /**
     * 根据标题查询
     * @param name
     * @return
     */
    Boolean isExistsByTitle(String name);

    /**
     * 查询全部
     * @return
     */
    List<Post> selectAll();

    /**
     * 删除
     * @param ids
     * @return
     */
    Integer deleteById(List<Integer> ids);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    Post selecyById(Integer id);

    /**
     * 根据状态查询
     * @param status
     * @return
     */
    List<Post> selectByStatus(Integer status);

    /**
     * 修改状态
     * @param ids
     * @param status
     * @return
     */
    Integer updateStatus(List<Integer> ids, Integer status);

    /**
     * 修改
     * @param postParam
     * @return
     */
    Integer update(PostParam postParam);

    Integer update(Post post);

    /**
     * 修改查看数
     * @param id
     * @param viewCount
     * @return
     */
    Integer updateViewCount(Integer id, Integer viewCount);

    /**
     * 修改回复数
     * @param id
     * @param commentCount
     * @return
     */
    Integer updateCommentCount(Integer id, Integer commentCount);

    /**
     * 查询年
     * @return
     */
    List<String> selectYear();

    /**
     * 根据年份查询
     * @param year
     * @return
     */
    List<Post> selectByYear(String year);

    /**
     * 根据id查询
     * @param ids
     * @return
     */
    List<Post> selectByIds(List<Integer> ids);

    /**
     * 查最近的帖子五条
     * @return
     */
    List<Post> selectRecentPost();

    /**
     * 根据名称搜索
     * @param title
     * @return
     */
    List<Post> selectSearchByTitle(String title);
}
