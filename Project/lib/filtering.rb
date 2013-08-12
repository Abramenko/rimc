module Filtering

  def self.do(task_list, controller)
    begin
#Get "filters" parametr
      filters = task_list.task_config("filters")
      if filters.nil?
        puts "ERROR(- #{task_list.current_task}): \"Define filters:\" |"
        return
      end
#Get "prefix"
      prefix = task_list.task_config("prefix").nil? ? "" : task_list.task_config("prefix")

# Work with images
      files = controller.src_files
      pbar = ProgressBar.new("#{task_list.current_task}", files.length * 2)
      img = Magick::ImageList.new
# Destination is ONE file
      current_file = nil
      controller.get_dest
      if controller.dest_is_a_file? # Destination is a file
        controller.get_src
        files.each do |f|
          current_file = f
          img.read(f)
          pbar.inc
        end
      
        f_img = Magick::ImageList.new
        filters.each do |filter|     #Filters
          if filter == "bw"
            f_img = img.quantize(256, Magick::GRAYColorspace)
          elsif filter == "sepia"
            mono = img.quantize(256, Magick::GRAYColorspace)
            f_img.clear
            mono.each{|i| f_img << i.colorize(0.30, 0.30, 0.30, '#cc9933'); current_file = i.base_filename}
          else
            puts "ERROR(- #{task_list.current_task}): \'#{filter}\' is not defined |"
            pbar.inc
            next
          end
          controller.get_dest
          f_img.write(prefix + controller.dest_file_name)  # Write
          pbar.inc
        end

# Destination is MANY files
      else
        files.each do |f|
          current_file = f
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
            f_img.write(prefix + f)  # Write
          end
        
          img.clear
          pbar.inc
        end

      end
      pbar.finish
    rescue Exception
      puts "\n#{task_list.current_task}: ERROR(filtering.rb): File \'#{current_file}\' can't be processed" if current_file != nil
      puts "#{task_list.current_task}: ERROR(filtering.rb): Something went wrong..." if current_file == nil
      puts "#{task_list.current_task}: Processing is stopped..."
      return
    end
  end

end