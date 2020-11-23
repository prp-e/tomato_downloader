require 'httparty'
require 'json'
require 'base64'

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