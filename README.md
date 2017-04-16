# The Gilded Rose Code Kata, Mikado Style

This is a Ruby version of the Gilded Rose Kata, found
[here](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/).

This is a refactoring kata intended to showcase the mikado method.
The kata can be solved without using mikado, but I encourage you to give it a try.

To try the Kata, clone this git repository and checkout
the tag 'begin-kata'.

## Specification

- All items have a SellIn value which denotes the number of days we have to sell the item
- All items have a Quality value which denotes how valuable the item is
- At the end of each day our system lowers both values for every item
- Once the sell by date has passed, Quality degrades twice as fast
- Aged items, such as "Aged Brie" actually increase in Quality the older they get
- The Quality of an item is never negative
- The Quality of Legendary items, such as "Sulfuras" is 80 and never changes
- The Quality of all other items is never more than 50
- Legendary items never have to be sold
- Passes increase in Quality as their SellIn value approaches;
  - Quality increases by 2 when there are 10 days or less
  - Quality increases by 3 when there are 5 days or less
  - Quality drops to 0 after the concert
- Conjured items degrade in Quality twice as fast as normal items
- Prior to the sell by date, an item's sell price is base_price + Quality
- For Passes, the sell price increases faster as their sell by date approaches
  - base_price + (Quality * 2) when there are 10 days or less
  - base_price + (Quality * 3) when there are 5 days or less
- After the sell by date, an item's price decreases and is determined by base_price + (sell_in * 2)
- An item's price never falls below 0

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything still works correctly. However, **do not alter the Item class or Items property** as those belong to the goblin
in the corner who will insta-rage and one-shot you as he doesn't
believe in shared code ownership (you can make the UpdateQuality
method and Items property static if you like, we'll cover for
you).


## Changes from the original

The original kata has been cloned and modified several times.
You can find variants of the kata all over the internet.
This particular version has been modified to all for use of the mikado method.

* The original was a single convoluted method that updated the sell_in and quality
  of items. This version adds two more methods for pricing an item and for totaling
  a list of items.

* The original items had no pricing information. I've added a base_price attribute
  the Item class.

You can read
[the original kata article](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/) for more details.

## Installation Hints

The easiest way is to use bundler to install the dependencies.

To do so, you need to install the bundler gem if you haven't already done so

    gem install bundler

run bundler

    bundle

and should be ready to go. Alternatively, you can install the dependencies one by one using gem install, e.g.

    gem install rspec

Have a look at the Gemfile for all dependencies.


# Original Description of the Gilded Rose

Hi and welcome to team Gilded Rose. As you know, we are a small inn
with a prime location in a prominent city run by a friendly innkeeper
named Allison. We also buy and sell only the finest
goods. Unfortunately, our goods are constantly degrading in quality as
they approach their sell by date. We have a system in place that
updates our inventory for us. It was developed by a no-nonsense type
named Leeroy, who has moved on to new adventures. Your task is to add
the new feature to our system so that we can begin selling a new
category of items. First an introduction to our system:

- All items have a SellIn value which denotes the number of days we
  have to sell the item
- All items have a Quality value which denotes how valuable the item
  is
- At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

  - Once the sell by date has passed, Quality degrades twice as fast
  - The Quality of an item is never negative
  - "Aged Brie" actually increases in Quality the older it gets
  - The Quality of an item is never more than 50
  - "Sulfuras", being a legendary item, never has to be sold or
    decreases in Quality
  - "Backstage passes", like aged brie, increases in Quality as it's
    SellIn value approaches; Quality increases by 2 when there are 10
    days or less and by 3 when there are 5 days or less but Quality
    drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

- "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any
new code as long as everything still works correctly. However, do not
alter the Item class or Items property as those belong to the goblin
in the corner who will insta-rage and one-shot you as he doesn't
believe in shared code ownership (you can make the UpdateQuality
method and Items property static if you like, we'll cover for
you). Your work needs to be completed by Friday, February 18, 2011
08:00:00 AM PST.

Just for clarification, an item can never have its Quality increase
above 50, however "Sulfuras" is a legendary item and as such its
Quality is 80 and it never alters.
