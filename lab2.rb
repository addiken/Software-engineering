# Получение введенного значения
def inputWithCondition (str, is_int)
  if is_int
    print "Введите #{str}: "
    value = gets.to_i
  else
    print "Введите #{str}: "
    value = gets.chomp
  end
  value
end

# Скрипт №1
def script1
  s = inputWithCondition("число и строку через пробел", false).split(' ')
  str = s[1].chomp
  i = s[0].to_i
  if str[-2, 2] == ('CS')
    puts("2 ^ #{i} = #{2**i}")
  else
    puts("#{str} наоборот --> #{str.reverse}")
  end
end

# Скрипт №1
def script2
  pokemons = []
  iterations = inputWithCondition('количество покемонов', true)
  i = 0
  while i < iterations do
    _name = inputWithCondition('имя покемона', false)
    _color = inputWithCondition('цвет покемона', false)
    pokemon = { "name" => _name, "color" => _color }
    pokemons << pokemon
    i+=1
  end
  puts('----------------------------------------------------------------------')
  puts(pokemons)
end

def main
  loop do
    puts 'Выберите, что хотите сделать:'
    print("\n")
    puts "1 - Cкрипт, который принимает число и слово, если слово
заканчивается на “CS” - выводит на экран цифру 2 в степени (длины введенного
слова), если не заканчивается - выводит слово задом наперед"
    print("\n")
    puts '2 - Скрипт, который выводит массив покемонов.'
    print("\n")
    puts 'q - Выход'
    print("\n")
    i = gets.chomp
    # system('cls')
    case i
    when '1'
      print("\n")
      print("======================================================================\n")
      print("\n")
      # Скрипт №1
      script1
      print("\n")
      print("======================================================================\n")
      print("\n")
    when '2'
      print("\n")
      print("======================================================================\n")
      print("\n")
      # Скрипт №2
      script2
      print("\n")
      print("======================================================================\n")
      print("\n")
    when 'q'
      break
    end
  end
end

main
