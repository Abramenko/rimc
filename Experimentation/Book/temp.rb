require 'yaml'
require 'RMagick'

p File.size?( "dir")
p Dir.getwd
p Dir.glob("*")

config 	= YAML.load_file("config.yaml")
src 	= config["tasks"]["rotate"][0]["rotate"]["src"]
dest	= config["tasks"]["rotate"][0]["rotate"]["dest"]
angle	= config["tasks"]["rotate"][0]["rotate"]["angle"]

img = Magick::ImageList.new(src)
img.rotate!(angle)
# img.sample!(1)
# img.scale!(500, 500)
geometry = Magick::Geometry.new(300, 300, nil, nil,Magick::AspectGeometry)
p geometry.flag
img.change_geometry!(geometry){|cols, rows, img| img.resize!(cols, rows)}

img.display