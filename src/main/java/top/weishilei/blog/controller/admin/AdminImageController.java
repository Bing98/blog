package top.weishilei.blog.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Banner;
import top.weishilei.blog.domain.Image;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.BannerService;
import top.weishilei.blog.service.ImageService;
import top.weishilei.blog.service.impl.PostServiceImpl;

import java.io.File;
import java.util.List;

/**
 * 图片Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/image")
public class AdminImageController extends BaseController {
    @Autowired
    private ImageService imageService;
    @Autowired
    private BannerService bannerService;
    @Autowired
    private PostServiceImpl postService;
    private String savePath = getPath() + File.separator + "image" + File.separator;


    @GetMapping
    public ModelAndView image() {
        ModelAndView modelAndView = new ModelAndView("/admin/image/image");
        modelAndView.addObject("imageList", imageService.select());

        return modelAndView;
    }

    @PostMapping
    @ResponseBody
    public String image(@RequestParam("file") MultipartFile file) {
        String name = file.getOriginalFilename();
        String suffix = name.substring(name.lastIndexOf("."), name.length());
        String fileName = System.currentTimeMillis() + suffix;
        try {
            file.transferTo(new File(savePath + fileName));
            Image image = new Image();
            image.setName(fileName);
            image.setPath("/static/image/" + fileName);
            imageService.insert(image);

            return Result.success();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.fail();
    }

    @ResponseBody
    @GetMapping("/delete")
    public String delte(Integer id, String name) {
        if (id == null || id < 1) {
            return Result.fail();
        }
        boolean isDelete = new File(savePath + name).delete();
        if (isDelete) {
            boolean isSuccess = imageService.delete(id) > 0;
            return isSuccess ? Result.success() : Result.fail();
        }

        return Result.fail();
    }

    @GetMapping("/banner")
    public ModelAndView banner() {
        ModelAndView modelAndView = new ModelAndView("/admin/image/banner");
        List<Banner> bannerList = bannerService.selectOrderBySort();


        return modelAndView;
    }

    @GetMapping("/addBanner")
    public ModelAndView addBanner() {
        ModelAndView modelAndView = new ModelAndView("/admin/image/add-image");
        modelAndView.addObject("imageList", imageService.select());
        modelAndView.addObject("postList", postService.selectAll());

        return modelAndView;
    }

    @ResponseBody
    @PostMapping("/addBanner")
    public String addBanner(Banner banner) {
        Integer imageId = banner.getImageId();
        if (imageId == null || imageId < 1) {
            return Result.fail();
        }
        Integer postId = banner.getPostId();
        if (postId == null || postId < 1) {
            return Result.fail();
        }

        boolean isSuccess = bannerService.insert(banner) > 0;

        return isSuccess ? Result.success() : Result.fail();
    }
}
