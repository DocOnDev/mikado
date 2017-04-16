require File.join('./lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    before(:each) { gr.update_quality }
    let(:gr) {GildedRose.new([item])}
    let(:quality) {20}
    let(:sell_in) {20}
    let(:price) {40}
    let(:item) {Item.new(name, sell_in, quality, price)}

    # Standard Items
    context "given Standard Item" do
      let(:name) {"Standard"}
      context "with Quality above minimum" do
        it "does decrease the Sell In by 1" do
          expect(item.sell_in).to eq sell_in - 1
        end
        context "and before Sell Date" do
          it "does decrease Quality by 1" do
            expect(item.quality).to eq quality - 1
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {0}
          it "does decrease Quality by 2" do
            expect(item.quality).to eq quality - 2
          end
        end
      end

      context "with Quality at minimum" do
        let(:quality) {0}
        it "does not decrease Quality" do
          expect(item.quality).to eq 0
        end
      end
    end

    # Aged Items
    context "given an Aged Item" do
      let(:name) {"Aged Brie"}
      it "does decrease the Sell In by 1" do
        expect(item.sell_in).to eq sell_in - 1
      end
      context "with Quality less than maximum" do
        context "and before Sell Date" do
          it "does increase Quality by one" do
            expect(item.quality).to eq quality + 1
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {-1}
          it "does increase Quality by two" do
            expect(item.quality).to eq quality + 2
          end
          context "and near maximum Quality" do
            let(:quality) {49}
            it "does not let Quality exceed maximum" do
              expect(item.quality).to eq 50
            end
          end
        end
      end

      context "with Quality at maximum" do
        let(:quality) {50}
        it "does not increase Quality" do
          expect(item.quality).to eq quality
        end
      end
    end

    # Backstage Passes
    context "given Passes" do
      let(:name) {"Backstage passes to a TAFKAL80ETC concert"}
      it "does decrease the Sell In by 1" do
        expect(item.sell_in).to eq sell_in - 1
      end
      context "and at maximum Quality" do
        let(:quality) {50}
        it "does not increase Quality" do
          expect(item.quality).to eq quality
        end
      end

      context "long before Sell Date" do
        let(:sell_in) {25}
        it "does increase Quality by 1" do
          expect(item.quality).to eq quality + 1
        end
      end
      context "fairly near Sell Date" do
        let(:sell_in) {10}
        it "does increase Quality by 2" do
          expect(item.quality).to eq quality + 2
        end
      end
      context "very near Sell Date" do
        let(:sell_in) {4}
        it "does increase Quality by 3" do
          expect(item.quality).to eq quality + 3
        end
      end
      context "on Sell Date" do
        let(:sell_in) {0}
        it "does reduce Quality to 0" do
          expect(item.quality).to eq 0
        end
      end
      context "after Sell Date" do
        let(:sell_in) {-2}
        it "does reduce Quality to 0" do
          expect(item.quality).to eq 0
        end
      end
    end
  end
end
