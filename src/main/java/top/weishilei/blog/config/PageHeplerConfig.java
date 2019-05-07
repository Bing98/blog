package top.weishilei.blog.config;

import com.github.pagehelper.PageHelper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * 分页支持
 * @author weishilei
 */
@Configuration
public class PageHeplerConfig {
    @Bean
    public PageHelper pageHelper() {
        PageHelper pageHelper = new PageHelper();
        Properties p = new Properties();
        p.setProperty("offsetAsPageNum", "true");
        p.setProperty("rowBoundsWithCount", "true");
        // 容错处理
        p.setProperty("reasonable", "true");
        pageHelper.setProperties(p);

        return pageHelper;
    }
}
