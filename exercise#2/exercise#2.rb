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

def withdraw
  balance = File.open('balance.txt', 'r')
  withdrawValue = inputWithCondition('списываемую сумму', true)
  balanceValue = balance.read
  value = balanceValue.chomp.to_f
  if withdrawValue < 0
    abort 'Ошибка! Введено отрицательное число.'
  end
  if value < withdrawValue
    abort 'Ошибка! Нехватает средств.'
  end
  value -= withdrawValue
  File.open('balance.txt', 'w') do |file| file.puts value end
  puts("Новый баланс: #{value}")
  balance.close
end

def deposit
  balance = File.open('balance.txt', 'r')
  depositeValue = inputWithCondition('пополняемую сумму', true)
  balanceValue = balance.read
  value = balanceValue.chomp.to_f
  if depositeValue < 0
    abort 'Ошибка! Введено отрицательное число.'
    exit
  end
  value += depositeValue
  File.open('balance.txt', 'w') do |file| file.puts value end
  puts("Новый баланс: #{value}")
  balance.close
end

def balance
  puts(File.read('balance.txt'))
end

def main
  if File.exists?("balance.txt")
    balance
  else
    balanceFile = File.open('balance.txt', 'w')
    balanceFile.puts("100.00")
    balanceFile.close
  end

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

      deposit

      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'W'
      print("\n")
      print("======================================================================\n")
      print("\n")

      withdraw

      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'B'
      print("\n")
      print("======================================================================\n")
      print("\n")

      balance

      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'Q'
      break
    end
  end
end

main
