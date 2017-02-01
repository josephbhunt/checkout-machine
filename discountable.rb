module Discountable
  def chip_discounts
    discounted = @items.select { |i| i.name == 'Chips' }
    groups_of_three_chips = discounted.count / 3
    Inventory.create('Chips').price * groups_of_three_chips
  end

  def salsa_discounts
    discounted = @items.select { |i| i.name == 'Salsa'}
    discounts = discounted.map { |d| d.price / 2 }
    sum(discounts)
  end
end
