require 'spec_helper'

describe ApplicationHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ApplicationHelper)
  end

  describe "authenticated" do
    it "should return false for no @current_user" do
      helper.stub!(:current_user).and_return(nil)
      helper.authenticated?.should == false
    end

    it "should return true for @current user" do
      helper.stub!(:current_user).and_return(mock('User'))

      helper.authenticated?.should == true
    end
  end
end
