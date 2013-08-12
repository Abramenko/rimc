module Crop


  def self.do(task_list, controller)
    begin
#Get and check "area"
  	  area = task_list.task_config("area")
      if area.nil?
        puts "ERROR(- #{task_list.current_task}):Specify the \"area:\" of the method"
        return
      end
        controller.get_project_folder
        a = YAML.load_file("alias.yaml")
        a["area"].each do |n|
          area = n.last if n.first == area
        end
      area_split = area.split("x")
      area_split.each do |n|
        if  n.to_i == 0
          puts "ERROR(- #{task_list.current_task}): not correct defined \"area:\""
          return
        end
      end
#Set "width" and "height" parametrs for .crop method
      width = area_split[0].to_i
      height = area_split[1].to_i
#Get "prefix"
      prefix = task_list.task_config("prefix").nil? ? "" : task_list.task_config("prefix")

#Get "from" parametr
      from = task_list.task_config("from")
#Set "gravity" for .crop method
      if from == "top left corner"
        gravity = Magick::NorthWestGravity
      elsif from == "top right corner"
        gravity = Magick::NorthEastGravity
      elsif from == "bottom right corner"
        gravity = Magick::SouthEastGravity
      elsif from == "bottom left corner"
        gravity = Magick::SouthWestGravity
      elsif from == "center"
        gravity = Magick::CenterGravity
      else
        puts "ERROR(- #{task_list.current_task}):Specify the \"from:\" of the method"
        puts "Possible options:"
        puts "from: \"top left corner\""
        puts "from: \"top right corner\""
        puts "from: \"bottom right corner\""
        puts "from: \"bottom left corner\""
        puts "from: \"center\""
        puts "------------------------------"
        return
      end


# Work with images
      files = controller.src_files
      pbar = ProgressBar.new("#{task_list.current_task}", files.length * 2)
      img = Magick::ImageList.new

      current_file = nil
      controller.get_dest
      if controller.dest_is_a_file?
# Destination is ONE file
        controller.get_src
        files.each do |f|
          current_file = f
          img.read(f)
          pbar.inc
        end
        img.each do|i|
        current_file = i.base_filename 
          i.crop!(gravity,width,height,true) # Crop
          pbar.inc
        end
        controller.get_dest
        img.write(prefix + controller.dest_file_name) # Write
      else
# Destination is MANY files
        files.each do |f|
          current_file = f
          controller.get_src
          img.read(f)
          img.each do|i| 
            i.crop!(gravity,width,height,true) # Crop
          end
          controller.get_dest
          img.write(prefix + f)     # Write
          img.clear
          pbar.inc
        end
      end
      pbar.finish
    rescue Exception
      puts "\n#{task_list.current_task}: ERROR(crop.rb): File \'#{current_file}\' can't be processed" if current_file != nil
      puts "#{task_list.current_task}: ERROR(crop.rb): Something went wrong..." if current_file == nil
      puts "#{task_list.current_task}: Processing is stopped..."
      return
    end
  end

  

end