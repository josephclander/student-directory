# frozen_string_literal: false

# add colors to String
class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end
end

# global instance variables
@students = []

# print the menu and ask the user what to do
def print_menu
  puts ' '
  puts '1. Input the students'.green
  puts '2. Show the students'
  puts '9. Exit'.red # 9 because we'll be adding more items
  puts ' '
end

# run filters and retur the updated list
def filter_questions
  letter_list = search_letter(@students)
  length_list = search_length(letter_list)
  search_info(length_list)
end

# print the students
def print_students_list
  filtered_list = filter_questions
  print_header
  print(filtered_list)
  print_footer(@students)
end

# choose option from input
def process(selection)
  case selection
  when '1' then input_students
  when '2' then print_students_list
  when '9' then exit
  else
    puts "I don't know what you meant, try again"
  end
end

# user menu options
def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

# Print and center the header message
def print_header
  puts ' '
  puts ' The students of Villains Academy '.center(42, '*')
  puts '------------------------------------------'.red
end

# Prints the current list of students are being filtered
def print(list)
  amount = list.size
  return 'No students' if amount.zero?

  index = 0
  while index < amount
    student = list[index]
    # student = { name: name, age: age, birthplace: birthplace, cohort: cohort }
    details = student.map { |key, value| "#{key}: #{value.green}" }
    puts "#{index + 1}. ".red + details.join(', ')
    index += 1
  end
end

# Returns footer message
def print_footer(list)
  puts "\nOverall, we have #{list.count} great students\n".red
end

def ask_name
  puts 'Name'.green
  gets.gsub!(/$\n/, '')
end

def ask_questions(name)
  student = {}
  student[:name] = name
  questions = %w[age birthplace cohort]
  questions.each do |question|
    puts question.capitalize.green
    answer = gets.gsub!(/$\n/, '')
    answer = 'unknown' if answer == ''
    student[question.to_sym] = answer
  end
  student
end

# collect student info
def collect_student_info
  name = ask_name
  if name != ''
    student = ask_questions(name)
    @students.push(student)
    puts "Now we have #{@students.count} student#{@students.count == 1 ? '' : 's'}".red
  else
    puts 'No student entered'
  end
end

def check_finished
  puts 'Finished? y/n'.green
  finished = gets.gsub!(/$\n/, '')
  until %w[y n].include?(finished)
    puts 'Finished? y/n'.green
    finished = gets.gsub!(/$\n/, '')
  end
  finished == 'y'
end

# User inputs student info
def input_students
  puts 'Please enter the details of the students'.green
  stop = false
  until stop
    collect_student_info
    stop = check_finished
  end
end

# Returns list of students with given first letter
def search_letter(list)
  puts 'Print names beginning with letter?'.green
  puts 'For all, hit return'.green
  input = gets.gsub!(/$\n/, '')
  new_list = list
  new_list = list.select { |student| student[:name][0].downcase == input.downcase } if input != ''
  new_list
end

# Returns list of students with fewer letters than input
def search_length(list)
  puts 'Print names less than <number> letters?'.green
  puts 'For all, hit return'.green
  # assume input is integer character
  input = gets.gsub!(/$\n/, '').to_i
  new_list = list
  new_list = list.select { |student| student[:name].length < input } if input != 0
  new_list
end

# Returns list of students with input category
def filter_by_group(list, input)
  new_list = []
  list.map do |student|
    filtered_student = {}
    # student = { name: name, age: age, birthplace: birthplace, cohort: cohort }
    filtered_student[:name] = student[:name]
    filtered_student[input.to_sym] = student[input.to_sym]
    new_list.push(filtered_student)
  end
  new_list
end

# return only given info selection
def search_info(list)
  puts 'Choose only one category?'.green
  puts 'age | birthplace | cohort'.red
  puts 'For all, hit return'.green
  input = gets.gsub!(/$\n/, '')
  new_list = list
  new_list = filter_by_group(list, input) if input != 0 && %w[age birthplace cohort].include?(input)
  new_list
end

interactive_menu
