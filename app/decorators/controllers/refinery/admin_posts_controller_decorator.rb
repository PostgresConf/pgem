Refinery::Blog::Admin::PostsController.class_eval do
  def permitted_post_params
    [
      :title, :body, :custom_teaser, :tag_list, :image_id,
      :draft, :published_at, :custom_url, :user_id, :browser_title,
      :meta_description, :source_url, :source_url_title, :category_ids => []
    ]
  end
end