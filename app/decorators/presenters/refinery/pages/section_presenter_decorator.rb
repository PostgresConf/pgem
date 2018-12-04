# overrides the sanitize_content method to output its warnings in development env only
Refinery::Pages::SectionPresenter.class_eval do
  def sanitize_content(input)
    output = sanitize(input, scrubber: CustomScrubber.new(Refinery::Pages::whitelist_elements,
                                                          Refinery::Pages::whitelist_attributes))
    if input != output && ENV['RAILS_ENV'] == 'development'
      warning = "\n-- SANITIZED CONTENT WARNING!!! --\n"
      warning << "Refinery::Pages::SectionPresenter#wrap_content_in_tag\n"
      warning << "HTML attributes and/or elements content has been sanitized\n"
      warning << "#{::Diffy::Diff.new(input, output).to_s(:color)}\n"
      Rails.logger.warn warning
    end

    return output
  end

  class CustomScrubber < Rails::Html::PermitScrubber
    def initialize(tags, attributes)
      @direction = :bottom_up
      @tags = tags
      @attributes = attributes
    end

    def allowed_node?(node)
      tags.include?(node.name)
    end

    def skip_node?(node)
      node.text?
    end

    def scrub_attribute?(name)
      attributes.exclude?(name) && name !~ /\Adata-[\w-]+\z/
    end

  end
end