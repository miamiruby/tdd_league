require 'csv'
require 'byebug'
require_relative '../lib/league.rb'

describe "League" do

  it "should return a formatted result" do
    input = CSV.read('examples/sample-input.txt')
    output = File.read('examples/expected-output.txt')
    expect(League.new({games: input}).result).to eq(output)
  end

# draw (tie) is worth 1 point
# win is worth 3 points
# loss is worth 0 points
# If two or more teams have the same number of points
# they should have the same rank and be printed in alphabetical order (as in the tie for 3rd place in the sample data).
end
