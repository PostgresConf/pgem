class Boomset 
  require 'rest-client'
  require 'json'

  def self.get_attendee_request(token, event_id)
    ret = {}
    auth = "Token " + token
    content_type = "application/json"

    url = "https://api.boomset.com/events/" + event_id.to_s + "/registration_types/"

    response = RestClient.get url, {content_type: content_type, authorization: auth}

    if response.code == 200
        json = JSON.parse response.body
        json["results"].each do |result|
            ret[result["name"]] = result["id"] 
        end
    end
    
    ret

    rescue RestClient::Exception
      ret 
  end

  def self.add_guest(token, event_id, guest)
    auth = "Token " + token
    content_type = "application/json"

    url = "https://api.boomset.com/events/" + event_id.to_s + "/guests"

    response = RestClient.post url, guest, {content_type: content_type, authorization: auth}

    if response.code == 201
        json = JSON.parse response.body
        json["id"]
    end

    rescue RestClient::Exception
      -1
  end

  def self.update_guest(token, event_id, guest_id, guest)
    auth = "Token " + token
    content_type = "application/json"

    url = "https://api.boomset.com/events/" + event_id.to_s + "/guests/" + guest_id.to_s

    RestClient.put url, guest, {content_type: content_type, authorization: auth}

    if response.code == 200
        json = JSON.parse response.body
        json["id"]
    end

    rescue RestClient::BadRequest => e
       puts e.response 
       -1
  end

end
