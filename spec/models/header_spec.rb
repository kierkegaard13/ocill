require 'spec_helper'

describe Header do
  it "should have valid factory" do
    FactoryGirl.build(:header).should be_valid
  end

  it "should require a drill" do
    FactoryGirl.build(:drillless_header).should_not be_valid
  end

  describe "saved" do
    it "should have a position" do
      header = FactoryGirl.create(:header)
      header.position.should_not be_nil
    end

    describe "with several siblings" do
      it "should have the same position" do
        header = FactoryGirl.create(:five_siblinged_header)
        siblings = header.drill.headers
        sibling_positions = siblings.map {|h| h.position}
        sibling_positions.uniq.size.should == 1
      end
    end
  end

end
