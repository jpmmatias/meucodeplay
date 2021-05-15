module ApplicationHelper
    def number_to_currency_brl(num)
        number_to_currency num, unit: "R$", separator: ",", delimiter: ".", format: "%u %n"
    end
end
