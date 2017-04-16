require File.join('./lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    context "given Standard Item" do
      let(:item) {Item.new("standard", sell_in, quality, 20)}
      let(:gr) {GildedRose.new([item])}

      before(:each) { gr.update_quality }

      context "with Quality above minimum" do
        let(:quality) {20}
        context "and on or before Sell Date" do
          let(:sell_in) {20}
          it "does decrease quality by 1" do
            expect(item.quality).to eq 19
          end
        end
        context "and after Sell Date" do
          let(:sell_in) {-1}
          it "does decrease quality by 2" do
            expect(item.quality).to eq 18
          end
        end
      end
    end
  end
end
