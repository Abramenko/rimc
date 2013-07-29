require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'

module Rotate

  def self.do(task_list, controller)
  	angle = task_list.task_config("angle")
    angle = 0 if angle.nil?
    img = Magick::ImageList.new
    files = controller.src_files
    pbar = ProgressBar.new("#{task_list.current_task}", files.length)
    files.each do |f|
  	  controller.src
      img.read(f)
  	  img.each{|i| i.rotate!(angle)}
  	  controller.dest
      img.write(f)
  	  img.clear
      pbar.format="%-14s %3d%% #{f} %s %s"
  	  pbar.inc
    end
  pbar.finish
  end
  

end