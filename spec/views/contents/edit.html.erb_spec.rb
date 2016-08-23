require 'rails_helper'

RSpec.describe "contents/edit", type: :view do
  before(:each) do
    @content = assign(:content, Content.create!(
      :title => "MyString",
      :description => "MyString",
      :content => "MyText",
      :status => 1,
      :type => 1
    ))
  end

  it "renders the edit content form" do
    render

    assert_select "form[action=?][method=?]", content_path(@content), "post" do

      assert_select "input#content_title[name=?]", "content[title]"

      assert_select "input#content_description[name=?]", "content[description]"

      assert_select "textarea#content_content[name=?]", "content[content]"

      assert_select "input#content_status[name=?]", "content[status]"

      assert_select "input#content_type[name=?]", "content[type]"
    end
  end
end
