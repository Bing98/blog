package top.weishilei.blog.service;

import top.weishilei.blog.domain.Log;

import java.util.List;

/**
 * 日志Service
 * @author weishilei
 */
public interface LogService {
    /**
     * 插入
     * @param log
     * @return
     */
    Integer insert(Log log);

    /**
     * 查询全部
     * @return
     */
    List<Log> select();

    /**
     * 删除
     * @param ids
     * @return
     */
    Integer delete(List<Integer> ids);

}
