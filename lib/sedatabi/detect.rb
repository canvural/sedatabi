require 'opencv'

class Sedatabi::Detect

  attr_accessor :file

  def initialize
    @detector = OpenCV::CvHaarClassifierCascade::load(File.expand_path(File.dirname(__FILE__) + '/haar.xml'))
  end

  def detect_faces
    cv_image = OpenCV::CvMat.load(@file)
    faces    = []

    @detector.detect_objects(cv_image).each do |region|
      next if region.width < 50

      faces << {
          width:  region.width,
          height: region.height,
          top:    region.top_left.y,
          left:   region.top_left.x
      }
    end

    faces
  end

end