require 'spec_helper'

describe "notes/index" do
  before(:each) do
    assign(:notes, [
      stub_model(Note),
      stub_model(Note)
    ])
  end

  it "renders a list of notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
