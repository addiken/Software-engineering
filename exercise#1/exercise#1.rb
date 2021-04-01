class CashMachine
  def initialize
    if File.exists?("balance.txt")
      balanceValue = File.open('balance.txt', 'r')
      @balance = balanceValue.read.chomp.to_f
    else
      balanceValue = File.open('balance.txt', 'w')
      balanceValue.puts("100.00")
      balanceValue.close
      balanceValue = File.open('balance.txt', 'r')
      @balance = balanceValue.read.chomp.to_f
    end
  end

  def withdraw
    withdrawValue = inputWithCondition('списываемую сумму', true)
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
    puts("Новый баланс: #{@balance}")
  end

  def deposit
    depositeValue = inputWithCondition('пополняемую сумму', true)
    if depositeValue < 0
      abort 'Ошибка! Введено отрицательное число.'
      exit
    end
    @balance += depositeValue
    balanceValue = File.open('balance.txt', 'w')
    balanceValue.puts(@balance)
    balanceValue.close
    puts("Новый баланс: #{@balance}")
  end

  def balance
    puts("Текущий баланс: #{@balance}")
  end

end

# Получение введенного значения
def inputWithCondition (str, is_float)
  if is_float
    print "Введите #{str}: "
    value = gets.to_f
  else
    print "Введите #{str}: "
    value = gets.chomp
    value.upcase
  end
  value
end


def main

  cashMachine = CashMachine.new

  loop do
    puts 'Выберите, что хотите сделать:'
    print("\n")
    puts 'B - Показать баланс'
    print("\n")
    puts 'W - Списать'
    print("\n")
    puts 'D - Пополнить'
    print("\n")
    puts 'Q - Выйти'
    print("\n")
    i = gets.chomp.upcase
    # system('cls')
    case i
    when 'D'
      print("\n")
      print("======================================================================\n")
      print("\n")

      cashMachine.deposit

      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'W'
      print("\n")
      print("======================================================================\n")
      print("\n")

      cashMachine.withdraw

      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'B'
      print("\n")
      print("======================================================================\n")
      print("\n")

      cashMachine.balance

      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'Q'
      break
    end
  end
end

main
