require './lib/gilded_rose'

describe 'GildedRose' do
  before(:each) do
    items = [
      Item.new("Invisibility Cloak", 10, 20),
      Item.new("Elixir", -1, 7),
      Item.new("Chalice", 5, 0),
      Item.new("Aged Brie", 50, 49),
      Item.new("Sulfuras", 0, 50),
      Item.new("Backstage Pass", 9, 20),
      Item.new("Backstage Pass", 4, 20),
      Item.new("Backstage Pass", 0, 20),
      Item.new("Conjured Potato", 5, 40)
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

  it 'does not allow quality to exceed 50' do
    @gr.update_quality
    expect { @gr.update_quality }.not_to change { @gr.items[3].quality }
  end

  it 'does not change the status of Sulfuras' do
    expect { @gr.update_quality }.not_to change { @gr.items[4].sell_in }
    expect { @gr.update_quality }.not_to change { @gr.items[4].quality }
  end

  it 'raises quality by 2 for backstage passes for concerts in 10 days or less' do
    expect { @gr.update_quality }.to change { @gr.items[5].quality }.by(2)
  end

  it 'raises quality by 3 for backstage passes for concerts in 5 days or less' do
    expect { @gr.update_quality }.to change { @gr.items[6].quality }.by(3)
  end

  it 'sets the quality of a backstage pass to 0 after the concert' do
    expect { @gr.update_quality }.to change { @gr.items[7].quality }.to(0)
  end

  it 'accounts for the double degradation rate of conjured items' do
    expect { @gr.update_quality }.to change { @gr.items[8].quality }.by(-2)
  end
end
