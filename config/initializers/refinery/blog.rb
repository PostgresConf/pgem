Refinery::Blog.configure do |config|
  # config.validate_source_url = false

  # config.comments_per_page = 10

  # config.posts_per_page = 10

  # config.post_teaser_length = 250

  # config.share_this_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

  config.page_url = "/blog"

  # If you're grafting onto an existing app, change this to your User class
  Refinery::Blog.user_class = "User"
  config.allowed_author_ids = [44, 8705, 1414, 235, 1192, 5, 1677, 279, 2062, 237, 157, 1875, 256]
end

# a hacky way to force the new controller action into app routes, could we do better?
Refinery::Core::Engine.routes.append do
  namespace :blog, :path => Refinery::Blog.page_url do
    get 'author/:author_id', :to => 'posts#author', :as => 'author_feed'
  end
end