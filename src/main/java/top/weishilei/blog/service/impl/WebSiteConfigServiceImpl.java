package top.weishilei.blog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.WebSiteConfig;
import top.weishilei.blog.mapper.WebSiteConfigMapper;
import top.weishilei.blog.service.WebSiteConfigService;

import java.util.List;

/**
 * 网站配置Service实现类
 * @author weishilei
 */
@Service
public class WebSiteConfigServiceImpl implements WebSiteConfigService {
    @Autowired
    private WebSiteConfigMapper webSiteConfigMapper;

    @Override
    public List<WebSiteConfig> select() {
        return webSiteConfigMapper.select();
    }

    @Override
    public Integer updateBase(WebSiteConfig webSiteConfig) {
        return webSiteConfigMapper.updateBase(webSiteConfig);
    }

    @Override
    public Integer updateSeo(WebSiteConfig webSiteConfig) {
        return webSiteConfigMapper.updateSeo(webSiteConfig);
    }
}
