module Discountable
  def chip_discounts
    discounted = @items.select { |i| i.name == 'Chips' }
    groups_of_three_chips = discounted.count / 3
    if discounted.count > 0
      discounted.first.price * groups_of_three_chips
    else
      0
    end
  end

  def salsa_discounts
    discounted = @items.select { |i| i.name == 'Salsa'}
    discounts = discounted.map { |d| d.price / 2 }
    sum(discounts)
  end

  def discount_total
    total_discounts = salsa_discounts
    total_discounts += chip_discounts
  end

  def total(apply_discounts)
    ecumulated_total = price_total
    ecumulated_total += surcharge_total
    ecumulated_total -= discount_total if apply_discounts
    ecumulated_total
  end
end
