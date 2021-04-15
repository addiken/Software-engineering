require 'socket'

server = TCPServer.new(3000)

class CashMachine
  def initialize
    if File.exists?('balance.txt')
      balanceValue = File.open('balance.txt', 'r')
      @balance = balanceValue.read.chomp.to_f
    else
      balanceValue = File.open('balance.txt', 'w')
      balanceValue.puts('100.00')
      balanceValue.close
      balanceValue = File.open('balance.txt', 'r')
      @balance = balanceValue.read.chomp.to_f
    end
  end

  def withdraw(withdrawValue)
    if withdrawValue < 0
      abort 'Ошибка! Введено отрицательное число.'
    end
    if @balance < withdrawValue
      abort 'Ошибка! Нехватает средств.'
    end
    @balance -= withdrawValue
    balanceValue = File.open('balance.txt', 'w')
    balanceValue.puts(@balance)
    balanceValue.close
    "Новый баланс: #{@balance}"
  end

  def deposit(depositeValue)
    if depositeValue < 0
      abort 'Ошибка! Введено отрицательное число.'
      exit
    end
    @balance += depositeValue
    balanceValue = File.open('balance.txt', 'w')
    balanceValue.puts(@balance)
    balanceValue.close
    "Новый баланс: #{@balance}"
  end

  def balance
    "Текущий баланс: #{@balance}"
  end

end

while connection = server.accept

  cashMachine = CashMachine.new

  request = connection.gets
  m, full_path = request.split(' ')
  path = full_path.split('/')[1]
  method = path.split('?')[0]
  value = path.split('?')[1].split('=')[1].to_i

  connection.print "HTTP/1.1 200\r\n"
  connection.print "Content-Type: text/html\r\n"
  connection.print "\r\n"

  connection.print case method
                   when 'deposit'
                     cashMachine.deposit(value)
                   when 'withdraw'
                     cashMachine.withdraw(value)
                   when 'balance'
                     cashMachine.balance
                   else
                     'ошиб очка'
                   end
end
