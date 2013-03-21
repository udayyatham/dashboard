module ApplicationHelper
  def full_title(page_title)
    base_title = "SQAT DashBoard"
    if(page_title.empty?) then
      return base_title
    else
      return "#{base_title} | #{page_title}"
    end
      
  end
end
