# frozen_string_literal: true

require 'page_stats_service'
require 'log_file_reader'
require 'visit'
require 'page_stats'

describe PageStatsService do
  before do
    @stats_service = PageStatsService.new
    log_reader = LogFileReader.new
    @visits = log_reader.read(path: "#{RSPEC_ROOT}/fixtures/webserver.log")
  end

  describe 'ranked_total_visits' do
    it 'returns results ranked from most views to less, followed by alphabetical order' do
      expect(@stats_service.ranked_total_visits(visits: @visits)[0]).to have_attributes(page: '/help_page/1', total_visits: 6)
      expect(@stats_service.ranked_total_visits(visits: @visits)[1]).to have_attributes(page: '/about/2', total_visits: 3)
      expect(@stats_service.ranked_total_visits(visits: @visits)[2]).to have_attributes(page: '/contact', total_visits: 3)
      expect(@stats_service.ranked_total_visits(visits: @visits)[3]).to have_attributes(page: '/home', total_visits: 3)
      expect(@stats_service.ranked_total_visits(visits: @visits)[4]).to have_attributes(page: '/index', total_visits: 3)
      expect(@stats_service.ranked_total_visits(visits: @visits)[5]).to have_attributes(page: '/about', total_visits: 2)
    end
  end
  describe 'ranked_unique_visits' do
    it 'returns results ranked from most views to less, followed by alphabetical order' do
      expect(@stats_service.ranked_unique_visits(visits: @visits)[0]).to have_attributes(page: '/help_page/1', unique_visits: 5)
      expect(@stats_service.ranked_unique_visits(visits: @visits)[1]).to have_attributes(page: '/home', unique_visits: 3)
      expect(@stats_service.ranked_unique_visits(visits: @visits)[2]).to have_attributes(page: '/index', unique_visits: 3)
      expect(@stats_service.ranked_unique_visits(visits: @visits)[3]).to have_attributes(page: '/about', unique_visits: 2)
      expect(@stats_service.ranked_unique_visits(visits: @visits)[4]).to have_attributes(page: '/about/2', unique_visits: 2)
      expect(@stats_service.ranked_unique_visits(visits: @visits)[5]).to have_attributes(page: '/contact', unique_visits: 2)
    end
  end
end
