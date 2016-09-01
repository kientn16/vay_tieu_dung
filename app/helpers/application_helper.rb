module ApplicationHelper
  def num_currency(number)
    number_to_currency(number, unit: "VND", separator: ",", delimiter: ".", format: "%n %u",strip_insignificant_zeros: true)
  end

  def trim(string = '', length)
        defaultString = '...'
        if string == nil || string.empty?
            defaultString
        else
            if length == nil
                string
            elsif length != nil && string.length < length
                string
            else 
                string.truncate(length, separator: ' ')
            end
        end
    end
end
