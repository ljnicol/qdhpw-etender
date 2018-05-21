# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'

def crawl_page(url)
  p url
  agent = Mechanize.new
  page = agent.get(url)
  html = Nokogiri::HTML(page.body)
  t = {}
  html.xpath("//div[@class='tenderHeaderMid']/table/tr/td").map(&:text).map do |t|
    t.gsub(/\r|\n|[ ]{2,}/,"")
  end.each_slice(2) do |pairs|
    t[(pairs[0].gsub(/\s\:/, ""))] = pairs[1]
  end
  p t
  # [contains(@class, 'tenderHeaderData')]
end

base_url = 'https://www.hpw.qld.gov.au/bas/eTender/public/TenderDetailsAccepted.aspx?'

(1..5).each do |i|
  out = crawl_page(base_url + "tid=#{i}")
end

