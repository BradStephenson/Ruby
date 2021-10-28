require 'gosu'

module Gosu

  def self.draw_circle(x, y, radius, color, z = 0, mode = :default)

	#yup = (radius - .3)
	r = 0
	#yup = (radius - 0.1)
	#draw_line(x - Math::sqrt(radius**2 - yup**2), y + (radius - r), color, x + Math::sqrt(radius**2 - yup**2), y + (radius - r), color, z)
    #draw_line(x - Math::sqrt(radius**2 - yup**2), y - (radius - r), color, x + Math::sqrt(radius**2 - yup**2), y - (radius - r), color, z)
	#r = 1
    while r <= radius do
		
		yup = (radius - r)
		
        draw_line(x - Math::sqrt(radius**2 - yup**2), y + (radius - r), color, x + Math::sqrt(radius**2 - yup**2), y + (radius - r), color, z)
        draw_line(x - Math::sqrt(radius**2 - yup**2), y - (radius - r), color, x + Math::sqrt(radius**2 - yup**2), y - (radius - r), color, z)
        r += 1
    end
    

  end

  class Window

    def draw_circle(x, y, radius, color)
      Gosu::draw_circle(x, y, radius,  color)
    end

  end # Window class

end # Gosu module