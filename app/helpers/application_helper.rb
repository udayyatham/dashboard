module ApplicationHelper
  def full_title(page_title)
    page_title||=""
    base_title = "SQAT DashBoard"
    unless (page_title.empty?) then
      return "#{base_title} | #{page_title}"
    end  
     base_title
  end
end
