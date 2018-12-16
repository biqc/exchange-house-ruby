require_relative 'cashier'
require_relative 'database'

class Transaction

  attr_reader :id, :tran_type, :currency, :dolar_price, :total

  def initialize(tran_type, currency, dolar_price, total)
    @tran_type = tran_type
    @currency = currency
    @dolar_price = dolar_price
    @total = total 
  end

  def self.real_to_dolar(cashier, dolares, type)
    cashier.real = cashier.real + dolares * cashier.dolar_price
    cashier.dolar = cashier.dolar - dolares

    if type.eql? "COMPRA"
      Database.insert_transaction(cashier.id , Transaction.new(type, "DOLAR", cashier.dolar_price, dolares))
    else
      Database.insert_transaction(cashier.id , Transaction.new(type, "REAL", cashier.dolar_price, dolares / cashier.dolar_price))
    end
    Database.update_cashier(cashier.id, cashier.dolar_price, cashier.dolar, cashier.real, cashier.operador)
  end

  def self.dolar_to_real(cashier, reais, type)
    value_in_dolar = reais / cashier.dolar_price

    cashier.dolar = cashier.dolar + value_in_dolar
    cashier.real = cashier.real - reais

    if type.eql? "COMPRA"
      Database.insert_transaction(cashier.id , Transaction.new(type, "REAL", cashier.dolar_price, value_in_dolar))
    else
      Database.insert_transaction(cashier.id , Transaction.new(type, "DOLAR", cashier.dolar_price, reais))
    end
    Database.update_cashier(cashier.id, cashier.dolar_price, cashier.dolar, cashier.real, cashier.operador)
  end


end
