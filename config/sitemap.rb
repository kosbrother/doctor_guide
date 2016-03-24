require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://doctorguide.tw/'
SitemapGenerator::Sitemap.create_index = :auto
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  Hospital.find_each do |hospital|
    add hospital_path(hospital), :changefreq => 'daily', :priority => 0.9
  end
end
SitemapGenerator::Sitemap.ping_search_engines