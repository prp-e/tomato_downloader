require 'httparty'
require 'json'
require 'base64'
require 'open-uri'
require 'nokogiri'

module Tomato

    class TomatoDownloader
        def initialize(image_link) 
            @image_link = image_link 
        end 

        def get_image()
            request = HTTParty.get("http://tomato.to/toma.php", :query => {'url' => @image_link})
            body = JSON.parse(request.body) 
            body = body['data']
            body = body[34..-1] 
            body = Base64.decode64(body) 

            return body
        end 
    end 

    class GettyImages
        def initialize(keyword, pages=1) 
            @pages = pages 
            if keyword.include?(' ') 
                keyword = keyword.gsub(' ', '-')
            end 
            if @pages == 1
                @document = Nokogiri::HTML(open("https://gettyimages.co.uk/photos/#{keyword}"))
            else 
                @document = [] 
                counter = 2 
                while counter <= @pages 
                    @document << Nokogiri::HTML(open("https://gettyimages.co.uk/photos/#{keyword}?page=#{counter}")) 
                    counter += 1
                end 
            end 
        end 

        def get_links
            
            links = [] 
            clean_links = [] 

            if @pages > 1 
                @document.each do |doc| 
                    events_holder = doc.xpath('//*[@id="gallery"]') 
                    events_holder.each do |event| 
                        link = event.css("a") 
                        links << event 
                    end 
                    links = links[0] 

                    links.each do |link| 
                        clean_links << "https://gettyimages.co.uk" + link['href']
                    end 
                end 
            else 
                events_holder.each do |event| 
                    link = event.css("a")
                    links << link 
                end 
             
                links = links[0] 

                links.each do |link| 
                    clean_links << "https://gettyimages.co.uk" + link['href']
                end 
            end 
            return clean_links 
        end
    end 
end