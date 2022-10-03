# frozen_string_literal: false

# print the menu and ask the user what to do
def print_menu
  puts "\n1. Input the students".green
  puts '2. Show the students'
  puts '3. Save the list to a file'
  puts '4. Load the list from a file'
  puts "9. Exit\n".red
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

# Print and center the header message
def print_header
  puts ' '
  puts ' The students of Villains Academy '.center(42, '*')
  puts '------------------------------------------'.red
end

# print the students
def print_students_list
  filtered_list = filter_questions
  print_header
  print(filtered_list)
  print_footer(@students)
end

# Returns footer message
def print_footer(list)
  puts "\nOverall, we have #{list.count} great students\n".red
end
