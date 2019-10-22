class GildedRose
  attr_reader :items

  MINIMUM_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_sell_in(item)
      if item.name != "Aged Brie" and item.name != "Backstage Pass"
        if item.quality > 0
          depreciate(item)
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage Pass"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage Pass"
            if item.quality > 0
              depreciate(item)
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  private

  def update_sell_in(item)
    unless item.name == "Sulfuras"
      item.sell_in -= 1
    end
  end

  def depreciate(item)
    item.quality -= 1 if item.quality > MINIMUM_QUALITY
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
