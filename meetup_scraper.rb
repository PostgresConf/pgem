require 'nokogiri'
require 'open-uri'
require 'json'

@logger = Logger.new(STDOUT)

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
    ret = JSON.parse(jsons.children.first.content)
    picurl = doc.css("meta[property='og:image']").attribute('content').value
    ret['pic_url'] = picurl
    ret
end

def scrape_groups
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

@logger.info('Meetup scraper starting')
scrape_groups
