class FileDealer

  def self.save(transactions)
    File.open('../transactions.txt', File::WRONLY|File::CREAT) do |file|
      transactions.each do |t|
        file.puts("#{t.id}:#{t.tran_type}:#{t.currency}:#{t.dolar_price}:#{t.total}")
      end
    end
  end

end
