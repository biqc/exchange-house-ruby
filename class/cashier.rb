require_relative 'transaction'
require_relative 'layout'

class Cashier 
    attr_accessor :dolar, :real, :currency

    def initialize(currency, dolar, real)
      @currency = currency
      @dolar = dolar
      @real = real
      
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
      puts "[Quantidade máxima: #{@dolar}]"
      dolares = gets.to_f
      if dolares <= @dolar
        Transaction.real_to_dolar(self, dolares)
      else
        Layout.limite_excedido
      end
         
    end
  
    def buyReal
      puts 'Digite a quantidade de reais que deseja comprar: '
      puts "[Quantidade máxima: #{@real}]"
      reais = gets.to_f
      if reais <= @real 
        Transaction.dolar_to_real(self, reais)
      else
        Layout.limite_excedido
      end
    end
  
    def sellDolar
        puts 'Digite a quantidade de dólares que deseja vender: '
        puts "[Quantidade máxima: #{@real/@currency}]"
        dolares = gets.to_f
        if dolares <= @real/@currency 
          Transaction.dolar_to_real(self, dolares)
        else
          Layout.limite_excedido
        end
    end
  
    def sellReal
        puts 'Digite a quantidade de reais que deseja vender: '
        puts "[Quantidade máxima: #{@real*@currency}]"
        reais = gets.to_f
        if reais <= @real*@currency 
          Transaction.dolar_to_real(self, reais)
        else
          Layout.limite_excedido
        end
    end

    def show_daily_op
      
    end

    def show_cashier_status
      
    end
  
  end
  