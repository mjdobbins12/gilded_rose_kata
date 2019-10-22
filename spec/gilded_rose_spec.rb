require './lib/gilded_rose'

describe 'GildedRose' do
  before(:each) do
    items = [
      Item.new("Invisibility Cloak", 10, 20),
      Item.new("Elixir", -1, 7),
      Item.new("Chalice", 5, 0),
      Item.new("Aged Brie", 50, 49),
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

  it 'notes that degradation rate doubles after sell-by date' do
    expect { @gr.update_quality }.to change { @gr.items[1].quality }.by(-2)
  end

  it 'does not allow quality to be negative' do
    expect { @gr.update_quality }.not_to change { @gr.items[2].quality }
  end

  it 'increases the quality metric for brie' do
    expect { @gr.update_quality }.to change { @gr.items[3].quality }.by(1)
  end
end

# “Aged Brie” actually increases in Quality the older it gets
# The Quality of an item is never more than 50
# “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
# “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
