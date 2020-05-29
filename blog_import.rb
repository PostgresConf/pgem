require 'feedjira'
require 'byebug'
include ActionView::Helpers::SanitizeHelper

@logger = Logger.new(STDOUT)

url = 'https://blog.pgconf.us/feeds/posts/default'
rss = open(url).read
feed = Feedjira::Feed.parse rss
posts = feed.entries

@logger.info('Blog importer starting')

AUTHOR_MAP = {'Joshua Drake' =>  'jd@commandprompt.com', 'Jim Mlodgenski' => 'jimm@openscg.com'}
posts.each do |post|
    post_author = User.find_by_email(AUTHOR_MAP[post.author])
    
    post_record = Refinery::Blog::Post.find_or_initialize_by({title: post.title})
    post_record.title = post.title
    post_record.body = post.content
    post_record.published_at = post.published
    post_record.author = post_author
    post_record.draft = false

    if post_record.new_record?
        post_record.save
        @logger.info "creating new record: #{post_record.title}"
    end
  
end
