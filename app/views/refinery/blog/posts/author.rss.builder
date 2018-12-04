xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.atom :link, nil, {
      href: refinery.blog_author_feed_url(format: 'rss'),
      rel: 'self', type: 'application/rss+xml'
    }

    xml.title Refinery::Core.site_name
    xml.description "#{@posts_author.name} Blog Posts"
    xml.link refinery.blog_author_feed_url(format: 'rss')

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link refinery.blog_post_url(post)
        xml.guid refinery.blog_post_url(post)
      end
    end
  end
end