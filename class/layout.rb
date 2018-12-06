class Layout 

  def self.menu

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

  def self.createTable

  end

  def self.limite_excedido
    puts 'Valor limite excedido!'
    puts 'Favor digitar um valor menos ou igual a quantidade máxima'
  end

end
