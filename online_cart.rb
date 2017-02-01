class OnlineCart < Cart
  include Discountable

  def add_item(item)
    unless item.sku == Inventory.create('Wine').sku
      @items << item
    end
  end
end
