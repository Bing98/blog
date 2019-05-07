package top.weishilei.blog;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import top.weishilei.blog.domain.*;
import top.weishilei.blog.mapper.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class BlogApplicationTests {

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private TagMapper tagMapper;
	@Autowired
	private CategoryMapper categoryMapper;
	@Autowired
	private PostTagRefMapper postTagRefMapper;
	@Autowired
	private PostCategoryRefMapper postCategoryRefMapper;
	@Autowired
	private PostMapper postMapper;
	@Autowired
	private CommentMapper commentMapper;

	@Test
	public void testCommonet01() {
		System.out.println(commentMapper.selectByPostId(297).size());
	}

	public void testPost() {
		System.out.println(postMapper.selectSearchByTitle("test").size());
	}

	public void testComment() {
		Comment comment = new Comment();
		comment.setPostId(1);
		comment.setUserId(1);
		comment.setId(1);
		comment.setPid(1);
		comment.setName("1");
		comment.setEmail("1");
		comment.setContent("1");
		comment.setIp("1.1.1.1");
		comment.setAgent("1");
		comment.setStatus(1);
		comment.setUrl("1");
		System.out.println(comment);
		commentMapper.insert(comment);
	}

	public void contextLoads() {
		User u = new User();
		u.setUsername("admin");
		u.setPassword("admin");
		u.setEmail("wsldope@gmail.com");
		u.setUrl("http//weishilei.top");
		u.setRole(1);
		userMapper.insert(u);
	}


	public void testTag() throws InterruptedException {
		for (int i = 0; i < 100; i++) {
			Post post = new Post();
			post.setUserId(44);
			post.setAuthor("ikigai");
			post.setTitle("testTitletestTitletestTitletestTitletestTitletestTitletestTitletestTitle");
			post.setContent("testContenttestContenttestContenttestContenttestContenttestContenttestContenttestContent");
			post.setStatus(1);
			postMapper.insert(post);
		}
	}

	public void testCategory() {
		List<PostCategoryRef> list = new ArrayList<>();
		list.add(new PostCategoryRef(1, 1));
		list.add(new PostCategoryRef(2, 2));
		postCategoryRefMapper.insert(list);
	}

}
