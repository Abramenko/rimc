require 'yaml'
require 'RMagick'



config = YAML.load_file("config.yaml")
src 	= config["tasks"]["rotate"][0]["rotate"]["src"]
dest	= config["tasks"]["rotate"][0]["rotate"]["dest"]
angle	= config["tasks"]["rotate"][0]["rotate"]["angle"]



config["run"]["default"].each do |variable|
	case variable
	when "rotate"
		
 		img = Magick::ImageList.new(src)
		img.rotate!(angle)
		img.write(dest)
		puts "Rotete......ok"
 	when "big image"
 		puts "BIG image...ok"
 	else
 		puts "#{variable}..........ERROR: command \"#{variable}\" not found"
	end

end
