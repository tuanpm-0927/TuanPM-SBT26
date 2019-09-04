# frozen_string_literal: true

module Admin::CategoriesHelper
  def typeposts
    Settings.type_post
  end

  def show_image(category)
    default_image = Settings.def_image
    image_tag(category.image.url.nil? ? default_image : category.image.url, alt: category.name)
  end
end
