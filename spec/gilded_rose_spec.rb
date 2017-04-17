require File.join('./lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
<<<<<<< HEAD
    before(:each) { gr.update_quality }
    let(:gr) {GildedRose.new([item])}
    let(:quality) {20}
    let(:sell_in) {20}
    let(:price) {450}
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
          it "does adjust the Price by the Quality" do
            expect(gr.total).to eq item.base_price + item.quality
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {0}
          it "does decrease Quality by 2" do
            expect(item.quality).to eq quality - 2
          end
          it "does adjust the Price by double the days past Sell Date" do
            expect(gr.total).to eq item.base_price + item.sell_in * 2
          end
        end
      end

      context "with Quality at minimum" do
        let(:quality) {0}
        it "does not decrease Quality" do
          expect(item.quality).to eq 0
        end
        it "does set price at Base" do
          expect(gr.total).to eq item.base_price
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
      context "with Quality at maximum" do
        let(:quality) {50}
        it "does not increase Quality" do
          expect(item.quality).to eq quality
        end
      end

      context "with Quality less than maximum" do
        context "and long before Sell Date" do
          let(:sell_in) {25}
          it "does increase Quality by 1" do
            expect(item.quality).to eq quality + 1
          end
          it "does adjust the Price by the Quality" do
            expect(gr.total).to eq item.base_price + item.quality
          end
        end
        context "and fairly near Sell Date" do
          let(:sell_in) {10}
          it "does increase Quality by 2" do
            expect(item.quality).to eq quality + 2
          end
          it "does adjust the Price by twice the Quality" do
            expect(gr.total).to eq item.base_price + item.quality * 2
          end
        end
        context "and very near Sell Date" do
          let(:sell_in) {4}
          it "does increase Quality by 3" do
            expect(item.quality).to eq quality + 3
          end
          it "does adjust the Price by triple the Quality" do
            expect(gr.total).to eq item.base_price + item.quality * 3
          end
        end
        context "and on Sell Date" do
          let(:sell_in) {0}
          it "does reduce Quality to 0" do
            expect(item.quality).to eq 0
          end
        end
        context "and after Sell Date" do
          let(:sell_in) {-2}
          it "does reduce Quality to 0" do
            expect(item.quality).to eq 0
          end
        end
      end
    end

    # Legendary Items
    context "given a Legendary Item" do
      let(:name){"Sulfuras, Hand of Ragnaros"}

      context "with Initial Quality of 30" do
        let(:quality) {30}
        it "does maintain a quality of 30" do
          expect(item.quality).to eq 30
        end
      end

      context "before Sell Date" do
        let(:sell_in) {20}
        it "does not change quality" do
          expect(item.quality).to eq quality
        end
      end
      context "on Sell Date" do
        let(:sell_in) {0}
        it "does not change quality" do
          expect(item.quality).to eq quality
        end
      end
      context "after Sell Date" do
        let(:sell_in) {-2}
        it "does not change quality" do
          expect(item.quality).to eq quality
        end
      end
    end

    context "given Multiple Items" do
      let(:gr) {GildedRose.new(items)}
      let(:items) {
        [
          Item.new("Standard", sell_in, quality, price),
          Item.new("Aged Brie", sell_in, quality, price)
        ]
      }

      it "does reduce normal quality" do
        expect(items[0].quality).to eq quality - 1
      end
      it "does reduce normal sell in" do
        expect(items[0].sell_in).to eq sell_in - 1
      end
      it "does increase aged quality" do
        expect(items[1].quality).to eq quality + 1
      end
      it "does reduce aged sell in" do
        expect(items[1].sell_in).to eq sell_in - 1
      end
    end
  end
end
