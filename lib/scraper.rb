require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    html.css("div.student-card").map do |student|
      student_hash = {}
      student_hash[:name] = html.css("h4.student-name").text
      student_hash[:location] = html.css("p.student-location").text
      student_hash
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
