package top.weishilei.blog.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * 通用工具类
 * @author weishilei
 */
public class CommonUtils {

    /**
     * 转换Xss
     * @param str
     * @return
     */
    public static String preventXss(String str) {
        if (StringUtils.isBlank(str)) {
            return "";
        }

        str = str.replace("<script>", "").replace("</script>", "");
        return str;
    }
}
