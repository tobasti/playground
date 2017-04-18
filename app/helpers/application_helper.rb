module ApplicationHelper
  BASE_TITLE = "Playground"

  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    page_title.empty? ? BASE_TITLE : page_title + " | " + BASE_TITLE
  end
end
