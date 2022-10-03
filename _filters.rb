# frozen_string_literal: false

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

# run filters and return the updated list
def filter_questions
    letter_list = search_letter(@students)
    length_list = search_length(letter_list)
    search_info(length_list)
  end