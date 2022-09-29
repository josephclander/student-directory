# frozen_string_literal: false

require 'csv'
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
  puts '3. Save the list to a file'
  puts '4. Load the list from a file'
  puts '9. Exit'.red # 9 because we'll be adding more items
  puts ' '
end

# save student data to file
def save_students
  # we have the data so it's ok to overwrite it
  puts "\nEnter a filename to save to".green
  filename = $stdin.gets.strip
  filename = filename == '' ? 'student.csv' : filename
  CSV.open(filename, 'w') do |csv|
    @students.each do |student|
      csv << [student[:name], student[:age], student[:birthplace], student[:cohort]]
    end
  end
  # TODO: Is is possible to have error messages from this process?
  puts "\n📝 Saved #{@students.size} student#{@students.count == 1 ? '' : 's'} to ".green + filename.to_s.red
end

# load student data from  file
def load_students(filename)
  # HACK: Removed default in param so not asked file name on load
  if filename.nil?
    puts "\nEnter a filename to load from".green
    filename = $stdin.gets.strip
    filename = filename == '' ? 'student.csv' : filename
  end
  File.open(filename) do |file|
    CSV.foreach(file) do |line|
      name, age, birthplace, cohort = line
      @students << { name: name, age: age, birthplace: birthplace, cohort: cohort }
    end
  end
  # TODO: Is is possible to have error messages from this process?
  puts "\n📝 Loaded #{@students.size} student#{@students.count == 1 ? '' : 's'} from ".green + filename.to_s.red
end

# try and load student data
def try_load_students
  filename = ARGV.first
  return if filename.nil?

  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
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
  when '3' then save_students
  when '4' then load_students(nil)
  when '9' then exit
  else
    puts "I don't know what you meant, try again"
  end
end

# user menu options
def interactive_menu
  loop do
    print_menu
    process($stdin.gets.chomp)
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
  $stdin.gets.gsub!(/$\n/, '')
end

def ask_questions(name)
  student = {}
  student[:name] = name
  questions = %w[age birthplace cohort]
  questions.each do |question|
    puts question.capitalize.green
    answer = $stdin.gets.gsub!(/$\n/, '')
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
  finished = $stdin.gets.gsub!(/$\n/, '')
  until %w[y n].include?(finished)
    puts 'Finished? y/n'.green
    finished = $stdin.gets.gsub!(/$\n/, '')
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
  input = $stdin.gets.gsub!(/$\n/, '')
  new_list = list
  new_list = list.select { |student| student[:name][0].downcase == input.downcase } if input != ''
  new_list
end

# Returns list of students with fewer letters than input
def search_length(list)
  puts 'Print names less than <number> letters?'.green
  puts 'For all, hit return'.green
  # assume input is integer character
  input = $stdin.gets.gsub!(/$\n/, '').to_i
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
  input = $stdin.gets.gsub!(/$\n/, '')
  new_list = list
  new_list = filter_by_group(list, input) if input != 0 && %w[age birthplace cohort].include?(input)
  new_list
end

try_load_students
interactive_menu
