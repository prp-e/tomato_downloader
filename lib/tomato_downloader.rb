require 'httparty'

class TomatoDownloader
    def initialize(image_link) 
        @image_link = image_link 
    end 

    def get_image()
        request = HTTParty.get("http://tomato.to/toma.php", :query => {'url' => @image_link})
        return request.body 
    end 
end