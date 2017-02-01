require './cart'
require './discountable'

class AssistedCheckoutCart < Cart
  include Discountable

  def add_item(item)
    @items << item
  end
end
