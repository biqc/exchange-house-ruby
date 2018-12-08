require_relative 'cashier'

class Transaction

  attr_reader :id, :tran_type, :currency, :dolar_price, :total

  def initialize(id, tran_type, currency, dolar_price, total)
    @id = id
    @tran_type = tran_type
    @currency = currency
    @dolar_price = dolar_price
    @total = total 
  end

  def self.real_to_dolar(cashier, dolares, type)
    cashier.real = cashier.real + dolares * cashier.dolar_price
    cashier.dolar = cashier.dolar - dolares

    id = cashier.transactions.size == 0 ? 1 : cashier.transactions.last.id + 1

    if type.eql? "COMPRA"
      return Transaction.new(id, type, "DOLAR", cashier.dolar_price, dolares)
    else
      return Transaction.new(id, type, "REAL", cashier.dolar_price, dolares / cashier.dolar_price)
    end
  end

  def self.dolar_to_real(cashier, reais, type)
    value_in_dolar = reais / cashier.dolar_price

    cashier.dolar = cashier.dolar + value_in_dolar
    cashier.real = cashier.real - reais

    id = cashier.transactions.size == 0 ? 1 : cashier.transactions.last.id + 1

    if type.eql? "COMPRA"
      return Transaction.new(id, type, "REAL", cashier.dolar_price, value_in_dolar)
    else
      return Transaction.new(id, type, "DOLAR", cashier.dolar_price, reais)
    end
  end


end
