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

  #  students_hash = {}

  #  doc = Nokogiri::HTML(open(profile_url))
  #  doc.css("div.social-icon-container a").each do |student|
  #      url = student.attribute("a href")
  #      students_hash[:twitter_url] = url if url.include?("twitter")
  #      students_hash[:linkedin_url] = url if url.include?("linkedin")
  #      students_hash[:github_url] = url if url.include?("github")
  #      students_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
  #  end
  #      students_hash[:profile_quote] = html.css("div.profile-quote").text
  #      students_hash[:bio] = html.css("div.bio-content p").text
  #  students_hash
  #end
    students_hash = {}

    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".div.social-icon-container a").collect{|icon| icon.attribute("href").value}
    social = doc.css("vitals-container.social-icon-container a")
      social.each do |link|
        if link.attr('a href').include?("twitter")
          students_hash[:twitter] = link.attr('href')
        elsif link.attr('a href').include?("linkedin")
          students_hash[:linkedin] = link.attr('href')
        elsif link.attr('a href').include?("github")
          students_hash[:github] = link.attr('href')
        elsif link.attr('a href').include?(".com/")
          students_hash[:blog] = link.attr('href')
        end
      end

      students_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      students_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

      students_hash

      #  url = student.attribute("href")
      #  students_hash[:twitter_url] = url if url.include?("twitter")
      #  students_hash[:linkedin_url] = url if url.include?("linkedin")
      #  students_hash[:github_url] = url if url.include?("github")
      #  students_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    #end
    #    students_hash[:profile_quote] = doc.css("div.profile-quote").text
    #    students_hash[:bio] = doc.css("div.bio-content p").text
    #students_hash

  end

end
