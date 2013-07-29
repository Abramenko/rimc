#!/usr/bin/env ruby

require_relative 'task_list'
require_relative 'dir_controller'
require_relative 'rotate'
require_relative 'resize'
require_relative 'crop'
require_relative 'filtering'
require_relative 'css_sprite'

task_list = TaskList.new("config.yaml")
controller = DirController.new(task_list)

while(task_list.next_task) do
  case task_list.current_group
    when "rotate" then Rotate.do(task_list, controller)
    when "resize" then Resize.do(task_list, controller)
    when "crop" then Crop.do(task_list, controller)
   	when "filtering" then Filtering.do(task_list, controller)
	when "css_sprite" then CssSprite.do(task_list, controller)
	else puts "ERROR(main.rb):\"#{task_list.current_group}\"is not found"
  end
end

puts "Welldone!"