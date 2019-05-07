package top.weishilei.blog.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import top.weishilei.blog.controller.BaseController;
import top.weishilei.blog.domain.Image;
import top.weishilei.blog.domain.Result;
import top.weishilei.blog.service.impl.ImageServiceImpl;

import java.io.File;

/**
 * 图片Controller
 * @author weishilei
 */
@Controller
@RequestMapping("/admin/image")
public class AdminImageController extends BaseController {
    @Autowired
    private ImageServiceImpl imageService;

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
        String path = getPath() + File.separator + "image" + File.separator;
        String fileName = System.currentTimeMillis() + suffix;
        try {
            file.transferTo(new File(path + fileName));
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

    @GetMapping("/slider")
    public ModelAndView slider() {
        ModelAndView modelAndView = new ModelAndView("/admin/image/slider-image");

        return modelAndView;
    }
}
