package top.weishilei.blog.service;

import top.weishilei.blog.domain.User;

/**
 * 用户Service
 * @author weishilei
 */
public interface UserService {
    User selectUserByName(String username);

    Boolean insertUser(User user);

    Boolean isExistsUserByName(String username);

    Boolean isExistsUserByEmail(String email);

    Integer verifyUser(String username, String password);

    Integer verifyAdmin(String username, String password);
}
