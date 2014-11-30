require 'mini_magick'

require 'sedatabi/version'

module Sedatabi

  autoload :Instagram, 'sedatabi/instagram'
  autoload :Detect,    'sedatabi/detect'

  class App

    def start args
      path = args.shift

      # Üzerinde işlem yapacağamız dosya veya dosyaların yolu
      files = []

      case
        # Argüman verilmeden çalıştırıldıysa Instagram'dan
        # 'selfie' etiketine ait rastgele bir resim seçeceğiz.
        when path.nil?
          files << Sedatabi::Instagram.get_random_image
        when File.directory?(path)
          files = Dir.glob "#{path}/*.jpg"
        else
          files << path
      end

      detector = Sedatabi::Detect.new

      files.each do |file|
        if !File.exist? file
          puts "#{file} bulunamadı!"
          next
        end

        detector.file = file
        coordinates = detector.detect_faces

        if coordinates.empty?
          puts "#{file}'da hiç yüz bulunamadı!'"
          next
        end

        first  = MiniMagick::Image.open file
        second = MiniMagick::Image.open File.expand_path(File.dirname(__FILE__) + '/../assets/images/sedat_abi.png')

        coordinates.each do |coord|
          first = first.composite(second) do |c|
            c.compose "Over"
            c.geometry "#{coord[:width]}x#{coord[:height]}^+#{coord[:left]}+#{coord[:top]}"
          end
        end

        first.write "#{Dir.pwd}/output.jpg"

        puts "#{Dir.pwd}/output.jpg oluşturuldu."
      end

    end

  end
end
