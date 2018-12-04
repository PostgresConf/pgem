Refinery::Page.class_eval do

acts_as_indexed :fields => [:title, :body]

  def self.refinery_search_scope
    live
  end

  def body
    parts.where(slug: 'body').first.body
  end
end