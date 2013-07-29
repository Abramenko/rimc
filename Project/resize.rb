require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'

module Resize

  def self.do(task_list, controller)
  	geometry_string = task_list.task_config("size")
    if geometry_string.nil?
      puts "ERROR(Resize.rb):Specify the size of the method #{task_list.current_task}"
      return
    end
  	geometry_string += "!" unless task_list.task_config("aspect_ratio")

     
    files = controller.src_files
    pbar = ProgressBar.new("#{task_list.current_task}", files.length * 2)
    img = Magick::ImageList.new

    controller.get_dest
    if controller.dest_file_name.nil?
      files.each do |f|
        controller.get_src
        img.read(f)
        img.each do|i| 
          i.change_geometry(geometry_string){|cols, rows, image| image.resize!(cols, rows)}
        end
        controller.get_dest
        img.write(f)
        img.clear
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end
    else
      controller.get_src
      files.each do |f|
        img.read(f)
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end

      img.each do|i| 
        i.change_geometry(geometry_string){|cols, rows, image| image.resize!(cols, rows)}
        pbar.inc
      end
        
      controller.get_dest
      img.write(controller.dest_file_name)
    end
  pbar.finish
  end
  

end


