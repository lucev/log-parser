# frozen_string_literal: true

require 'log_parser'
require 'page_stats_service'
require 'log_file_reader'
require 'visit'
require 'stats_console_writer'

describe LogParser do
  before do
    @log_size = 20
    @valid_path = "#{RSPEC_ROOT}/fixtures/webserver.log"
    @log_parser = LogParser.new
  end

  describe 'run' do
    it 'executes program' do
      expect(@log_parser).to receive(:load_data).with(source: @valid_path)
      expect_any_instance_of(PageStatsService).to receive(:ranked_total_visits)
      expect_any_instance_of(PageStatsService).to receive(:ranked_unique_visits)
      expect_any_instance_of(StatsConsoleWriter).to receive(:write_total_visits)
      expect_any_instance_of(StatsConsoleWriter).to receive(:write_unique_visits)

      @log_parser.run(source: @valid_path)
    end
  end

  describe 'load_data' do
    context 'when source is nil' do
      it 'raises ArgumentError' do
        expect { @log_parser.load_data(source: nil) }
          .to raise_error(ArgumentError)
      end
    end
    context 'when source is blank' do
      it 'raises ArgumentError' do
        expect { @log_parser.load_data(source: '  ') }
          .to raise_error(ArgumentError)
      end
    end
    context 'when source is valid' do
      it 'does not raise ArgumentError' do
        expect { @log_parser.load_data(source: @valid_path) }
          .to_not raise_error(ArgumentError)
      end
      it 'return array of visits' do
        expect(@log_parser.load_data(source: @valid_path)).to include(
          have_attributes(class: Visit, page: '/help_page/1',
                          visitor: '126.318.035.038'),
          have_attributes(class: Visit, page: '/contact',
                          visitor: '184.123.665.067')
        )
      end
      it 'reads entire log' do
        expect(@log_parser.load_data(source: @valid_path).size)
          .to eq @log_size
      end
    end
  end
end
