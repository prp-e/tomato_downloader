require_relative '../lib/tomato_downloader.rb'

f = File.open('links.txt', 'r') 

links = []

f.readlines.each do |line| 
    links << line 
end 

download_links = [] 

links.each do |link| 
    puts link
    document = Tomato::TomatoDownloader.new(link) 
    #puts document
    puts document.get_image()
    sleep 10
end  

=begin
f = File.open('download.txt', 'w') 

download_links.each do |dl| 
    dl = dl + "\n" 
    f.write(dln) 
end 
=end 
