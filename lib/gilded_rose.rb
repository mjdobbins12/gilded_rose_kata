class GildedRose
  attr_reader :items

  MINIMUM_QUALITY = 0
  MAXIMUM_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != "Sulfuras"
        update_sell_in(item)
        distinguish(item)
        past_sell_date(item) if item.sell_in < 0
      end
    end
  end

  private

  def update_sell_in(item)
    unless item.name == "Sulfuras"
      item.sell_in -= 1
    end
  end

  def distinguish(item)
    if item.name == "Aged Brie"
      appreciate(item)
    elsif item.name.include?("Backstage Pass")
      update_backstage_pass(item)
    elsif item.name.include?("Conjured")
      2.times{ depreciate(item) }
    else depreciate(item)
    end
  end

  def depreciate(item)
    item.quality -= 1 if item.quality > MINIMUM_QUALITY
  end

  def appreciate(item)
    item.quality += 1 if item.quality < MAXIMUM_QUALITY
  end

  def update_backstage_pass(item)
    appreciate(item)
    appreciate(item) if item.sell_in < 11
    appreciate(item) if item.sell_in < 6
  end

  def past_sell_date(item)
    if item.name.include?("Backstage Pass")
      item.quality = MINIMUM_QUALITY
    elsif item.name.include?("Conjured")
      2.times{ depreciate(item) }
    elsif item.name != "Aged Brie"
      depreciate(item)
    end
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
