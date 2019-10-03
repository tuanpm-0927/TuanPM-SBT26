# frozen_string_literal: true

module StaticPagesHelper
  def check_active(slide)
    return true if slide.active
    false
  end

  def show_image_slide(slide)
    image_tag(slide.image.url, alt: slide.name, height: Settings.heigth_slide, width: Settings.width_slide)
  end

  def category_post
    Category.user
  end

  def category_tour
    Category.admin
  end

  def slide_all
    Slide.all
  end
end
