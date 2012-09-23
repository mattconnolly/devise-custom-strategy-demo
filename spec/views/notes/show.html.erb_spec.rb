require 'spec_helper'

describe "notes/show" do
  before(:each) do
    @note = assign(:note, stub_model(Note))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
