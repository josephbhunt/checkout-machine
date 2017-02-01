class OnlineCart < Cart
  def add_item(item)
    @items << item unless wine?(item)
  end

  def total(apply_discounts)
    ecumulated_total = price_total
    ecumulated_total += surcharge_total
    ecumulated_total
  end

  private

  def wine?(item)
    item.sku == Inventory.create('Wine').sku
  end
end
