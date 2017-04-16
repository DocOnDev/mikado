require File.join('./lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    before(:each) { gr.update_quality }
    let(:gr) {GildedRose.new([item])}
    let(:quality) {20}
    let(:sell_in) {20}
    let(:price) {40}

    context "given Standard Item" do
      let(:item) {Item.new("standard", sell_in, quality, price)}

      context "with Quality above minimum" do
        it "does decrease the Sell In by 1" do
          expect(item.sell_in).to eq sell_in - 1
        end
        context "and on or before Sell Date" do
          it "does decrease Quality by 1" do
            expect(item.quality).to eq quality - 1
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {0}
          it "does decrease quality by 2" do
            expect(item.quality).to eq quality - 2
          end
        end
      end
    end
  end
end
