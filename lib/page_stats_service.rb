# frozen_string_literal: true

class PageStatsService
  def initialize
    @pages_stats = {}
  end

  def ranked_total_visits(visits:)
    process_visits(visits: visits) if @pages_stats.empty?
    @pages_stats.values.sort_by { |stats| [-stats.total_visits, stats.page] }
  end

  def ranked_unique_visits(visits:)
    process_visits(visits: visits) if @pages_stats.empty?
    @pages_stats.values.sort_by { |stats| [-stats.unique_visits, stats.page] }
  end

  private

  def find_or_initialize_pages_stats(page)
    unless @pages_stats.key?(page)
      @pages_stats[page] = PageStats.new(page: page)
    end
    @pages_stats[page]
  end

  def process_visits(visits:)
    visits.each do |visit|
      page_stats = find_or_initialize_pages_stats(visit.page)
      page_stats.add_visit(visitor: visit.visitor)
    end
    @pages_stats.values
  end
end
