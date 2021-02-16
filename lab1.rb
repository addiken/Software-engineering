# encoding: utf-8
def inputWithCondition (str, is_int)
  if is_int
    print "Введите #{str}: "
    value = gets.to_i
  else
    print "Введите #{str}: "
    value = gets.chomp()
  end
  value
end

def printWithCondition(first, last, age)
  if age >= 18
    print "Привет, #{first} #{last}. Самое время заняться делом!\n"
  else
    print "Привет, #{first} #{last}. Тебе меньше 18 лет, но начать\nучиться программировать никогда не рано!\n "
  end
end

def comparisonOfNumbers(a, b, c)
  if a == c || b == c
    if a == c && b == c
      print 'Оба числа = '
      puts c
    elsif a == c
      print 'Первое число = '
      puts c
    else
      print 'Второе число = '
      puts c
    end
  else
    print 'Сумма чисел = '
    puts a + b
  end
end

def main
  loop do
    puts 'Выберите, что хотите сделать:'
    print("\n")
    puts "1 - Скрипт, который запрашивает имя, фамилию и возраст, а затем выдёт \n    приветствие, в зависимости от возраста."
    print("\n")
    puts "2 - Скрипт, который принимает пару чисел, если хотя бы одно равно 20 - \n    возвращает его, в противном случае выводит сумму этих чисел."
    print("\n")
    puts 'q - Выход'
    print("\n")
    i = gets.chomp()
    # system('cls')
    case i
    when '1'
      print("\n")
      print("======================================================================\n")
      print("\n")
      firstName = inputWithCondition('имя', false)
      lastName = inputWithCondition('фамилию', false)
      age = inputWithCondition('возраст', true)
      printWithCondition(firstName, lastName, age)
      print("\n")
      print("======================================================================\n")
      print("\n")
    when '2'
      print("\n")
      print("======================================================================\n")
      print("\n")
      a = inputWithCondition('первое число', true)
      b = inputWithCondition('второе число', true)
      c = 20
      comparisonOfNumbers(a, b, c)
      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'q'
      break
    else
      next
    end
  end
end

main