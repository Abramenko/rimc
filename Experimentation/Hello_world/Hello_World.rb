
require 'RMagick'
# Reduce the size of an "Cheetah.jpg" to half its original size.
# Save as "Small-Cheetah.gif"		
 cat = Magick::ImageList.new("Cheetah.jpg")
 smallcat = cat.minify 				
 smallcat.write("Small-Cheetah.gif")

#Reads TWO files and then combine into one animated GIF file.
 anim = Magick::ImageList.new("Cheetah.jpg", "Small-Cheetah.gif")
 anim.write("animated.gif")


# Create a 1000x1000 green image.
  new_imag = Magick::Image.new(1000,1000) { self.background_color = "green"} 
# Create the circle on the new image
  circle = Magick::Draw.new
  circle.stroke('tomato')
  circle.fill_opacity(0)
  circle.stroke_opacity(0.75)
  circle.stroke_width(6)
  circle.stroke_linecap('round')
  circle.stroke_linejoin('round')
  circle.ellipse(new_imag.rows/2,new_imag.columns/2, 80, 80, 0, 380)
  circle.draw(new_imag)
  
  new_imag.display
  exit