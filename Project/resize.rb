require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'

module Resize

  def self.do(task_list, controller)
# Get and check "size" parametr
  	geometry_string = task_list.task_config("size")
    if geometry_string.nil?
      puts "ERROR(- #{task_list.current_task}):Specify the size of the method"
      return
    end
      controller.get_root
      a = YAML.load_file("alias.yaml")
      a["size"].each do |n|
        geometry_string = n.last if n.first == geometry_string
      end
    geometry_string.split("x").each do |n|
      if  n.to_i == 0
        puts "ERROR(- #{task_list.current_task}): not correct defined \"size:\""
        return
      end
    end 
  	geometry_string += "!" unless task_list.task_config("aspect_ratio")

#Get "prefix"
    prefix = task_list.task_config("prefix").nil? ? "" : task_list.task_config("prefix")

# Work with images
    files = controller.src_files
    pbar = ProgressBar.new("#{task_list.current_task}", files.length * 2)
    img = Magick::ImageList.new
# Destination is ONE file
    controller.get_dest
    if controller.dest_is_a_file?
      controller.get_src
      files.each do |f|
        img.read(f)
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end
      img.each do|i| 
        i.change_geometry(geometry_string){|cols, rows, image| image.resize!(cols, rows)}   # Resize
        pbar.inc
      end
      controller.get_dest
      img.write(prefix + controller.dest_file_name) # Write
# Destination is MANY files
    else
      files.each do |f|
        controller.get_src
        img.read(f)
        img.each do|i| 
          i.change_geometry(geometry_string){|cols, rows, image| image.resize!(cols, rows)}   # Resize
        end
        controller.get_dest
        img.write(prefix + f) # Write
        img.clear
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end
    end
    pbar.finish
  end
  

end


