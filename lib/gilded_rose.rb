# Gilded Rose is the original class we inherited. Manages the quality and total.
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each { |item| DetermineType.for(item).update }
  end

  def total()
    total = 0
    @items.each { |item| total += DetermineType.for(item).price }
    total
  end

end

# Item Class - not to be touched.
class Item
  attr_reader :name, :base_price
  attr_accessor :sell_in, :quality

  def initialize(name, sell_in, quality, base_price=10)
    @name = name
    @sell_in = sell_in
    @quality = quality
    @base_price = base_price
  end

  def to_s()
    "Name: #{@name}, Sell In: #{@sell_in}, Quality: #{@quality}, Base Price: #{@base_price}"
  end
end

# Factory Class to determine proper item type
class DetermineType
  ITEM_TYPES = [
     [/^Sulfuras, Hand of Ragnaros$/, "Legend"],
     [/^Aged Brie$/, "Aged"],
     [/^Backstage passes to a TAFKAL80ETC concert$/, "Passes"],
     [/^Conjured$/, "Conjured"],
   ]


  def self.for(item)
    pair = ITEM_TYPES.detect { |re, handler| re =~ item.name }
    handler = pair ? pair[1] : "Standard"

    return Object::const_get(handler).new(item)
  end
end

# Item Type - Manages actual quality adjustment and price for items
class ItemType
  def initialize item
    @item = item
    @price = item.base_price
  end

  def update
    @item.sell_in -= 1
  end

  def adjust_quality(amount)
    @item.quality += amount
    @item.quality += amount if @item.sell_in <= 0

    @item.quality = 50 if @item.quality > 50
    @item.quality = 0 if @item.quality < 0
  end

  def price
    return @price += @item.quality if @item.sell_in > 0

    @price += (@item.sell_in * 2)
    @price = 0 if @price < 0

    @price
  end

end

# Standard Item Type
class Standard < ItemType
  def update
    super
    adjust_quality(-1)
  end
end

# Conjured Item Type
class Conjured < ItemType
  def update
    super
    adjust_quality(-2)
  end
end

# Aged Item Type
class Aged < ItemType
  def update
    super
    adjust_quality(1)
  end
end

# Legend Item Type
class Legend < ItemType
  def update
  end
end

# PAsses Item Type
class Passes < ItemType
  def update
    super

    return @item.quality = 0 if @item.sell_in <= 0

    adjust_quality(1) if @item.sell_in > 10
    adjust_quality(2) if @item.sell_in.between?(6, 10)
    adjust_quality(3) if @item.sell_in.between?(1, 5)
  end

  def price
    super
    return @price if @item.sell_in <= 0

    @price += @item.quality if @item.sell_in.between?(6, 10)
    @price += @item.quality * 2 if @item.sell_in.between?(1, 5)

    @price
  end
end
