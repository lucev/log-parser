# frozen_string_literal: true

class LogParser
  def initialize
    @stats_service = PageStatsService.new
  end

  def load_data(source:)
    validate_source(source)
    LogFileReader.new.read(path: source)
  end

  def run(source:)
    visits_data = load_data(source: source)
    process_total_visits(visits: visits_data)
    process_unique_visits(visits: visits_data)
  end

  private

  def validate_source(source)
    raise ArgumentError, "Source can't be blank" if source.nil? ||
                                                    source.strip.empty?
  end

  def process_total_visits(visits:)
    total_visits_stats = @stats_service.ranked_total_visits(visits: visits)
    writer = StatsConsoleWriter.new
    writer.write_total_visits(pages_stats: total_visits_stats)
  end

  def process_unique_visits(visits:)
    unique_visits_stats = @stats_service.ranked_unique_visits(visits: visits)
    writer = StatsConsoleWriter.new
    writer.write_unique_visits(pages_stats: unique_visits_stats)
  end
end
