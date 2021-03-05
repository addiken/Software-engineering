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

def exercise
  age = inputWithCondition('возраст студентов', false)
  file = File.open('students.txt')
  result = File.open('result.txt', 'w')
  file_data = file.readlines.map(&:chomp)
  i = 0
  while i < file_data.length do
    str = file_data[i]
    if str[-2, 2] == age
      result.puts(str)
    end
    i+=1
  end
  file.close
  result.close
  puts(file_data = File.read("result.txt").split("\n"))
end

def main
  exercise
  puts(file_data = File.read("result.txt").split("\n"))


  print("\n")
  print("======================================================================\n")
  print("\n")

  loop do
    puts 'Выберите, что хотите сделать:'
    print("\n")
    puts '1 - Повторить'
    print("\n")
    puts '-1 - Выход'
    print("\n")
    i = gets.chomp
    # system('cls')
    case i
    when '1'
      print("\n")
      print("======================================================================\n")
      print("\n")

      exercise

      print("\n")
      print("======================================================================\n")
      print("\n")
    when '-1'
      break
    end
  end
end

main
