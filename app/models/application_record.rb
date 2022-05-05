class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def get_image(width, height)
  #   image.variant(resize_to_limit: [width, height]).processed
  # end
end
