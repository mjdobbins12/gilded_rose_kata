require './lib/gilded_rose'

describe 'GildedRose' do
  before(:each) do
    items = [
      Item.new("Invisibility Cloak", 10, 20),
      Item.new("Aged Brie", 2, 0),
      Item.new("Elixir", 5, 7),
      Item.new("Sulfuras", 0, 50),
      Item.new("Backstage Pass", 15, 20),
      Item.new("Conjured Potato", 3, 40)
    ]
    @gr = GildedRose.new(items)
  end

  it 'lowers the sell-by and quality metrics daily' do
    expect { @gr.update_quality }.to change { @gr.items[0].sell_in }.by(-1)
    expect { @gr.update_quality }.to change { @gr.items[0].quality }.by(-1)
  end

  # it 'notes that degradation rate doubles after sell-by date' do
  #
  # end
end

# Once the sell by date has passed, Quality degrades twice as fast
# The Quality of an item is never negative
# “Aged Brie” actually increases in Quality the older it gets
# The Quality of an item is never more than 50
# “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
# “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
