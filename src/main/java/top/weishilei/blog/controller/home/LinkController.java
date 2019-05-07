package top.weishilei.blog.controller.home;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.weishilei.blog.domain.Link;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.impl.LinkServiceImpl;

/**
 * 友情链接Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/link")
public class LinkController {
    @Autowired
    private LinkServiceImpl linkService;

    @PostMapping
    @ResponseBody
    public String link(Link link) {
        String name = link.getName();
        String url = link.getUrl();
        if (StringUtils.isBlank(name) || StringUtils.isBlank(url)) {
            return Result.fail("请正确填写！");
        }

        link.setStatus(1);
        boolean isSuccess = linkService.insert(link) > 0;
        return isSuccess ? Result.success() : Result.fail();
    }

}
