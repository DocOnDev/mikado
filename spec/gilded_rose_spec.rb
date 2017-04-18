require File.join('./lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
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
        it "decreases the Sell In by 1" do
          expect(item.sell_in).to eq sell_in - 1
        end
        context "and before Sell Date" do
          it "decreases Quality by 1" do
            expect(item.quality).to eq quality - 1
          end
          it "adjusts the Price by the Quality" do
            expect(gr.total).to eq item.base_price + item.quality
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {0}
          it "decreases Quality by 2" do
            expect(item.quality).to eq quality - 2
          end
          it "adjusts the Price by double the days past Sell Date" do
            expect(gr.total).to eq item.base_price + item.sell_in * 2
          end
        end

        context "With Quality at minimum" do
          let(:quality) { 0 }
          it "doesn't adjust quality" do
            expect(item.quality).to eq quality
          end
        end
      end

      context "with Quality at minimum" do
        let(:quality) {0}
        it "doesn't adjust Quality" do
          expect(item.quality).to eq 0
        end
        it "sets price at Base" do
          expect(gr.total).to eq item.base_price
        end
      end
    end

    # Aged Items
    context "given an Aged Item" do
      let(:name) {"Aged Brie"}
      it "decreases the Sell In by 1" do
        expect(item.sell_in).to eq sell_in - 1
      end
      context "with Quality less than maximum" do
        context "and before Sell Date" do
          it "increases Quality by one" do
            expect(item.quality).to eq quality + 1
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {-1}
          it "increases Quality by two" do
            expect(item.quality).to eq quality + 2
          end
          context "and near maximum Quality" do
            let(:quality) {49}
            it "doesn't let Quality exceed maximum" do
              expect(item.quality).to eq 50
            end
          end
          it "Decreases price by twice Sell In Days" do
            expect(gr.total).to eq item.base_price + item.sell_in * 2
          end
        end
      end

      context "with Quality at maximum" do
        let(:quality) {50}
        it "doesn't increase Quality" do
          expect(item.quality).to eq quality
        end
      end
    end

    # Backstage Passes
    context "given Passes" do
      let(:name) {"Backstage passes to a TAFKAL80ETC concert"}
      it "decreases the Sell In by 1" do
        expect(item.sell_in).to eq sell_in - 1
      end
      context "with Quality at maximum" do
        let(:quality) {50}
        it "doesn't increase Quality" do
          expect(item.quality).to eq quality
        end
      end
      context "with Quality near maximum" do
        let(:quality) {49}
        it "doesn't increase Quality above maximum" do
          expect(item.quality).to eq 50
        end
      end

      context "with Quality less than maximum" do
        context "and long before Sell Date" do
          let(:sell_in) {25}
          it "increases Quality by 1" do
            expect(item.quality).to eq quality + 1
          end
          it "adjusts the Price by the Quality" do
            expect(gr.total).to eq item.base_price + item.quality
          end
        end
        context "and fairly near Sell Date" do
          let(:sell_in) {10}
          it "increases Quality by 2" do
            expect(item.quality).to eq quality + 2
          end
          it "adjusts the Price by twice the Quality" do
            expect(gr.total).to eq item.base_price + item.quality * 2
          end
          context "and Quality near maximum" do
            let(:quality) {49}
            it "doesn't increase Quality above maximum" do
              expect(item.quality).to eq 50
            end
          end
        end
        context "and very near Sell Date" do
          let(:sell_in) {4}
          it "increases Quality by 3" do
            expect(item.quality).to eq quality + 3
          end
          it "adjusts the Price by triple the Quality" do
            expect(gr.total).to eq item.base_price + item.quality * 3
          end
          context "and Quality near maximum" do
            let(:quality) {49}
            it "doesn't increase Quality above maximum" do
              expect(item.quality).to eq 50
            end
          end
        end
        context "and on Sell Date" do
          let(:sell_in) {0}
          it "reduces Quality to 0" do
            expect(item.quality).to eq 0
          end
        end
        context "and after Sell Date" do
          let(:sell_in) {-2}
          it "reduces Quality to 0" do
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
        it "** maintains a quality of 30" do
          expect(item.quality).to eq 30
        end
      end

      context "before Sell Date" do
        let(:sell_in) {20}
        it "doesn't change quality" do
          expect(item.quality).to eq quality
        end
      end
      context "on Sell Date" do
        let(:sell_in) {0}
        it "doesn't change quality" do
          expect(item.quality).to eq quality
        end
      end
      context "after Sell Date" do
        let(:sell_in) {-2}
        it "doesn't change quality" do
          expect(item.quality).to eq quality
        end
      end
    end

    # Multiple Items
    context "given Multiple Items" do
      let(:gr) {GildedRose.new(items)}
      let(:items) {
        [
          Item.new("Standard", sell_in, quality, price),
          Item.new("Aged Brie", sell_in, quality, price)
        ]
      }

      it "reduces normal quality" do
        expect(items[0].quality).to eq quality - 1
      end
      it "reduces normal sell in" do
        expect(items[0].sell_in).to eq sell_in - 1
      end
      it "increases aged quality" do
        expect(items[1].quality).to eq quality + 1
      end
      it "reduces aged sell in" do
        expect(items[1].sell_in).to eq sell_in - 1
      end
    end

    context "given Conjured Items" do
      let(:name){"Conjured"}
      context "with Quality above minimum" do
        it "decreases the Sell In by 1" do
          expect(item.sell_in).to eq sell_in - 1
        end
        context "and before Sell Date" do
          it "decreases Quality by 2" do
            expect(item.quality).to eq quality - 2
          end
        end
        context "and on or after Sell Date" do
          let(:sell_in) {0}
          it "decreases Quality by 4" do
            expect(item.quality).to eq quality - 4
          end
        end
      end
    end
  end
end
