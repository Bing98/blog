package top.weishilei.blog.domain;

import java.util.Date;

/**
 * 日志
 * @author weishilei
 */
public class Log {
    private Integer id;
    private String content;
    private Integer userId;
    private Date createTime;
    private String ip;

    public Log() {}

    public Log(String content, Integer userId, String ip) {
        this.content = content;
        this.userId = userId;
        this.ip = ip;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", userId=" + userId +
                ", createTime=" + createTime +
                ", ip='" + ip + '\'' +
                '}';
    }
}
