module RefineryHelper
  def navigation_menu
    presenter = Refinery::Pages::MenuPresenter.new(refinery_menu_pages, self)
    presenter.css = ""
    presenter.menu_tag = :span
    presenter.list_tag_css = "nav navbar-nav"
    presenter.selected_css = "active"
    presenter.first_css = ""
    presenter.last_css = ""
    presenter.max_depth = 0 # prevents dropdown menus, which don't render correctly
    presenter
  end
end