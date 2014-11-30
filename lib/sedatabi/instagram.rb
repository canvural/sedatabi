require 'instagram'
require "open-uri"

class Sedatabi::Instagram
  def self.get_random_image
    media = Instagram.tag_recent_media(
        'selfie',
        {:client_id => '4123f73c6aad4f3b903369ccb353ecde',
         :count => 150,
        }
    )

    chosen_one = []

    loop do
      chosen_one = media.sample

      break if chosen_one.type == 'image'
    end

    File.open("#{Dir.pwd}/tmp.jpg", 'wb') do |fo|
      fo.write open(chosen_one.images.standard_resolution.url).read
    end

    "#{Dir.pwd}/tmp.jpg"
  end
end