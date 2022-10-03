# frozen_string_literal: false

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

# check user has finished entering students
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
