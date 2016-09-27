require 'spec_helper'

describe Array do
  describe '#my_map' do
    it "should return all element to string format" do
      expect([1, 2, 3, 4].my_map(&:to_s)).to eq(["1", "2", "3", "4"])
    end

    it "should return all element with every element value increment one" do
      result = [1, 2, 3, 4].my_map do |x|
        x + 1
      end
      expect(result).to eq([2, 3, 4, 5])
    end
  end

  describe '#sort_arr' do
  	it "should return all sorted array element" do
  		expect([7, 2, 3, 4].sort_arr).to eq([2,3,4,7])
  	end
  end
end
