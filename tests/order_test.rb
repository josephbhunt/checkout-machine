require 'minitest/autorun'
require_relative '../order'
require_relative '../item'
require_relative '../assisted_checkout_cart'
require_relative '../online_cart'
require_relative '../self_checkout_cart'

class OrderTest < Minitest::Test
  def setup
    @order = Order.new(AssistedCheckoutCart.new)
    @online_order = Order.new(OnlineCart.new)
    @self_checkout_order = Order.new(SelfCheckoutCart.new)
  end

  def test_add_inventory_to_cart_by_sku_adds_an_inventory_item_to_the_cart
    item = Inventory.create('Chips')
    @order.add_inventory_to_cart_by_sku(item.sku)
    assert_equal 1, @order.cart.total_items
    assert_equal item.name, @order.cart.items.first.name
  end

  def test_total_returns_zero_when_no_items
    assert_equal 0, @order.total
  end

  def test_total_returns_the_sum_of_all_item_prices
    @order.cart = AssistedCheckoutCart.new(
      [ Inventory.create("Chips"), Inventory.create("Chips") ]
    )
    assert_equal 246, @order.total
  end

  def test_total_returns_the_sum_of_items_with_surcharge
    @order.cart = AssistedCheckoutCart.new([Inventory.create("Cigarettes")])
    assert_equal 161, @order.total
  end

  def test_total_returns_sum_of_discounted_salsa
    @order.cart = AssistedCheckoutCart.new([Inventory.create("Salsa")])
    @order.add_bonus_card
    assert_equal 228, @order.total
  end

  def test_total_returns_sum_of_discounted_chips
    @order.cart = AssistedCheckoutCart.new(7.times.map { Inventory.create("Chips") })
    @order.add_bonus_card
    assert_equal 615, @order.total
  end

  def test_self_checkout_order_cannot_add_wine
    item = Inventory.create('Wine')
    @self_checkout_order.add_inventory_to_cart_by_sku(item.sku)
    assert_equal 0, @self_checkout_order.cart.total_items
  end

  def test_self_checkout_order_cannot_add_cigs
    item = Inventory.create('Cigarettes')
    @self_checkout_order.add_inventory_to_cart_by_sku(item.sku)
    assert_equal 0, @self_checkout_order.cart.total_items
  end

  def test_self_checkout_order_can_add_chips
    item = Inventory.create('Chips')
    @self_checkout_order.add_inventory_to_cart_by_sku(item.sku)
    assert_equal 1, @self_checkout_order.cart.total_items
  end

  def test_self_checkout_order_total_returns_sum_of_discounded_chips
    @self_checkout_order.cart = SelfCheckoutCart.new(7.times.map { Inventory.create("Chips") })
    @self_checkout_order.add_bonus_card
    assert_equal 615, @self_checkout_order.total
  end

  def test_self_checkout_order_total_returns_sum_of_discounted_salsa
    @self_checkout_order.cart = SelfCheckoutCart.new([Inventory.create("Salsa")])
    @self_checkout_order.add_bonus_card
    assert_equal 228, @self_checkout_order.total
  end

  def test_online_order_cannot_add_wine
    item = Inventory.create('Wine')
    @online_order.add_inventory_to_cart_by_sku(item.sku)
    assert_equal 0, @online_order.cart.total_items
  end

  def test_online_order_can_add_cogs
    item = Inventory.create('Cigarettes')
    @online_order.add_inventory_to_cart_by_sku(item.sku)
    assert_equal 1, @online_order.cart.total_items
  end

  def test_online_order_does_not_discount_chips
    @online_order.cart = OnlineCart.new(7.times.map { Inventory.create("Chips") })
    @online_order.add_bonus_card
    assert_equal 861, @online_order.total
  end
end
