require_relative 'transaction'
require_relative 'layout'

class Cashier 
    attr_accessor :dolar, :real, :dolar_price, :transactions

    def initialize(dolar_price, dolar, real, transactions = [])
      @dolar_price = dolar_price
      @dolar = dolar
      @real = real
      @transactions = transactions
    end

    def self.start_day
      puts 'Digite a cotação do dólar atual:'
      cot = gets.to_f
      puts 'Digite a quantidade de dólares disponíveis:'
      dol = gets.to_f  
      puts 'Digite a quantidade de reais disponíveis:'
      rea = gets.to_f 
      return Cashier.new(cot, dol, rea)
    end

    def buyDolar
      puts 'Digite a quantidade de dólares que deseja comprar: '
      puts "[Quantidade máxima: #{@dolar.round(2)}]"
      dolares = gets.to_f
      if dolares <= @dolar
        puts "Confime a operação:"
        puts "Compra de $ #{dolares.round(2)} (S/N)"
        if gets.chomp.upcase.eql? "S" 
          @transactions << Transaction.real_to_dolar(self, dolares, "COMPRA")
          Layout.op_suc
        else
          Layout.op_canc
        end
      else
        Layout.limite_excedido
      end
         
    end
  
    def buyReal
      puts 'Digite a quantidade de reais que deseja comprar: '
      puts "[Quantidade máxima: #{@real.round(2)}]"
      reais = gets.to_f
      if reais <= @real 
        puts "Confime a operação:"
        puts "Compra de R$ #{reais.round(2)} (S/N)"
        if gets.chomp.upcase.eql? "S" 
          @transactions << Transaction.dolar_to_real(self, reais, "COMPRA")
          Layout.op_suc
        else
          Layout.op_canc
        end
      else
        Layout.limite_excedido
      end
    end
  
    def sellDolar
        puts 'Digite a quantidade de dólares que deseja vender: '
        puts "[Quantidade máxima: #{(@real/@dolar_price).round(2)}]"
        dolares = gets.to_f
        if dolares <= @real/@dolar_price 
          puts "Confime a operação:"
          puts "Venda de $ #{dolares.round(2)} (S/N)"
          if gets.chomp.upcase.eql? "S" 
            @transactions << Transaction.dolar_to_real(self, dolares, "VENDA")
            Layout.op_suc
          else
            Layout.op_canc
          end
        else
          Layout.limite_excedido
        end
    end
  
    def sellReal
        puts 'Digite a quantidade de reais que deseja vender: '
        puts "[Quantidade máxima: #{(@real*@dolar_price).round(2)}]"
        reais = gets.to_f
        if reais <= @real*@dolar_price 
          puts "Confime a operação:"
          puts "Venda de $ #{reais.round(2)} (S/N)"
          if gets.chomp.upcase.eql? "S" 
            @transactions << Transaction.real_to_dolar(self, reais, "VENDA")
            Layout.op_suc
          else
            Layout.op_canc
          end
        else
          Layout.limite_excedido
        end
    end

    def show_daily_op
      Layout.createTable(@transactions)
    end

    def show_cashier_status
      Layout.show_situation(self)
    end
  
  end
  