# frozen_string_literal: false

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
  File.open(filename) do |file|
    CSV.foreach(file) do |line|
      name, age, birthplace, cohort = line
      @students << { name: name, age: age, birthplace: birthplace, cohort: cohort }
    end
  end
  # TODO: Is is possible to have error messages from this process?
  puts "\n📝 Loaded #{@students.size} student#{@students.count == 1 ? '' : 's'} from ".green + filename.to_s.red
end

# try and load student data on boot
def try_load_students_start
  filename = ARGV.first
  return if filename.nil?

  load_students(filename) if filename_exist?(filename)
end

# try and load student data from menu
def try_load_students_menu
  puts "\nEnter a filename to load from".green
  filename = $stdin.gets.strip
  load_students(filename) if filename_exist?(filename)
end

# check for existing filename
def filename_exist?(filename)
  if File.exist?(filename)
    puts "OK, Loading from '#{filename}'...".green
    true
  else
    puts "Sorry, '#{filename}' doesn't exist".red
    false
  end
end
