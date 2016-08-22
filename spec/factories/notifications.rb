FactoryGirl.define do
  factory :notification do
    user nil
    title "MyString"
    content "MyString"
    is_read 1
    type 1
  end
end
