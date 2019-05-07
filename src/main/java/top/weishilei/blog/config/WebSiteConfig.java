package top.weishilei.blog.config;

import freemarker.template.TemplateModelException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import top.weishilei.blog.service.WebSiteConfigService;

import javax.annotation.PostConstruct;

/**
 * 加载网站配置文件
 * @author weishilei
 */
@Configuration
public class WebSiteConfig {
    @Autowired
    private freemarker.template.Configuration configuration;
    @Autowired
    private WebSiteConfigService webSiteConfigService;

    @PostConstruct
    public void setWebSiteConfig() throws TemplateModelException {
        configuration.setSharedVariable("webSiteConfig", webSiteConfigService.select().get(0));
    }
}
