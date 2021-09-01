class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = false

# better user agent parsing
Ahoy.user_agent_parser = :device_detector

# better bot detection
Ahoy.bot_detection_version = 2
Ahoy.job_queue = :low_priority

Geocoder.configure(
    ip_lookup: :geoip2,
    geoip2: {
      file: Rails.root.join("lib", "GeoLite2-City.mmdb")
    }
)
