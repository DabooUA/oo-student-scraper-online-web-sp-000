require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    students_hash = []

    doc= Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    doc.css("div.student-card").collect do |student|
      hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "" + student.css("a").attribute("href")
      }
      students_hash << hash
    end
    students_hash
  end

  def self.scrape_profile_page(profile_url)

    students_hash = {}

    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.social-icon-container").each do |student|
        student.children.css("a").each do |icon_link|
        url = icon_link.attribute("href").value
        if url.include?("twitter")
          students_hash[:twitter] = url
        elsif url.include?("linkedin")
          students_hash[:linkedin] = url
        elsif url.include?("github")
          students_hash[:github] = url
        else
          students_hash[:blog] = url
      end
    end
  end
      
        students_hash[:profile_quote] = doc.css("div.profile-quote").text
        students_hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    students_hash
  end
end
    