require_relative '../lib/tomato_downloader.rb'

pages_max = 20 
links = [] 
pages_min = 1 

while pages_min < pages_max do 
    data = Tomato::GettyImages.new("pizza", pages_min) 
    links = links + data.get_links 
    pages_min += 1 
end 

f = File.open('links.txt') 

links.each do |link|
    link = link + "\n" 
    f.write(link) 
end 