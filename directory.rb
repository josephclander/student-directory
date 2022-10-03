# frozen_string_literal: false

require_relative '_colours'
require_relative '_interactiveMenu'
require_relative '_data'
require_relative '_filters'
require_relative '_prints'
require_relative '_persistence'

# global instance variables
@students = []

try_load_students
interactive_menu
