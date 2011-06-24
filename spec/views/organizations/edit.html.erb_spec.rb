require 'spec_helper'

describe "organizations/edit.html.erb" do
  before(:each) do
    @organization = assign(:organization, stub_model(Organization,
      :name => "",
      :description => "",
      :website => "",
      :location => "MyString"
    ))
  end

  it "renders the edit organization form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => organizations_path(@organization), :method => "post" do
      assert_select "input#organization_name", :name => "organization[name]"
      assert_select "textarea#organization_description", :name => "organization[description]"
      assert_select "input#organization_website", :name => "organization[website]"
      assert_select "input#organization_location", :name => "organization[location]"
    end
  end
end
