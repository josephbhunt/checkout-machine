class Item

  attr_accessor :price, :name, :sku, :surcharge, :discounted

  # Surcharge should automatically be added based on something like item type (e.g. {type: :tobacco}).
  def initialize(attributes = {})
    defaults = { surcharge: 0 }
    attributes = defaults.merge(attributes)

    @name = attributes[:name]
    @price = attributes[:price]
    @sku = attributes[:sku]
    @surcharge = attributes[:surcharge]
  end

  def surcharge
    @surcharge
  end
end
