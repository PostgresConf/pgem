require 'spec_helper'

feature Activity do
  let!(:conference) { create(:conference) }
  let!(:organizer_role) { Role.find_by(name: 'organizer', resource: conference) }
  let!(:organizer) { create(:user, role_ids: [organizer_role.id]) }

  scenario 'Add a lodging', feature: true, js: true do
    path = "#{Rails.root}/app/assets/images/rails.png"

    sign_in organizer
    visit admin_conference_lodgings_path(
              conference_id: conference.short_title)
    # Add activity
    click_link 'Add Activity'

    fill_in 'activity_name', with: 'New activity'
    fill_in 'activity_website_link', with: 'http://www.google.com'
    attach_file 'Picture', path

    click_button 'Create Activity'

    # Validations
    expect(flash).to eq('Activity successfully created.')
    expect(page.has_content?('New activity')).to be true
    expect(Activity.count).to eq(1)
  end

  scenario 'Update an activity', feature: true, js: true do
    path = "#{Rails.root}/app/assets/images/rails.png"

    activity = create(:activity, conference: conference)

    sign_in organizer
    visit admin_conference_activities_path(
              conference_id: conference.short_title)

    expect(page.has_content?(CGI.escapeHTML(activity.name))).to be true

    # Add activity
    click_link 'Edit'

    fill_in 'activity_name', with: 'New activity'
    fill_in 'activity_website_link', with: 'http://www.google.com'
    attach_file 'Picture', path

    click_button 'Update Activity'

    # Validations
    expect(flash).to eq('Activity successfully updated.')
    expect(page.has_content?('New activity')).to be true
    activity.reload
    expect(activity.name).to eq('New activity')
    expect(activity.description).to eq(CGI.escapeHTML(activity.description))
    expect(activity.website_link).to eq('http://www.google.com')
    expect(Activity.count).to eq(1)
  end

  scenario 'Delete an activity', feature: true, js: true do
    activity = create(:activity, conference: conference)

    sign_in organizer
    visit admin_conference_activities_path(
              conference_id: conference.short_title)

    expect(page.has_content?(activity.name)).to be true

    # Add activity
    click_link 'Delete'

    # Validations
    expect(flash).to eq('Activity successfully deleted.')
    expect(page.has_content?(CGI.escapeHTML(lodging.name))).to be false
    expect(Activity.count).to eq(0)
  end
end
