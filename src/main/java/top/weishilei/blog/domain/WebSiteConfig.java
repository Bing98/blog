package top.weishilei.blog.domain;

/**
 * 网站配置
 */
public class WebSiteConfig {
    private String title;
    private String weibo;
    private String email;
    private String wechat;
    private String qq;
    private String keyword;
    private String description;
    private String footer;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWeibo() {
        return weibo;
    }

    public void setWeibo(String weibo) {
        this.weibo = weibo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFooter() {
        return footer;
    }

    public void setFooter(String footer) {
        this.footer = footer;
    }

    @Override
    public String toString() {
        return "WebSiteConfig{" +
                "title='" + title + '\'' +
                ", weibo='" + weibo + '\'' +
                ", email='" + email + '\'' +
                ", wechat='" + wechat + '\'' +
                ", qq='" + qq + '\'' +
                ", keyword='" + keyword + '\'' +
                ", description='" + description + '\'' +
                ", footer='" + footer + '\'' +
                '}';
    }
}
