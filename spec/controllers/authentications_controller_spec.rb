require 'spec_helper'

describe AuthenticationsController do

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
