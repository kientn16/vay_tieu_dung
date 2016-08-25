module ApplicationHelper
  def num_currency(number)
    number_to_currency(number, unit: "VND", separator: ",", delimiter: ".", format: "%n %u",strip_insignificant_zeros: true)
  end
end
