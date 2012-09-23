require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @note = assign(:note, stub_model(Note))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path(@note), :method => "post" do
    end
  end
end
