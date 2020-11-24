require 'httparty'
require 'json'
require 'base64'
require 'open-uri'
require 'nokogiri'

module Tomato

    class TomatoDownloader
        def initialize(image_link) 
            @image_link = image_link 
            @request = HTTParty.get("http://tomato.to/toma.php", :query => {'url' => @image_link}, :timeout => 10)
        end 

        def get_image()
            body = JSON.parse(@request.body) 
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
                @document = Nokogiri::HTML(open("https://gettyimages.co.uk/photos/#{keyword}?page=#{@pages}")) 
            end 
        end 

        def get_links
            
            links = [] 
            clean_links = [] 
            events_holder = @document.xpath('//*[@id="gallery"]')

            events_holder.each do |event| 
                link = event.css("a")
                    links << link 
            end 
             
            links = links[0] 
            
            links.each do |link_to_be_removed| 
                if link_to_be_removed == "/" || link_to_be_removed == " " 
                    links = links.delete(link_to_be_removed)
                end
            end 

            links.each do |link| 
                clean_links << "https://gettyimages.co.uk" + link['href']
            end 
            clean_links.delete("https://gettyimages.co.uk/")
            return clean_links 
        end
    end 
end