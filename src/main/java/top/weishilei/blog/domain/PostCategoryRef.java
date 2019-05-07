package top.weishilei.blog.domain;

/**
 * 文章和分类关联
 * @author weishilei
 */
public class PostCategoryRef {
    private Integer postId;
    private Integer categoryId;

    public PostCategoryRef() {}

    public PostCategoryRef(Integer categoryId, Integer postId) {
        this.postId = postId;
        this.categoryId = categoryId;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "PostCategoryRef{" +
                "postId=" + postId +
                ", categoryId=" + categoryId +
                '}';
    }
}
