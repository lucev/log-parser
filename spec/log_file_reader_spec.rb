# frozen_string_literal: true

require 'log_file_reader'

describe LogFileReader do
  describe 'read' do
    before do
      @log_size = 20
      @valid_path = "#{RSPEC_ROOT}/fixtures/webserver.log"
      @invalid_path = "#{RSPEC_ROOT}/fixtures/missing.log"
    end

    context 'when log file does not exist' do
      it 'raises ArgumentError' do
        expect { LogFileReader.new.read(path: @invalid_path) }
          .to raise_error(ArgumentError)
      end
    end

    context 'when log file exists' do
      it 'does not raise ArgumentError' do
        expect { LogFileReader.new.read(path: @valid_path) }
          .to_not raise_error(ArgumentError)
      end
      it 'returns array of visits' do
        expect(LogFileReader.new.read(path: @valid_path)).to include(
          have_attributes(class: Visit, page: '/help_page/1',
                          visitor: '126.318.035.038'),
          have_attributes(class: Visit, page: '/contact',
                          visitor: '184.123.665.067')
        )
      end
      it 'reads entire log' do
        expect(LogFileReader.new.read(path: @valid_path).size).to eq @log_size
      end
    end
  end

  describe 'build_visit' do
    before do
      @reader = LogFileReader.new
      @valid_line = '/help_page/1 126.318.035.038'
      @invalid_line = '/contact '
    end

    context 'when input is not valid' do
      it 'returns ArgumentError' do
        expect { @reader.build_visit(@invalid_line) }
          .to raise_error(ArgumentError)
      end
    end
    context 'when input is valid' do
      it 'does not return ArgumentError' do
        expect { @reader.build_visit(@valid_line) }
          .to_not raise_error(ArgumentError)
      end
    end
  end
end
