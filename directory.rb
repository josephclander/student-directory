# students = [
#   { name: 'Dr. Hannibal Lecter', cohort: :november },
#   { name: 'Darth Vader', cohort: :november },
#   { name: 'Nurse Ratched', cohort: :november },
#   { name: 'Michael Corleone', cohort: :november },
#   { name: 'Alex DeLarge', cohort: :november },
#   { name: 'The Wicked Witch of the West', cohort: :november },
#   { name: 'Terminator', cohort: :november },
#   { name: 'Freddy Krueger', cohort: :november },
#   { name: 'The Joker', cohort: :november },
#   { name: 'Joffrey Baratheon', cohort: :november },
#   { name: 'Norman Bates', cohort: :november }
# ]
def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print(students)
  index = 0
  while index < students.size
    student = students[index]
    # student = { name: name, age: age, pob: pob, cohort: :november }
    details = student.map { |key, value| "#{key}: #{value}" }
    puts "#{index + 1}. " + details.join(', ')
    index += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts 'Please enter the details of the students'
  puts 'To finish, just hit return twice'

  students = []
  stop = false
  until stop
    puts 'Name:'
    name = gets.chomp
    puts 'Age:'
    age = gets.chomp
    puts 'Country of Birth:'
    pob = gets.chomp
    students << { name: name, age: age, pob: pob, cohort: :november }
    puts "Now we have #{students.count} students"
    puts 'Finished? y/n'
    finished = gets.chomp
    until %w[y n].include?(finished)
      puts 'Finished? y/n'
      finished = gets.chomp
    end
    stop = true if finished == 'y'
  end
  students
end

def search_letter(full_list)
  puts 'Print names beginning with letter?'
  puts 'For all, hit return'
  input = gets.chomp
  new_list = full_list
  new_list = full_list.select { |student| student[:name][0].downcase == input.downcase } if input != ''
  new_list
end

# assume input is integer character
def search_length(full_list)
  puts 'Print names less than <number> letters?'
  puts 'For all, hit return'
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
