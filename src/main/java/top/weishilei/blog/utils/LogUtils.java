package top.weishilei.blog.utils;

/**
 * 日志工具类
 */
public enum LogUtils {
    LOGIN("登录后台"), UP_PWD("修改密码"),
    LOGOUT("登出后台"), DEL_POST("删除文章"),
    NEW_POST("新增文章"), UPDATE_POST("修改文章");

    private String content;

    LogUtils(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
