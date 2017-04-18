class Standard
  def initialize item
    @item = item
  end

  def update
    @item.sell_in -= 1
    @item.quality -= 1

    if @item.sell_in <= 0
      @item.quality -= 1
    end

    @item.quality = 0 if @item.quality < 0
  end
end

class Aged
  def initialize item
    @item = item
  end

  def update
    @item.sell_in -= 1
    @item.quality += 1

    if @item.sell_in <= 0
      @item.quality += 1
    end

    @item.quality = 50 if @item.quality > 50
  end
end

class Legend
  def initialize item
    @item = item
  end

  def update
  end
end

class Passes
  def initialize item
    @item = item
  end

  def update
    @item.sell_in -= 1

    return @item.quality = 0 if @item.sell_in <= 0

    @item.quality += 1

    if @item.sell_in <= 10
      @item.quality += 1
      if @item.sell_in <= 5
        @item.quality += 1
      end
    end

    @item.quality = 50 if @item.quality > 50
  end
end


class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      @item = item
      case @item.name
      when "Aged Brie"
        type = Aged.new @item
      when "Sulfuras, Hand of Ragnaros"
        type = Legend.new @item
      when "Backstage passes to a TAFKAL80ETC concert"
        type = Passes.new @item
      else
        type = Standard.new @item
      end
      type.update
    end
  end

  def total()
    total = 0
    @items.each do |item|
      total += price(item)
    end
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
