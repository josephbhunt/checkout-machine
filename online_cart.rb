class OnlineCart < Cart

  def add_item(item)
    unless item.sku == Inventory.create('Wine').sku
      @items << item
    end
  end
end
