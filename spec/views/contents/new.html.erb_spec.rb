require 'rails_helper'

RSpec.describe "contents/new", type: :view do
  before(:each) do
    assign(:content, Content.new(
      :title => "MyString",
      :description => "MyString",
      :content => "MyText",
      :status => 1,
      :type => 1
    ))
  end

  it "renders new content form" do
    render

    assert_select "form[action=?][method=?]", contents_path, "post" do

      assert_select "input#content_title[name=?]", "content[title]"

      assert_select "input#content_description[name=?]", "content[description]"

      assert_select "textarea#content_content[name=?]", "content[content]"

      assert_select "input#content_status[name=?]", "content[status]"

      assert_select "input#content_type[name=?]", "content[type]"
    end
  end
end
