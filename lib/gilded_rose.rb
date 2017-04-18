require 'item_type'
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
