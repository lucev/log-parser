# frozen_string_literal: true

require 'stats_console_writer'

describe StatsConsoleWriter do
  before do
    @stats_service = PageStatsService.new
    log_reader = LogFileReader.new
    @visits = log_reader.read(path: "#{RSPEC_ROOT}/fixtures/webserver.log")
  end

  describe 'write_total_visits' do
    it 'prints total visits' do
      expect do
        StatsConsoleWriter.new.write_total_visits(
          pages_stats: @stats_service.ranked_total_visits(visits: @visits)
        )
      end.to output(
        <<~HEREDOC

          Total page views:

          /help_page/1 6 visits
          /about/2 3 visits
          /contact 3 visits
          /home 3 visits
          /index 3 visits
          /about 2 visits
        HEREDOC
      ).to_stdout
    end
  end

  describe 'write_unique_visits' do
    it 'prints unique visits' do
      expect do
        StatsConsoleWriter.new.write_unique_visits(
          pages_stats: @stats_service.ranked_unique_visits(visits: @visits)
        )
      end.to output(
        <<~HEREDOC

          Unique page views:

          /help_page/1 5 unique views
          /home 3 unique views
          /index 3 unique views
          /about 2 unique views
          /about/2 2 unique views
          /contact 2 unique views
        HEREDOC
      ).to_stdout
    end
  end
end
