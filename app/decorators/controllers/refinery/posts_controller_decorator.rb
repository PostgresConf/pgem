Refinery::Blog::PostsController.class_eval do
  layout 'website'

  skip_authorization_check

  def show_with_format_stub
    show_without_format_stub
    rescue ActionController::MissingRenderer
      render status: 501, text: "format not supported"
  end

  alias_method_chain :show, :format_stub

  def author
    @posts_author = User.find(params[:author_id])
    @posts = Refinery::Blog::Post.where(author: @posts_author).page(params[:page])
    respond_with (@posts) do |format|
          format.html
          format.rss { render :layout => false }
    end
  end

  protected
end