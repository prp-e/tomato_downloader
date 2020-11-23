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
        def initialize(keyword)
            @keyword = keyword
        end

        def get_links()
            web_page = Nokogiri::HTML(open("https://www.gettyimages.co.uk/photos/#{@keyword}")) 
            events_holder = web_page.xpath('//*[@id="gallery"]')

            links = [] 
            clean_links = []
            events_holder.each do |event| 
                link = event.css("a") 
                links << event 
            end 

            #links = links[0] 
            
            #links.each do |link| 
            #   clean_links << link['href'] 
            #end 

            return links
        end
    end
end