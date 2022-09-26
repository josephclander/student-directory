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
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'

  students = []

  name = gets.chomp

  until name.empty? ## this works as enter twice gives empty
    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students"
    name = gets.chomp
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

students = input_students
letter_list = search_letter(students)
print_header
print(letter_list)
print_footer(students)
