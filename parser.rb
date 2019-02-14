#!/usr/bin/env ruby
# frozen_string_literal: true

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

if ARGV.size == 1
  log_parser = LogParser.new
  log_parser.run(source: ARGV[0])
else
  puts "Wrong number of arguments (#{ARGV.size} instead of 1). Example: ./parser.rb webserver.log"
end
