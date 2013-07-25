require_relative 'task_list'
require_relative 'dir_controller'
require_relative 'rotate'

task_list = TaskList.new("config.yaml")
controller = DirController.new(task_list)

Rotate.do(task_list, controller)

