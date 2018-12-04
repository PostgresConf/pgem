class AddImageIdToRefineryBlogPosts < ActiveRecord::Migration
  def change
    add_column :refinery_blog_posts, :image_id, :integer
  end
end
