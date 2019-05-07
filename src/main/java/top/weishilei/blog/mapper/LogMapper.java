package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.weishilei.blog.domain.Log;

import java.util.List;

/**
 * 日志Mapper
 * @author weishilei
 */
@Mapper
public interface LogMapper {
    Integer insert(Log log);

    List<Log> select();

    Integer delete(@Param("ids") List<Integer> ids);
}
