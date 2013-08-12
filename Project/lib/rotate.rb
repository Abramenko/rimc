module Rotate

  def self.do(task_list, controller)
    begin
# Get "angle" parametr
  	  angle = task_list.task_config("angle")
      angle = 0 if angle.nil?
#Get "prefix"
      prefix = task_list.task_config("prefix").nil? ? "" : task_list.task_config("prefix")

# Work with images
      files = controller.src_files
      pbar = ProgressBar.new("#{task_list.current_task}", files.length)
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
          i.rotate!(angle)   # Rotate
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
            i.rotate!(angle)  # Rotate
          end
          controller.get_dest
          img.write(prefix + f) # Write
          img.clear
          pbar.inc
        end
      end
      pbar.finish
    rescue Exception
      puts "\n#{task_list.current_task}: ERROR(rotate.rb): File \'#{current_file}\' can't be processed" if current_file != nil
      puts "#{task_list.current_task}: ERROR(resize.rb): Something went wrong..." if current_file == nil
      puts "#{task_list.current_task}: Processing is stopped..."
      return
    end

  end


end