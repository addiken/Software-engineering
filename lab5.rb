require 'socket'

server = TCPServer.new(3000)

class CashMachine
  def initialize
    if File.exists?('balance.txt') 
      balance_value = File.open('balance.txt', 'r')
      @balance = balance_value.read.chomp.to_f
    else
      balance_value = File.open('balance.txt', 'w')
      balance_value.puts('100.00')
      balance_value.close
      balance_value = File.open('balance.txt', 'r')
      @balance = balance_value.read.chomp.to_f
    end
  end

  def withdraw(withdraw_value)
    return 'Error! Negative number entered.' if withdraw_value.negative?
    return 'Error! Not enough funds.' if @balance < withdraw_value
    @balance -= withdraw_value
    balance_value = File.open('balance.txt', 'w')
    balance_value.puts(@balance)
    balance_value.close
    "New balance: #{@balance}"
  end

  def deposit(deposit_value)
    return 'Error! Negative number entered.' if deposit_value.negative?
    @balance += deposit_value
    balance_value = File.open('balance.txt', 'w')
    balance_value.puts(@balance)
    balance_value.close
    "New balance: #{@balance}"
  end

  def balance
    "Balance: #{@balance}"
  end

end

while (connection = server.accept)

  cash_machine = CashMachine.new

  request = connection.gets
  m, full_path = request.split(' ')
  path = full_path.split('/')[1]
  if full_path.split('/')[1].include?('?')
    method = path.split('?')[0]
    value = path.split('?')[1].split('=')[1].to_i
  end

  connection.print "HTTP/1.1 200\r\n"
  connection.print "Content-Type: text/html\r\n"
  connection.print "\r\n"
  unless value.nil?
    connection.print case method
                     when 'deposit'
                       cash_machine.deposit(value)
                     when 'withdraw'
                       cash_machine.withdraw(value)
                     else
                       'error'
                     end
  end
  method = nil
  value = nil
  connection.print cash_machine.balance if path =='balance'
end
