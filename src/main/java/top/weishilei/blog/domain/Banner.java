package top.weishilei.blog.domain;

/**
 * 横幅图
 * @author weishilei
 */
public class Banner {
   private Integer id;
   private Integer imageId;
   private Integer postId;
   private Integer sort;
   private String postTitle;
   private String imagePath;

   public Integer getId() {
      return id;
   }

   public void setId(Integer id) {
      this.id = id;
   }

   public Integer getImageId() {
      return imageId;
   }

   public void setImageId(Integer imageId) {
      this.imageId = imageId;
   }

   public Integer getPostId() {
      return postId;
   }

   public void setPostId(Integer postId) {
      this.postId = postId;
   }

   public Integer getSort() {
      return sort;
   }

   public void setSort(Integer sort) {
      this.sort = sort;
   }

   public String getPostTitle() {
      return postTitle;
   }

   public void setPostTitle(String postTitle) {
      this.postTitle = postTitle;
   }

   public String getImagePath() {
      return imagePath;
   }

   public void setImagePath(String imagePath) {
      this.imagePath = imagePath;
   }

   @Override
   public String toString() {
      return "Banner{" +
              "id=" + id +
              ", imageId=" + imageId +
              ", postId=" + postId +
              ", sort=" + sort +
              ", postTitle='" + postTitle + '\'' +
              ", imagePath='" + imagePath + '\'' +
              '}';
   }
}
