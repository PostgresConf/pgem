Refinery::Admin::PagesController.class_eval do
  def permitted_page_params
    [
      :browser_title, :draft, :link_url, :menu_title, :meta_description,
      :parent_id, :skip_to_first_child, :show_in_menu, :title, :view_template,
      :layout_template, :custom_slug, parts_attributes: [:id, :title, :slug, :body, :position],
      dynamicform_associations_attributes: [ :id, dynamicform_values_attributes: [ :id, :text_value, :resource_id, :image_id, :string_value, :integer_value ] ]
    ]
  end
end