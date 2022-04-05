class Order < ApplicationRecord
  belongs_to :cart
  has_many :line_items, dependent: :destroy
end
