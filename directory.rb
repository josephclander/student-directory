# add colors to String
class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end
end

def print_header
  puts ' The students of Villains Academy '.center(42, '*')
  puts '-----------------------------------------_'.red
end

def print(students)
  index = 0
  while index < students.size
    student = students[index]
    # student = { name: name, age: age, pob: pob, cohort: :november }
    details = student.map { |key, value| "#{key}: ".green + "#{value}" }
    puts "#{index + 1}. " + details.join(', ')
    index += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts 'Please enter the details of the students'.green
  puts 'To finish, just hit return twice'.green

  students = []
  stop = false
  until stop
    puts 'Name:'.green
    name = gets.chomp
    puts 'Age:'.green
    age = gets.chomp
    puts 'Country of Birth:'.green
    pob = gets.chomp.green
    students << { name: name, age: age, pob: pob, cohort: :november }
    puts "Now we have #{students.count} students"
    puts 'Finished? y/n'.green
    finished = gets.chomp
    until %w[y n].include?(finished)
      puts 'Finished? y/n'.green
      finished = gets.chomp
    end
    stop = true if finished == 'y'
  end
  students
end

def search_letter(full_list)
  puts 'Print names beginning with letter?'.green
  puts 'For all, hit return'.green
  input = gets.chomp
  new_list = full_list
  new_list = full_list.select { |student| student[:name][0].downcase == input.downcase } if input != ''
  new_list
end

# assume input is integer character
def search_length(full_list)
  puts 'Print names less than <number> letters?'.green
  puts 'For all, hit return'.green
  input = gets.chomp.to_i
  new_list = full_list
  new_list = full_list.select { |student| student[:name].length < input } if input != 0
  new_list
end

students = input_students
letter_list = search_letter(students)
length_list = search_length(letter_list)
print_header
print(length_list)
print_footer(students)
