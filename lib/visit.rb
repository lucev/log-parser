# frozen_string_literal: true

class Visit
  attr_reader :page, :visitor

  def initialize(page:, visitor:)
    validate_presence(page, visitor)

    @page = page
    @visitor = visitor
  end

  private

  def validate_presence(page, visitor)
    if !valid_presence?(page) || !valid_presence?(visitor)
      raise ArgumentError, "Arguments can't be blank?"
    end
  end

  def valid_presence?(argument)
    return false if argument.nil? || argument.strip.empty?
    true
  end
end
