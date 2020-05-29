require 'feedjira'
include ActionView::Helpers::SanitizeHelper

@logger = Logger.new(STDOUT)

url = 'https://planet.postgresql.org/rss20_short.xml'
rss = open(url).read
feed = Feedjira::Feed.parse rss
posts = feed.entries

@logger.info('Planet importer starting')

posts.each do |post|
    Refinery::CommunityEvents::CommunityEvent.find_or_initialize_by({url: post.url}) do |post_record|
        # planet postgres prepends author name and semicolon to each of their feed posts
        title_split = post.title.split(':')
        if title_split.size > 1
            post_author = title_split[0]
            post_title  = title_split[1].strip
        else
            post_author = 'Planet PostgreSQL'
            post_title = title_split[0]
        end

        post_record.published_at = post.published
        post_record.title = post_title
        post_record.body = post.summary
        post_record.author = post_author
        post_record.save
        @logger.info "creating new record: #{post_record.title}"
    end
end