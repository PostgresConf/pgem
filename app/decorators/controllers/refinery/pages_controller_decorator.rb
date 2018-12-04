Refinery::PagesController.class_eval do
  layout 'website'
  skip_authorization_check
end