package top.weishilei.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.weishilei.blog.domain.User;

/**
 * 用户Mapper
 * @author weishilei
 */
@Mapper
public interface UserMapper {
    /**
     * 根据用户名称查找用户
     * @param username
     * @return
     */
    User selectByName(String username);

    /**
     * 根据用户email查找用户
     * @param email
     * @return
     */
    User selectByEmail(String email);

    /**
     * 新增用户
     * @param user
     * @return
     */
    Integer insert(User user);
}
