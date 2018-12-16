require 'sqlite3'
require_relative 'cashier'

class Database

  def initialize 
    SQLite3::Database.new "cambio.db"
    self.createTables
  end

  def self.openDB
    SQLite3::Database.open "cambio.db"
  end

  def createTables
    db = Database.openDB
    db.execute 'CREATE TABLE IF NOT EXISTS cashiers('\
      'id_cashier INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'\
      'date_cashier TEXT NOT NULL,'\
      'dolar_price REAL NOT NULL,'\
      'dolar_count REAL NOT NULL,'\
      'real_count REAL NOT NULL,'\
      'operador TEXT NOT NULL'\
    ');'
    db.execute 'CREATE TABLE IF NOT EXISTS transactions ('\
      'id_transaction INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'\
      'tran_type TEXT NOT NULL,'\
      'currency TEXT NOT NULL,'\
      'dolar_price REAL NOT NULL,'\
      'total REAL NOT NULL,'\
      'id_cashier INTEGER NOT NULL,'\
      'FOREIGN KEY(id_cashier) REFERENCES cashier(id_cashier)'\
    ');'
    db.close 
  end

  def self.insert_transaction(id, transaction)
    db = Database.openDB
    db.execute "INSERT INTO transactions (tran_type, currency, dolar_price, total, id_cashier) VALUES ("\
      "'#{transaction.tran_type}', '#{transaction.currency}', '#{transaction.dolar_price}', '#{transaction.total}', '#{id}');"
    db.close
  end

  def self.get_transactions(id)
    result = []
    db = Database.openDB
    if db
      result = db.execute "SELECT id_transaction, tran_type, currency, dolar_price, total, operador FROM transactions WHERE id_cashier = '#{id}'"
    else
      puts 'DB não disponível.'
    end
    db.close
    result
  end

  def create_cashier(cot, dol, rea, ope)
    db = Database.openDB
    db.execute "INSERT INTO cashiers (date_cashier, dolar_price, dolar_count, real_count, operador)"\
     "VALUES (date('now'), #{cot}, #{dol}, #{rea}, '#{ope}');"
    id = db.execute "SELECT id_cashier FROM cashiers WHERE date_cashier = date('now');"
    db.close
    id[0][0]
  end

  def self.update_cashier(id, cot, dol, rea, ope)
    db = Database.openDB
    db.execute "UPDATE cashiers SET dolar_price = '#{cot}', dolar_count = '#{dol}', real_count = '#{rea}', operador = '#{ope}' WHERE id_cashier = '#{id}';"
    db.close
  end

  def start_cashier
    db = Database.openDB
    result = []
    result = db.execute "SELECT * FROM cashiers WHERE date_cashier = date('now');" 
    db.close
    if result != []
      puts "Cashier do dia atual: #{result[0][1]}"
      puts "Cotação: #{result[0][2]} | Qtd.$: #{result[0][3]} | Qtd.R$: #{result[0][4]}"
      puts "Gostaria de atualizar os dados? (S/N)"
      if gets.chomp.upcase.eql? "S" 
        puts 'Digite a cotação do dólar atual:'
        cot = gets.to_f
        puts 'Digite a quantidade de dólares disponíveis:'
        dol = gets.to_f  
        puts 'Digite a quantidade de reais disponíveis:'
        rea = gets.to_f 
        puts 'Digite o nome do operador do caixa:'
        ope = gets.chomp.upcase
        Database.update_cashier(result[0][0], cot, dol, rea, ope)
        return Cashier.new(result[0][0], cot, dol, rea, ope)
      else
        return Cashier.new(result[0][0], result[0][2], result[0][3], result[0][4], result[0][5])
      end
    else 
      puts 'Digite a cotação do dólar atual:'
      cot = gets.to_f
      puts 'Digite a quantidade de dólares disponíveis:'
      dol = gets.to_f  
      puts 'Digite a quantidade de reais disponíveis:'
      rea = gets.to_f 
      puts 'Digite o nome do operador do caixa:'
      ope = gets.chomp.upcase
      id = self.create_cashier(cot, dol, rea, ope)
      return Cashier.new(id, cot, dol, rea, ope)
    end
  end

end