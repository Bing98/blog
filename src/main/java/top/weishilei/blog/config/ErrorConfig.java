package top.weishilei.blog.config;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

/**
 * 错误页
 * @author weishilei
 */
@Configuration
public class ErrorConfig {

    @Bean
    public EmbeddedServletContainerCustomizer containerCustomizer() {

        return new EmbeddedServletContainerCustomizer() {
            @Override
            public void customize(ConfigurableEmbeddedServletContainer configurableEmbeddedServletContainer) {
                ErrorPage errorPage404 = new ErrorPage(HttpStatus.NOT_FOUND, "/static/404.html");

                configurableEmbeddedServletContainer.addErrorPages(errorPage404);
            }
        };
    }

}
