require_relative '../lib/tomato_downloader.rb'

f = File.open('links.txt', 'r') 

links = []

f.readlines.each do |line| 
    links << line 
end 

download_links = [] 

links.each do |link| 
    document = Tomato::TomatoDownloader(link) 
    document = document.get_image 
    download_links << document 
end  

f = File.open('download.txt', 'w') 

download_links.each do |dl| 
    dl = dl + "\n" 
    f.write(dln) 
end 
