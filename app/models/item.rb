class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author, type: String
  field :item_name, type: String
  field :item_price, type: Integer

  validates :item_name, presence: true
  validates :item_price, presence: true

end
