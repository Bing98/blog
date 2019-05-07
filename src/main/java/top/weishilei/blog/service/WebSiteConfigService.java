package top.weishilei.blog.service;

import top.weishilei.blog.domain.WebSiteConfig;

import java.util.List;

/**
 * 网站配置Service
 * @author weishilei
 */
public interface WebSiteConfigService {
    /**
     * 查询全部
     * @return
     */
    List<WebSiteConfig> select();

    /**
     * 修改基本信息配置
     * @param webSiteConfig
     * @return
     */
    Integer updateBase(WebSiteConfig webSiteConfig);

    /**
     * 修改SEO配置
     * @param webSiteConfig
     * @return
     */
    Integer updateSeo(WebSiteConfig webSiteConfig);

}
