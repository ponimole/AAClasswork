require "rspec"
require "tDDEx.rb"

describe "my_uniq(array)" do
    a = [2, 1, 1, 3, 3]
    it "should take in an array and return a new array" do
        expect(my_uniq(a)).to_not be(a)
        expect(my_uniq(a)).to be_kind_of(Array)
    end

    it "should remove duplicates from an array" do
        expect(my_uniq([1, 2, 1, 3, 3])).to contain_exactly(2, 1, 3)
    end

    it "should return the elements in the order in which they first appeared" do
        expect(my_uniq([1, 2, 1, 3, 3])).to eq([1, 2, 3])
    end
end

describe Array do
    describe "#two_sum" do
        it "finds all pairs of positions 
        where the elements at those positions sum to zero." do
            expect([-1, 0, 2, -2, 1].two_sum).to contain_exactly([2, 3], [0, 4])
        end

        it "should be sorted by smaller first element, then smaller second element" do
            expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
        end
    end
end

describe "my_transpose(matrix)" do
    it "should covert a 2D matrixes rows to columns" do
        expect(my_transpose([
                             [0, 1, 2],
                             [3, 4, 5],
                             [6, 7, 8]
                            ]
                   )).to eq([
                             [0, 3, 6],
                             [1, 4, 7],
                             [2, 5, 8]
                            ])
    end
end

describe "stock_picker(prices)" do
    it "should take an array of stock prices and output
    the most profitable pair of days on which to first 
    buy the stock and then sell the stock" do
        expect(stock_picker([3,8,2,1,5,4,8])).to eq([3,6])
    end
end

# Towers of Hanoi

describe Pile do
    describe "#initialize(count)" do
        subject(:disc) {Pile.new(2)}
        it "should set a count attribute" do
            expect(disc.count).to eq(2)
        end
    end
end

# Write a Towers of Hanoi game.
describe TowersOfHanoi do
    subject(:game) {TowersOfHanoi.new(7)}
    describe "#initialize" do
        it "should contain an array of count 3" do
            expect(game.piles.length).to eq(3)
        end

        it "should put a disc object in each pile" do
            expect(game.piles).to all( be_kind_of(Pile))
        end

        it "should set count of first pile" do
            expect(game.piles[0].count).to eq(7)
        end
    end

  
    describe "#move" do
        subject(:game) {TowersOfHanoi.new(7)}
        it "should select a disc from a, and move it to another pile." do
            game.move
            expect(game.piles[0].count).to eq(6)
        end
    end

    describe "#won?" do
        subject(:game) {TowersOfHanoi.new(0, 0, 1)}
        it "check to see if they have succeeded in moving all the discs, to the final pile. " do
            expect(game.piles[2].count).to eq(game.total_disc_count)
            game.won?
        end
    end

    describe "#game_loop" do
        subject(:game) {TowersOfHanoi.new(0, 0, 0)}
        it "should call move" do
            expect(game).to receive(:move)            
            game.game_loop
        end
        it "should call won?" do
            expect(game).to receive(:won?)
            game.game_loop
        end
        
    end
end



# Note: don't worry about testing the UI. Testing console 
# I/O is tricky (don't bother checking gets or puts). Focus on:

# #move
# #won?