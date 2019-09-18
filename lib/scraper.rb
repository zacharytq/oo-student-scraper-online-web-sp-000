require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []
    html.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4.student-name").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    html = Nokogiri::HTML(open(profile_url))

    html.css("div.main-wrapper.profile div.vitals-container div.social-icon-container a").each do |icon|
      if icon.attributes("href").value.include?("twitter")
        student(:twitter) = icon.attributes("href").value
      elsif icon.attributes("href").value.include?("github")
        student(:github) = icon.attributes("href").value
      elsif icon.attributes("href").value.include?("linkedin")
        student(:linkedin) = icon.attributes("href").value
      elsif icon.attributes("href").value.include?("instagram")
        student(:instagram) = icon.attributes("href").value
      end
    end

  end

end
