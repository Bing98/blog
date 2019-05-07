package top.weishilei.blog.controller.admin;

import freemarker.template.Configuration;
import freemarker.template.TemplateModelException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Post;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.domain.User;
import top.weishilei.blog.domain.WebSiteConfig;
import top.weishilei.blog.service.PostService;
import top.weishilei.blog.service.UserService;
import top.weishilei.blog.service.impl.WebSiteConfigServiceImpl;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.List;

/**
 * 网站配置Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/config")
public class AdminConfigController extends BaseController {
    @Autowired
    private PostService postService;
    @Autowired
    private UserService userService;
    @Autowired
    private WebSiteConfigServiceImpl webSiteConfigService;
    @Autowired
    private Configuration configuration;


    @GetMapping
    public ModelAndView config() {
        ModelAndView modelAndView = new ModelAndView("admin/config/blog-config");

        return modelAndView;
    }

    @ResponseBody
    @PostMapping("/base")
    public String saveBaseConfig(WebSiteConfig webSiteConfig) {
        String footer = webSiteConfig.getFooter();
        if (StringUtils.isBlank(footer)) {
            return Result.fail("页脚不能为空！");
        }

        boolean isSuccess = webSiteConfigService.updateBase(webSiteConfig) > 0;
        if (isSuccess) {
            try {
                configuration.setSharedVariable("webSiteConfig", webSiteConfigService.select().get(0));
            } catch (TemplateModelException e) {
            }
        }
        return isSuccess ? Result.success() : Result.fail();
    }

    @ResponseBody
    @PostMapping("/seo")
    public String saveSeoConfig(WebSiteConfig webSiteConfig) {
        String title = webSiteConfig.getTitle();
        if (StringUtils.isBlank(title)) {
            return Result.fail("网站标题不能为空！");
        }

        boolean isSuccess = webSiteConfigService.updateSeo(webSiteConfig) > 0;
        if (isSuccess) {
            try {
                configuration.setSharedVariable("webSiteConfig", webSiteConfigService.select().get(0));
            } catch (TemplateModelException e) {
            }
        }
        return isSuccess ? Result.success() : Result.fail();
    }

    @GetMapping("/about")
    public ModelAndView about() {
        ModelAndView modelAndView = new ModelAndView("admin/config/about");
        List<Post> aboutPostList = postService.selectByStatus(3);
        Post aboutPost = null;
        if (aboutPostList != null && aboutPostList.size() > 0) {
            aboutPost = aboutPostList.get(0);
        }
        modelAndView.addObject("aboutPost", aboutPost);

        return modelAndView;
    }

    @ResponseBody
    @PostMapping("/about")
    public String about(Post post) {
        String mkContent = post.getMarkDownContent();
        String content = post.getContent();
        if (StringUtils.isBlank(mkContent) || StringUtils.isBlank(content)) {
            return Result.failCode("内容不能为空！", Result.PARAMTER_IS_EMPTY);
        }

        List<Post> aboutPostList = postService.selectByStatus(3);
        post.setTitle("关于我");
        post.setStatus(3);
        String name = getSession().getAttribute("superName").toString();
        User user = userService.selectUserByName(name);
        post.setAuthor(name);
        post.setUserId(user.getId());
        if (aboutPostList != null && aboutPostList.size() > 0) {
            Post aboutPost = aboutPostList.get(0);
            post.setId(aboutPost.getId());
            postService.update(post);
        } else {
            post = postService.insert(post);
        }
        boolean isSuccess = post != null;

        return isSuccess ? Result.success(post.getId()) : Result.fail();
    }

    @ResponseBody
    @PostMapping("upload")
    public String upload(@RequestParam("file") MultipartFile file) {
        if (file == null) {
            return Result.fail();
        }

        String path = getPath() + File.separator + "other" + File.separator + "favicon.ico";
        BufferedInputStream in = null;
        BufferedOutputStream out = null;
        try {
            in = new BufferedInputStream(file.getInputStream());
            Image image = ImageIO.read(in);
            BufferedImage bufferedImage = new BufferedImage(32, 32, BufferedImage.TYPE_INT_RGB);
            bufferedImage.getGraphics().drawImage(image, 0, 0,32, 32, null);
            out = new BufferedOutputStream(new FileOutputStream(path));
            ImageIO.write(bufferedImage, "png", out);

            return Result.success();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                }
            }
        }

        return Result.fail();
    }

}
