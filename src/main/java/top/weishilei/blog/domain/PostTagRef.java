package top.weishilei.blog.domain;

/**
 * 文章和标签关联
 * @author weishilei
 */
public class PostTagRef {
    private Integer postId;
    private Integer tagId;

    public PostTagRef() {}

    public PostTagRef(Integer tagId,Integer postId) {
        this.postId = postId;
        this.tagId = tagId;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public Integer getTagId() {
        return tagId;
    }

    public void setTagId(Integer tagId) {
        this.tagId = tagId;
    }

    @Override
    public String toString() {
        return "PostTagRef{" +
                "postId=" + postId +
                ", tagId=" + tagId +
                '}';
    }
}
