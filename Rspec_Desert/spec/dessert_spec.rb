require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:cookie) {Dessert.new("cookie",5,chef)}
  let(:chef) {double("gordon ramsey", :titleize => "Gordon Ramsey")}

  describe "#initialize" do
    it "sets a type" do
      expect(cookie.type).to eq("cookie")
    end

    it "sets a quantity" do
      expect(cookie.quantity).to eq(5)
    end

    it "starts ingredients as an empty array" do
      expect(cookie.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect do
        Dessert.new("brownie","five",chef)
      end.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      cookie.add_ingredient("cinnamon")
      expect(cookie.ingredients).to include("cinnamon")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      cookie.add_ingredient("sugar")
      cookie.add_ingredient("eggs")
      cookie.add_ingredient("baking soda")
      
      expect(cookie.mix!).to eq(cookie.ingredients.shuffle!)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      small_amount = 3
      cookie.eat(small_amount)
      expect(cookie.quantity).to eq(2)
    end

    it "raises an error if the amount is greater than the quantity" do
      large_amount = 6
      expect {cookie.eat(large_amount)}.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(cookie.serve).to include(chef.titleize)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(cookie)
      cookie.make_more
    end
  end
end
