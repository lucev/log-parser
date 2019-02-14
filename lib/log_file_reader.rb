# frozen_string_literal: true

class LogFileReader
  def read(path:)
    validate_path(path)

    visits = []
    File.open(path, 'r') do |f|
      f.each_line do |line|
        visits << build_visit(line)
      end
      f.close
    end
    visits
  end

  def build_visit(line)
    page, visitor = line.split(' ')
    raise ArgumentError if page.nil? || visitor.nil?

    Visit.new(page: page, visitor: visitor)
  end

  private

  def validate_path(path)
    raise ArgumentError, "Log file doesn't exist" unless File.file?(path)
  end
end
