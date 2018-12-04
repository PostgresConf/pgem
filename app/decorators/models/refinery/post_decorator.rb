Refinery::Blog::Post.class_eval do
  acts_as_indexed :fields => [:title, :body]
  belongs_to :image, class_name: '::Refinery::Image'

  def friendly_search_name
    "Blog"
  end
end