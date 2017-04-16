require File.join('./lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    context "given Standard Item" do
      let(:item) {Item.new("standard", 20, 20, 20)}
      let(:gr) {GildedRose.new([item])}

      before(:each) { gr.update_quality }

      context "with Quality above minimum" do
        it "does decrease quality by 1" do
          expect(item.quality).to eq 19
        end
      end
    end
  end
end
