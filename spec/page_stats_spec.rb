# frozen_string_literal: true

require 'page_stats'

describe PageStats do
  before do
    @page_stats = PageStats.new(page: '/contact')
  end

  describe 'add_visit' do
    context 'when it is first time visit' do
      it 'increments total visits' do
        expect { @page_stats.add_visit(visitor: '184.123.665.067') }
          .to change(@page_stats, :total_visits).from(0).to(1)
      end
      it 'increments unique visits' do
        expect { @page_stats.add_visit(visitor: '184.123.665.067') }
          .to change(@page_stats, :unique_visits).from(0).to(1)
      end
    end
    context 'when it is revisit' do
      before do
        @page_stats.add_visit(visitor: '184.123.665.067')
      end
      it 'increments total visits' do
        expect { @page_stats.add_visit(visitor: '184.123.665.067') }
          .to change(@page_stats, :total_visits).from(1).to(2)
      end
      it 'does not increment unique visits' do
        expect { @page_stats.add_visit(visitor: '184.123.665.067') }
          .to_not change(@page_stats, :unique_visits).from(1)
      end
    end
  end

  context 'no visits' do
    describe 'total_visits' do
      it 'returns correct value' do
        expect(@page_stats.total_visits).to eq 0
      end
    end
    describe 'unique_visits' do
      it 'returns correct value' do
        expect(@page_stats.unique_visits).to eq 0
      end
    end
  end
  context 'only unique visits' do
    before do
      @page_stats.add_visit(visitor: '184.123.665.067')
      @page_stats.add_visit(visitor: '316.433.849.805')
      @page_stats.add_visit(visitor: '444.701.448.104')
    end
    describe 'total_visits' do
      it 'returns correct value' do
        expect(@page_stats.total_visits).to eq 3
      end
    end
    describe 'unique_visits' do
      it 'returns correct value' do
        expect(@page_stats.unique_visits).to eq 3
      end
    end
  end
  context 'some duplicate visits' do
    before do
      @page_stats.add_visit(visitor: '184.123.665.067')
      @page_stats.add_visit(visitor: '316.433.849.805')
      @page_stats.add_visit(visitor: '184.123.665.067')
    end
    describe 'total_visits' do
      it 'returns correct value' do
        expect(@page_stats.total_visits).to eq 3
      end
    end
    describe 'unique_visits' do
      it 'returns correct value' do
        expect(@page_stats.unique_visits).to eq 2
      end
    end
  end
end
