def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  # create an empty array
  students = [] # <-- missed should be array
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  until name.empty? # <-- missed questions mark
    # add the student hash to the array
    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students" # <-- missed 's' on students
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header # <-- missed underscore
  puts 'The students of my cohort at Makers Academy'
  puts '-------------'
end

def print(students)
  students.each do |student| # <-- missed 's' on students
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
