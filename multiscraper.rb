require 'feedjira'
require 'nokogiri'
require 'open-uri'
require 'json'

include ActionView::Helpers::SanitizeHelper

@logger = Logger.new(STDOUT)

def scrape_planet
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
end

AUTHOR_MAP = {'Linuxhiker' => 'jd@commandprompt.com', 'Joshua Drake' => 'jd@commandprompt.com', 'Jim Mlodgenski' => 'jimm@openscg.com'}

def scrape_blogs
    url = 'https://blog.pgconf.us/feeds/posts/default'
    rss = open(url).read
    feed = Feedjira::Feed.parse rss
    posts = feed.entries

    @logger.info('Blog importer starting')

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
end


def get_group_event_ids(url)
    doc = Nokogiri::HTML(open("#{url}/events/"))
    event_ids = []
    res = doc.css('.eventCard--link').each do |link|
        eid = link.attribute('href').value.split('/').last
        event_ids << eid if eid
    end
    event_ids
end

def get_event_info(url, event_id)
    doc = Nokogiri::HTML(open("#{url}/events/#{event_id}"))
    jsons = doc.css('script[type="application/ld+json"]')
    ret = nil
    jsons.children.each do  |child|
        begin
            parsed = JSON.parse(child)
        rescue
            next
        end
        # meetup sometimes injects multiple event jsons into the peage, all of these are usually "recommended" events
        next if parsed.kind_of? Array
        purl = parsed['url'] || ''
        if purl.include? event_id
            ret = parsed
        end
    end

    picurl = doc.css("meta[property='og:image']").attribute('content').value
    ret['pic_url'] = picurl
    ret
end

GROUP_URLS=[
    'https://www.meetup.com/postgres-nyc/',
    'https://www.meetup.com/postgres-philly/',
    'https://www.meetup.com/Silicon-Valley-Postgres/',
    'https://www.meetup.com/Montreal-Postgres/',
    'https://www.meetup.com/Toronto-Postgres/',
    'https://www.meetup.com/Vancouver-Postgres/',
    'https://www.meetup.com/Houston-Postgres/',
    'https://www.meetup.com/Dallas-Fort-Worth-Postgres/',
    'https://www.meetup.com/austinpostgres/',
    'https://www.meetup.com/Seattle-Postgres/',
    'https://www.meetup.com/Los-Angeles-Postgres/',
    'https://www.meetup.com/Phoenix-Postgres/',
    'https://www.meetup.com/Salt-Lake-City-Postgres/',
    'https://www.meetup.com/Denver-Postgres/',
    'https://www.meetup.com/Whatcom-Postgres/'
]

def scrape_meetups
    @logger.info('Meetup scraper starting')
    GROUP_URLS.each do |gurl|
        eids = get_group_event_ids(gurl)

        eids.each do |event_id|
            event = get_event_info(gurl, event_id)
            meetup = Refinery::Meetups::Meetup.find_or_initialize_by({external_id: event_id})
            meetup.title = event['name']
            meetup.description = event['description']
            meetup.url = event['url']
            meetup.picture_url = event['pic_url']
            meetup.start = DateTime.parse(event['startDate'])
            if event['endDate']
                   meetup.end = DateTime.parse(event['endDate'])
            end
            meetup.location = 'N/A'
            if event['location'].present?
                meetup.location = "#{event['location']['address']['addressLocality']} / #{event['location']['address']['addressCountry']}" unless event['location']['@type'] == "VirtualLocation"
            end
            if meetup.new_record?
                @logger.info("Creating new meetup record from #{event_id}: #{meetup.title}")
            else
                @logger.info("Updating meetup record from #{event_id}: #{meetup.title}")
            end
            meetup.save
        end
    end
end

scrape_planet
scrape_blogs
scrape_meetups