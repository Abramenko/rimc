require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'

module Filtering

  def self.do(task_list, controller)

#Get "filters" parametr
    filters = task_list.task_config("filters")
    if filters.nil?
      puts "ERROR(- #{task_list.current_task}): \"Define filters:\" |"
      exit
    end
  
#Get "prefix"
    prefix = task_list.task_config("prefix").nil? ? "" : task_list.task_config("prefix")

# Work with images
    files = controller.src_files
    pbar = ProgressBar.new("#{task_list.current_task}", files.length * 2)
    img = Magick::ImageList.new
# Destination is ONE file
    controller.get_dest
    if controller.dest_is_a_file? # Destination is a file
      controller.get_src
      files.each do |f|
        img.read(f)
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end
      
      f_img = Magick::ImageList.new
      filters.each do |filter|     #Filters
        if filter == "bw"
          f_img = img.quantize(256, Magick::GRAYColorspace)
        elsif filter == "sepia"
          mono = img.quantize(256, Magick::GRAYColorspace)
          f_img.clear
          mono.each{|i| f_img << i.colorize(0.30, 0.30, 0.30, '#cc9933')}
        else
          puts "ERROR(- #{task_list.current_task}): \'#{filter}\' is not defined |"
          pbar.inc
          next
        end
        controller.get_dest
        f_img.write(prefix + "#{filter}-" + controller.dest_file_name)  # Write
        pbar.inc
      end

# Destination is MANY files
    else
      files.each do |f|
        controller.get_src
        img.read(f)

        f_img = Magick::ImageList.new
        filters.each do |filter|     #Filters
          if filter == "bw"
            f_img = img.quantize(256, Magick::GRAYColorspace)
          elsif filter == "sepia"
            mono = img.quantize(256, Magick::GRAYColorspace)
            f_img.clear
            mono.each{|i| f_img << i.colorize(0.30, 0.30, 0.30, '#cc9933')}
          else
            puts "ERROR(- #{task_list.current_task}): \'#{filter}\' is not defined |"
            pbar.inc
            next
          end
          controller.get_dest
          f_img.write(prefix + "#{filter}-" + f)  # Write
        end
        
        img.clear
        pbar.format="%-14s %3d%% #{f} %s %s"
        pbar.inc
      end

    end
    pbar.finish
  end

end