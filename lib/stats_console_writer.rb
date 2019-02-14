# frozen_string_literal: true

class StatsConsoleWriter
  def write_total_visits(pages_stats:)
    puts "\nTotal page views:\n\n"

    pages_stats.each do |stats|
      puts "#{stats.page} #{stats.total_visits} visits"
    end
  end

  def write_unique_visits(pages_stats:)
    puts "\nUnique page views:\n\n"

    pages_stats.each do |stats|
      puts "#{stats.page} #{stats.unique_visits} unique views"
    end
  end
end
