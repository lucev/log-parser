# frozen_string_literal: true

require 'visit'

describe Visit do
  describe 'initialize' do
    context 'when page is nil' do
      it 'raises ArgumentError' do
        expect { Visit.new(page: nil, visitor: '126.318.035.038') }
          .to raise_error(ArgumentError)
      end
    end
    context 'when page is blank' do
      it 'raises ArgumentError' do
        expect { Visit.new(page: '  ', visitor: '126.318.035.038') }
          .to raise_error(ArgumentError)
      end
    end
    context 'when page and visitor are present' do
      it 'does not raise ArgumentError' do
        expect { Visit.new(page: '/contact', visitor: '126.318.035.038') }
          .to_not raise_error(ArgumentError)
      end
    end
    context 'when visitor is blank' do
      it 'raises ArgumentError' do
        expect { Visit.new(page: '/contact', visitor: ' ') }
          .to raise_error(ArgumentError)
      end
    end
    context 'when visitor is nil' do
      it 'raises ArgumentError' do
        expect { Visit.new(page: '/contact', visitor: nil) }
          .to raise_error(ArgumentError)
      end
    end
  end
end
