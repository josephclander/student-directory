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
  puts '------------------------------------------'.red
end

def print(students)
  index = 0
  while index < students.size
    student = students[index]
    # student = { name: name, age: age, pob: pob, cohort: cohort }
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
    student = {}
    questions = %w[name age pob cohort]
    questions.each do |question|
      puts question.capitalize.green
      answer = gets.gsub!(/$\n/, '')
      answer = 'unknown' if answer == ''
      student[question.to_sym] = answer
    end
    students.push(student)
    puts "Now we have #{students.count} student#{students.count == 1 ? '' : 's'}"
    puts 'Finished? y/n'.green
    finished = gets.gsub!(/$\n/, '')
    until %w[y n].include?(finished)
      puts 'Finished? y/n'.green
      finished = gets.gsub!(/$\n/, '')
    end
    stop = true if finished == 'y'
  end
  students
end

def search_letter(full_list)
  puts 'Print names beginning with letter?'.green
  puts 'For all, hit return'.green
  input = gets.gsub!(/$\n/, '')
  new_list = full_list
  new_list = full_list.select { |student| student[:name][0].downcase == input.downcase } if input != ''
  new_list
end

# assume input is integer character
def search_length(full_list)
  puts 'Print names less than <number> letters?'.green
  puts 'For all, hit return'.green
  input = gets.gsub!(/$\n/, '').to_i
  new_list = full_list
  new_list = full_list.select { |student| student[:name].length < input } if input != 0
  new_list
end

# return only given info selection
def search_info(full_list)
  puts 'Choose only one category?'.green
  puts 'age | pob | cohort'.red
  puts 'For all, hit return'.green
  input = gets.gsub!(/$\n/, '')
  new_list = full_list
  if input != 0 && %w[age pob cohort].include?(input)
    new_list = full_list.map do |student|
      filtered_student = {}
      # student = { name: name, age: age, pob: pob, cohort: cohort }
      filtered_student[:name] = student[:name]
      filtered_student[input.to_sym] = student[input.to_sym]
      filtered_student
    end
  end
  new_list
end

students = input_students
letter_list = search_letter(students)
length_list = search_length(letter_list)
info_list = search_info(length_list)
print_header
print(info_list)
print_footer(students)
