require "will_paginate/view_helpers/action_view"

# call symbolized_update on both, GET and HEAD requests, prevents will_paginate crashes on HEAD requests
# in case it it is unsed in rails engine (refinery blog in our case)
module WillPaginate
  module ActionView
    class LinkRenderer < ViewHelpers::LinkRenderer
      def merge_get_params(url_params)
        if @template.respond_to? :request and @template.request and ['GET', 'HEAD'].include? @template.request.method
          symbolized_update(url_params, @template.params, GET_PARAMS_BLACKLIST)
        end
        url_params
      end
    end
  end
end