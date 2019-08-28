# frozen_string_literal: true

module ApplicationHelper
  include SessionHelper
  
  def full_title page_title 
    base_title = I18n.t(".layouts.application.title_page")
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
 end
end
