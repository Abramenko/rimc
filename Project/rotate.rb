require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'

module Rotate

  def self.do(task_list, controller)
# Get "angle" parametr
  	angle = task_list.task_config("angle")
    angle = 0 if angle.nil?
#Get "prefix"
    prefix = task_list.task_config("prefix").nil? ? "" : task_list.task_config("prefix")

# Work with images
    files = controller.src_files
    pbar = ProgressBar.new("#{task_list.current_task}", files.length)
    img = Magick::ImageList.new
    
    controller.get_dest
    if controller.dest_is_a_file?
# Destination is ONE file
      controller.get_src
      files.each do |f|
        img.read(f)
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end
      img.each do|i| 
        i.rotate!(angle)   # Rotate
        pbar.inc
      end
      controller.get_dest
      img.write(prefix + controller.dest_file_name) # Write
    else
# Destination is MANY files
      files.each do |f|
        controller.get_src
        img.read(f)
        img.each do|i| 
          i.rotate!(angle)  # Rotate
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