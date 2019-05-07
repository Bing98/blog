package top.weishilei.blog.dto;

import java.util.List;

/**
 * 帖子接收参数
 * @author weishilei
 */
public class PostParam {
    private Integer id;
    private String title;
    private String author;
    private String markDownContent;
    private String content;
    private List<String> tag;
    private List<String> category;
    private Integer status;
    private Integer userId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public List<String> getTag() {
        return tag;
    }

    public void setTag(List<String> tag) {
        this.tag = tag;
    }

    public List<String> getCategory() {
        return category;
    }

    public void setCategory(List<String> category) {
        this.category = category;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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
        return "PostParam{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", markDownContent='" + markDownContent + '\'' +
                ", content='" + content + '\'' +
                ", tag=" + tag +
                ", category=" + category +
                ", status=" + status +
                ", userId=" + userId +
                '}';
    }
}
