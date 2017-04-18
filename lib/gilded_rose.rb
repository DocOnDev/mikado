class GildedRose
  ITEM_TYPES = [
     [/^Sulfuras, Hand of Ragnaros$/, "Legend"],
     [/^Aged Brie$/, "Aged"],
     [/^Backstage passes to a TAFKAL80ETC concert$/, "Passes"],
     [/^Conjured$/, "Conjured"],
   ]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each { |item| updater_for(item).update }
  end

  def updater_for(item)
    pair = ITEM_TYPES.detect { |re, handler| re =~ item.name }
    handler = pair ? pair[1] : "Standard"

    Object::const_get(handler).new(item)
  end

  def total()
    total = 0
    @items.each { |item| total += price(item) }
    total
  end

  private

  def price(item)
    price = item.base_price
    if item.sell_in > 0
      if item.name != "Backstage passes to a TAFKAL80ETC concert"
        price += item.quality
      else
        price += item.quality
        if item.sell_in < 11
          price += item.quality
          if item.sell_in < 6
            price += item.quality
          end
        end
      end
    else
      price += (item.sell_in * 2)
    end
    price = 0 if price < 0

    price
  end

end

class Item
  attr_accessor :name, :sell_in, :quality, :base_price

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

class ItemType
  def initialize item
    @item = item
  end

  def update
    @item.sell_in -= 1
  end

  def adjust_quality(item, amount)
    item.quality += amount
    item.quality += amount if item.sell_in <= 0

    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.quality < 0
  end
end

class Standard < ItemType
  def update
    super
    adjust_quality(@item, -1)
  end
end

class Conjured < ItemType
  def update
    super
    adjust_quality(@item, -2)
  end
end

class Aged < ItemType
  def update
    super
    adjust_quality(@item, 1)
  end
end

class Legend < ItemType
  def update
  end
end

class Passes < ItemType
  def update
    super

    return @item.quality = 0 if @item.sell_in <= 0

    adjust_quality(@item, 1) if @item.sell_in > 10
    adjust_quality(@item, 2) if @item.sell_in.between?(6, 10)
    adjust_quality(@item, 3) if @item.sell_in.between?(1, 5)
  end
end
