require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'

module Rotate

  def self.do(task_list, controller)
  	angle = task_list.task_config("angle")
    angle = 0 if angle.nil?
  	
  	pbar = ProgressBar.new("#{task_list.current_task}", 100)
    img = Magick::ImageList.new
    files = controller.src_files
    files.each do |f|
  	  img.read(f)
  	  img.each{|i| i.rotate!(angle)}
  	  img.display
  	  img.clear
  	  pbar.inc
    end
  pbar.finish
  end
  

end