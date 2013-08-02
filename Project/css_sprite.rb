require_relative 'task_list'
require_relative 'dir_controller'
require 'RMagick'
require 'progressbar'
require 'sprite_factory'

module CssSprite

  def self.do(task_list, controller)
    puts "#{task_list.current_task}: Started doing css sprite...\n-- It may take several minutes |"

    config = Hash.new

# Get and check "layout" parametr
    layout = task_list.task_config("layout")
    if layout == "horizontal"
      config[:layout] = :horizontal
    elsif layout == "vertical"
      config[:layout] = :vertical
    elsif layout == "packed"
      config[:layout] = :packed
    else
      puts "- #{task_list.current_task}: \'layout: #{layout}\'  is missing or not support. So it be default \'horizontal\'|"
      puts "   supported layouts: packed, vertical or horizontal |"
    end
    
# Get and check "style" parametr
    style = task_list.task_config("style")
    if style == "css"
      config[:style] = :css
    elsif style == "scss"
      config[:style] = :scss
    elsif style == "sass"
      config[:style] = :sass
    else
      puts "- #{task_list.current_task}: \'style: #{style}\' is missing or not support. So it be default \'css\'|"
      puts "   supported styles: css, scss or sass |"
    end

# Get and check "selector" parametr
    selector = task_list.task_config("selector")
    if selector != nil
      config[:selector] = selector
    end
# Get and check "cssurl" parametr
    cssurl = task_list.task_config("cssurl")
    if cssurl != nil
      config[:cssurl] = cssurl
    end

# Get and check "nocomments" parametr
    nocomments = task_list.task_config("nocomments")
    if nocomments == true
      config[:nocomments] = true
    end

# Foundation  
   src = controller.get_src
   controller.get_root
  	SpriteFactory.run!(src, config)
  end
  
end