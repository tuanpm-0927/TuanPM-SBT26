# frozen_string_literal: true

module Admin::CategoriesHelper
  def typeposts
    Settings.type_post
  end

  def show_image(category)
    image_tag(category.image.url.nil? ? Settings.def_image : category.image.url, alt: category.name, height: Settings.height, width: Settings.width)
  end
end
