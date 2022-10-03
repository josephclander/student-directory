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
