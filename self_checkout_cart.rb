require './cart'
require './discountable'

class SelfCheckoutCart < Cart
  include Discountable

  def add_item(item)
    unless wine_or_cigs?(item)
      @items << item
    end
  end

  private

  def wine_or_cigs?(item)
    item.sku == Inventory.create('Wine').sku ||
    item.sku == Inventory.create('Cigarettes').sku
  end
end
