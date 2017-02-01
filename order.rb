class Order

  attr_accessor :cart, :bonus_card

  def initialize(cart)
    @cart = cart
    @bonus_card = false
    @inventory = Inventory.new
  end

  def add_inventory_to_cart_by_sku(sku)
    item = @inventory.find(sku: sku)
    @cart.add_item(item)
  end

  def add_bonus_card
    @bonus_card = true
  end

  def total
    @cart.total(@bonus_card)
  end
end
