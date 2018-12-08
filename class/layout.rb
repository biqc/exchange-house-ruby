require 'terminal-table'

class Layout 

  def self.menu
    system "cls"
    puts '[1] Comprar dólares'
    puts '[2] Vender dólares'
    puts '[3] Comprar reais'
    puts '[4] Vender reais'
    puts '[5] Ver operações do dia'
    puts '[6] Ver situação do caixa'
    puts '[7] Sair'
    print 'Selecione uma opção: '
    opt = gets.to_i
    system "cls"

    opt
  end

  def self.createTable(transactions)
    rows = []
    transactions.each do |t|
      rows << [t.id, t.tran_type, t.currency, t.dolar_price, t.total.round(2)]
    end

    table = Terminal::Table.new :headings => ['ID', 'TIPO_TRANS', 'MOEDA', 'COT_DOLAR', 'TOTAL($)'], :rows => rows
    puts table
    Layout.enter_continue
  end

  def self.limite_excedido
    puts 'Valor limite excedido!'
    puts 'Favor digitar um valor menos ou igual a quantidade máxima'
    self.enter_continue
  end

  def self.op_suc
    puts "Operação realizada com sucesso!"
    self.enter_continue
  end

  def self.op_canc
    puts "Operação cancelada."
    self.enter_continue
  end

  def self.enter_continue
    puts "\nAperte [ENTER] para continuar."
    gets
  end

  def self.show_situation(cashier)
    row = []
    row << [cashier.real.round(2), cashier.dolar.round(2), cashier.dolar_price]
    table = Terminal::Table.new :headings => ['TOTAL_REAL', 'TOTAL_DOLAR', 'COTAÇÂO'], :rows => row
    puts table
    self.enter_continue
  end

end
