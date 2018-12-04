Refinery::Page.create!([
  {parent_id: 1, path: nil, slug: "index-page", custom_slug: nil, show_in_menu: false, link_url: "", menu_match: nil, deletable: true, draft: false, skip_to_first_child: false, lft: 2, rgt: 3, depth: 1, view_template: "show", layout_template: "website", title: "Index", menu_title: "Index"},
  {parent_id: nil, path: nil, slug: "home", custom_slug: nil, show_in_menu: true, link_url: "/", menu_match: "^/$", deletable: false, draft: false, skip_to_first_child: false, lft: 1, rgt: 6, depth: 0, view_template: "home", layout_template: "website", title: "Home", menu_title: "Home"},
  {parent_id: 1, path: nil, slug: "page-not-found", custom_slug: nil, show_in_menu: false, link_url: "", menu_match: "^/404$", deletable: false, draft: false, skip_to_first_child: false, lft: 4, rgt: 5, depth: 1, view_template: "home", layout_template: "website", title: "Page not found", menu_title: ""},
  {parent_id: nil, path: nil, slug: "news", custom_slug: nil, show_in_menu: true, link_url: "/news", menu_match: "^/news.*$", deletable: false, draft: false, skip_to_first_child: false, lft: 7, rgt: 8, depth: 0, view_template: "show", layout_template: "website", title: "News", menu_title: ""},
  {parent_id: nil, path: nil, slug: "blog", custom_slug: nil, show_in_menu: true, link_url: "/blog", menu_match: "^/blog?(/|/.+?|)$", deletable: false, draft: false, skip_to_first_child: false, lft: 9, rgt: 10, depth: 0, view_template: "home", layout_template: "home", title: "Blog", menu_title: ""},
  {parent_id: nil, path: nil, slug: "conferences-page", custom_slug: nil, show_in_menu: true, link_url: "/conferences", menu_match: nil, deletable: true, draft: false, skip_to_first_child: false, lft: 11, rgt: 12, depth: 0, view_template: "show", layout_template: "home", title: "Conferences", menu_title: "Conferences"},
  {parent_id: nil, path: nil, slug: "about", custom_slug: nil, show_in_menu: true, link_url: "", menu_match: nil, deletable: true, draft: false, skip_to_first_child: false, lft: 13, rgt: 14, depth: 0, view_template: "show", layout_template: "website", title: "About", menu_title: ""},
  {parent_id: nil, path: nil, slug: "search", custom_slug: nil, show_in_menu: false, link_url: "/search", menu_match: "^/search?(/|/.+?|)$", deletable: false, draft: false, skip_to_first_child: false, lft: 15, rgt: 16, depth: 0, view_template: "show", layout_template: "home", title: "Search", menu_title: ""}
])
Refinery::PagePart.create!([
  {refinery_page_id: 6, slug: "body", body: "", position: 0, title: "Body"},
  {refinery_page_id: 6, slug: "side_body", body: "", position: 1, title: "Side Body"},
  {refinery_page_id: 8, slug: "title_body_slug_body", body: "", position: 0, title: "{:title=>\"Body\", :slug=>\"body\"}"},
  {refinery_page_id: 8, slug: "title_side_body_slug_side_body", body: "", position: 1, title: "{:title=>\"Side Body\", :slug=>\"side_body\"}"},
  {refinery_page_id: 4, slug: "body", body: "<h1>index page</h1>", position: 0, title: "Body"},
  {refinery_page_id: 4, slug: "side_body", body: "", position: 1, title: "Side Body"},
  {refinery_page_id: 1, slug: "body", body: "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>", position: 0, title: "Body"},
  {refinery_page_id: 1, slug: "side_body", body: "<p>This is another block of content over here.</p>", position: 1, title: "Side Body"},
  {refinery_page_id: 2, slug: "body", body: "<h2>Sorry, there was a problem...</h2>\r\n<p>The page you requested was not found.</p>\r\n<p><a href=\"/\">Return to the home page</a>\r\n</p>", position: 0, title: "Body"},
  {refinery_page_id: 3, slug: "body", body: "<p>This is just a standard text page example. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin metus dolor, hendrerit sit amet, aliquet nec, posuere sed, purus. Nullam et velit iaculis odio sagittis placerat. Duis metus tellus, pellentesque ut, luctus id, egestas a, lorem. Praesent vitae mauris. Aliquam sed nulla. Sed id nunc vitae leo suscipit viverra. Proin at leo ut lacus consequat rhoncus. In hac habitasse platea dictumst. Nunc quis tortor sed libero hendrerit dapibus.\r\n\r\nInteger interdum purus id erat. Duis nec velit vitae dolor mattis euismod. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse pellentesque dignissim lacus. Nulla semper euismod arcu. Suspendisse egestas, erat a consectetur dapibus, felis orci cursus eros, et sollicitudin purus urna et metus. Integer eget est sed nunc euismod vestibulum. Integer nulla dui, tristique in, euismod et, interdum imperdiet, enim. Mauris at lectus. Sed egestas tortor nec mi.</p>", position: 0, title: "Body"},
  {refinery_page_id: 3, slug: "side_body", body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla nisi a elit. Duis ultricies orci ut arcu. Ut ac nibh. Duis blandit rhoncus magna. Pellentesque semper risus ut magna. Etiam pulvinar tellus eget diam. Morbi blandit. Donec pulvinar mauris at ligula. Sed pellentesque, ipsum id congue molestie, lectus risus egestas pede, ac viverra diam lacus ac urna. Aenean elit.</p>", position: 1, title: "Side Body"},
  {refinery_page_id: 9, slug: "body", body: "", position: 0, title: "Body"},
  {refinery_page_id: 9, slug: "side_body", body: "", position: 1, title: "Side Body"},
  {refinery_page_id: 5, slug: "body", body: nil, position: 0, title: "Body"},
  {refinery_page_id: 5, slug: "side_body", body: nil, position: 1, title: "Side Body"},
  {refinery_page_id: 7, slug: "body", body: "", position: 0, title: "Body"},
  {refinery_page_id: 7, slug: "side_body", body: "", position: 1, title: "Side Body"}
])
Refinery::Setting.create!([
  {name: "comments_allowed", value: "true", destroyable: true, scoping: "blog", restricted: false, form_value_type: "text_area", slug: "comments_allowed", title: nil},
  {name: "comment_moderation", value: "true", destroyable: true, scoping: "blog", restricted: false, form_value_type: "text_area", slug: "comment_moderation", title: nil},
  {name: "teasers_enabled", value: "false", destroyable: true, scoping: "blog", restricted: false, form_value_type: "text_area", slug: "teasers_enabled", title: "Teasers Enabled (Blog)"},
  {name: "banner_background", value: "linear-gradient(0deg,rgba(255,0,150,0.3),rgba(255,0,10,0.3)), url('https://privatelenderlink.com/wp-content/uploads/new-york-skyline-statue-liberty-morning.jpg') no-repeat 0 0/cover", destroyable: true, scoping: nil, restricted: false, form_value_type: nil, slug: "banner_background", title: "Banner Background"},
  {name: "twitter_embed", value: "<a class=\"twitter-timeline\" data-height=\"600\" data-link-color=\"#000\" data-theme=\"light\" href=\"https://twitter.com/PGConfUS?ref_src=twsrc%5Etfw\">Tweets by PGConfUS</a>\r\n\r\n", destroyable: true, scoping: nil, restricted: false, form_value_type: nil, slug: "twitter_embed", title: "Twitter Embed"}
])
