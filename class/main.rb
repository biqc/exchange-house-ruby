require_relative 'cashier'
require_relative 'layout'

class Main

  cashier = Cashier.start_day
  system "cls"
  
  opt = Layout.menu
    
  while opt != 7 do
    case opt
      when 1
        cashier.buyDolar
      when 2
        cashier.sellDolar
      when 3
        cashier.buyReal
      when 4
        cashier.sellReal
      when 5
        cashier.show_daily_op
      when 6
        cashier.show_cashier_status
      else
        puts ('Opção inválida!')
    end
    opt = Layout.menu 
  end

end
