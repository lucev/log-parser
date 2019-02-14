# frozen_string_literal: true

class PageStats
  attr_reader :page, :total_visits

  def initialize(page:)
    @page = page
    @total_visits = 0
    @visitors = Hash.new(0)
  end

  def add_visit(visitor:)
    @total_visits += 1
    @visitors[visitor] += 1
  end

  def unique_visits
    @visitors.size
  end
end
