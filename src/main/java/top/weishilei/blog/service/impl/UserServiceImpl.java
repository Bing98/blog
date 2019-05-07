package top.weishilei.blog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.apache.commons.lang3.StringUtils;
import top.weishilei.blog.domain.User;
import top.weishilei.blog.mapper.UserMapper;
import top.weishilei.blog.service.UserService;

/**
 * 用户Service实现类
 * @author weishilei
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectUserByName(String username) {
        if (StringUtils.isBlank(username)) {
            return null;
        }

        return userMapper.selectByName(username);
    }

    @Override
    public Boolean insertUser(User user) {
        if (user == null) {
            return false;
        }
        if (user.getRole() == null) {
            user.setRole(0);
        }
        return userMapper.insert(user) == 1;
    }

    @Override
    public Boolean isExistsUserByName(String username) {
        return userMapper.selectByName(username) != null;
    }

    @Override
    public Boolean isExistsUserByEmail(String email) {
        if (StringUtils.isBlank(email)) {
            return false;
        }

        return userMapper.selectByEmail(email) != null;
    }

    /**
     * 验证登录用户信息
     * @param username
     * @param password
     * @return 返回-1则验证失败
     */
    @Override
    public Integer verifyUser(String username, String password) {
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            return -1;
        }

        User user = selectUserByName(username);
        if (user == null || !password.equals(user.getPassword())) {
            return -1;
        }

        return user.getId();
    }

    /**
     * 验证管理员用户信息
     * @param username
     * @param password
     * @return 返回-1则验证失败
     */
    @Override
    public Integer verifyAdmin(String username, String password) {
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            return -1;
        }

        User user = selectUserByName(username);
        if (user == null || user.getRole() != 1 || !password.equals(user.getPassword())) {
            return -1;
        }

        return user.getId();
    }
}
