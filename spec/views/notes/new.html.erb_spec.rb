require 'spec_helper'

describe "notes/new" do
  before(:each) do
    assign(:note, stub_model(Note).as_new_record)
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path, :method => "post" do
    end
  end
end
