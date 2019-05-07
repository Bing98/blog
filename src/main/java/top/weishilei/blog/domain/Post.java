package top.weishilei.blog.domain;

import java.sql.JDBCType;
import java.util.Date;
import java.util.List;

/**
 * 帖子
 * @author weishilei
 */
public class Post {
    private Integer id;
    private Integer userId;
    private String author;
    private String title;
    private String markDownContent;
    private String content;
    private Integer viewCount;
    private Integer commentCount;
    private Integer likeCount;
    private List<Tag> tags;
    private List<Category> categoryes;
    private Integer status;
    private Date createTime;
    private Date updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public Integer getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(Integer commentCount) {
        this.commentCount = commentCount;
    }

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public List<Category> getCategoryes() {
        return categoryes;
    }

    public void setCategoryes(List<Category> categoryes) {
        this.categoryes = categoryes;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getMarkDownContent() {
        return markDownContent;
    }

    public void setMarkDownContent(String markDownContent) {
        this.markDownContent = markDownContent;
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", userId=" + userId +
                ", author='" + author + '\'' +
                ", title='" + title + '\'' +
                ", markDownContent='" + markDownContent + '\'' +
                ", content='" + content + '\'' +
                ", viewCount=" + viewCount +
                ", commentCount=" + commentCount +
                ", likeCount=" + likeCount +
                ", tags=" + tags +
                ", categoryes=" + categoryes +
                ", status=" + status +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
