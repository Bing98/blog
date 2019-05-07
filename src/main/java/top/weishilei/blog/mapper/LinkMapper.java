package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.omg.PortableInterceptor.INACTIVE;
import top.weishilei.blog.domain.Link;

import java.util.List;

/**
 * 友情链接Mapper
 * @author weishilei
 */
@Mapper
public interface LinkMapper {
    Integer insert(Link link);

    List<Link> select();

    List<Link> selectByStatus(Integer status);

    Integer updateByStatus(@Param("status") Integer status, @Param("ids") List<Integer> ids);

    Integer delete(@Param("ids") List<Integer> ids);
}
