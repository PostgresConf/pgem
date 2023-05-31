require 'date'

require 'schema_dot_org/person'
require 'schema_dot_org/place'
require 'schema_dot_org/organization'
require 'schema_dot_org/web_site'
require 'schema_dot_org/event'

Refinery::PagesController.class_eval do
  layout 'website'
  skip_authorization_check

  before_action :set_structured_data, :only => [:home]

  def set_structured_data
    @announced_conference = Conference.where('end_date >= ?', Date.current).reorder(start_date: :asc).first
    return unless @announced_conference and @announced_conference.description and @announced_conference.venue

    # TODO: add Offers (tickets)
    # see https://developers.google.com/search/docs/appearance/structured-data/product#product-with-shipping-example
    @structured_data = SchemaDotOrg::Event.new(
      name: @announced_conference.title,
      description: @announced_conference.description,
      startDate: @announced_conference.start_date,
      endDate: @announced_conference.end_date,
      image: @announced_conference.picture.url,
      # TODO: use virtual location instead of Place for digital events
      location: SchemaDotOrg::Place.new(address: @announced_conference.venue.address),
      url: main_app.conference_url(@announced_conference.short_title)
    )
  end
end