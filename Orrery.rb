require 'gosu'
$LOAD_PATH.unshift('.')
require 'dcircle.rb'


#URI.parse(url).open

G = 10

class Planet
	def initialize(x, y, dx, dy, size, color, mass)
		@x = x
		@y = y
		@dx = dx
		@dy = dy
		@size = size
		@color = color
		@mass = mass
		
	end
	
	def move
		@x += @dx
		@y += @dy
	end
	
	def gravitate(p)
		return if self === p
		d = distance(p)
		mag = (G*p.mass)/(distance(p)**2)
		ux = (p.x - @x)/d
		uy = (p.y - @y)/d
		@dx += ux*mag
		@dy += uy*mag
	end
	
	def drawSelf(window)
		window.draw_circle(@x, @y, @size,    @color)
	end
	
	def distance(p)
		Math::sqrt((@x - p.x)**2 + (@y - p.y)**2)
	end
	
	attr_reader :x
	attr_reader :y
	attr_reader :mass
end
		



class GameWindow < Gosu::Window
	def initialize
		super 641, 881
		self.caption = "Gosu Tutorial Game"
		self.resizable = true
		super 940, 880
		@vector_to_x = nil
		@vector_to_y = nil
		@planets = [Planet.new(450, 200, 3, 0, 6, Gosu::Color::RED, 20), Planet.new(450, 400, -0.3, 0, 20, Gosu::Color::AQUA, 200)]
		#@planets << Planet.new(450, 404, 5, 0, 30, Gosu::Color::BLUE, 1)
	end

	def update
		@planets.each do |p|
			p.move
		end
		gravity
	end
	
	def gravity
		for p in @planets
			for pp in @planets
				p.gravitate(pp)
			end
		end
	end

	def draw
		for p in @planets
			p.drawSelf(self)
		end
		if @vector_to_x != nil
			draw_line(mouse_x, mouse_y, Gosu::Color::WHITE, @vector_to_x, @vector_to_y, Gosu::Color::WHITE, 0)
		end
	end
	
	def button_down(id)
		case id
		when Gosu::MsLeft
			@vector_to_x = mouse_x
			@vector_to_y = mouse_y
		end
	end
	
	def button_up(id)
		case id
		when Gosu::MsLeft
			@planets << Planet.new(mouse_x, mouse_y, (@vector_to_x - mouse_x)/10, (@vector_to_y - mouse_y)/10, 6, Gosu::Color::BLUE, 3)
			@vector_to_x = nil
			@vector_to_y = nil
		end
	end
	
end

window = GameWindow.new
window.show
