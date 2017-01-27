require './order'

class OrderProcessor

  attr_accessor :order

  def initialize
    @order = Order.new
  end
end
