package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.weishilei.blog.domain.WebSiteConfig;

import java.util.List;

/**
 * 网站配置Mapper
 */
@Mapper
public interface WebSiteConfigMapper {
    List<WebSiteConfig> select();

    Integer updateBase(WebSiteConfig webSiteConfig);

    Integer updateSeo(WebSiteConfig webSiteConfig);
}