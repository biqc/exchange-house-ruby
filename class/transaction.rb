require_relative 'cashier'

class Transaction

  def self.real_to_dolar(cashier, dolares)
    cashier.real = cashier.real + dolares * cashier.currency
    cashier.dolar = cashier.dolar - dolares
  end

  def self.dolar_to_real(cashier, reais)
    cashier.dolar = cashier.dolar + reais / cashier.currency
    cashier.real = cashier.real - reais
  end


end
