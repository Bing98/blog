package top.weishilei.blog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.weishilei.blog.domain.Log;
import top.weishilei.blog.mapper.LogMapper;
import top.weishilei.blog.service.LogService;

import java.util.List;

/**
 * 日志Service实现类
 * @author weishilei
 */
@Service
public class LogServiceImpl implements LogService {
    @Autowired
    private LogMapper logMapper;

    @Override
    public Integer insert(Log log) {
        if (log == null) {
            return 0;
        }

        return logMapper.insert(log);
    }

    @Override
    public List<Log> select() {
        return logMapper.select();
    }

    @Override
    public Integer delete(List<Integer> ids) {
        if (ids == null || ids.size() < 1) {
            return 0;
        }

        return logMapper.delete(ids);
    }
}
