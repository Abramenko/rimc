# Class: DirController 
# - Controls "src"/"dest" parametrs
# - Goes in the "src"/"dest" directories

require_relative 'task_list'

class DirController
  def initialize(task_list)
  	@task_list = task_list
    @root = Dir.getwd # the directory when creating an object
    @file_name = nil  # here is the name of destination file, if "dest" is file
  end

  def src_files
      get_src
      return [@file_name] if @file_name

      files = Dir.glob("*.*")
      formats = @task_list.task_config("format")
      if formats.nil?
        files
      else
        result = Array.new
        formats.each do |format|
          files.each do |file|
            result << file if file.include?("." + format)
          end
        end
        return result
      end
  end

  def get_dest
    begin
  	  clear_file_name
      dest = @task_list.task_config("dest")
  
  	    
        if dest.byteslice(0) == "/"
          Dir.chdir("/")
          dest = dest[1..-1]
        else
          Dir.chdir(@root)
        end

        dest.split('/').each do |dir|
          if Dir.exist?(dir)      
            Dir.chdir(dir)
          elsif dir.include?('.')
            @file_name = dir
          else
            Dir.mkdir(dir)
            Dir.chdir(dir)
          end
        end
        
    rescue Exception
      puts "ERROR (dir_controller.rb): Can't get dest:\"#{dest}\" in the description \'#{@task_list.current_task}\'"
      exit
    end
  end

  def get_src
    begin
      clear_file_name
      src = @task_list.task_config("src")
      
      Dir.chdir(@root)

      if File.file?(src)
        @file_name = File.basename(src)
        src = File.dirname(src)
        Dir.chdir(src)
      elsif File.directory?(src)
        Dir.chdir(src)
      else
        raise
      end
      src
    rescue Exception
      puts "ERROR (dir_controller.rb): Can't get the src: \"#{src}\" in the description \'#{@task_list.current_task}\'"
      exit
    end
  end

  def dest_file_name
    @file_name
  end

  def dest_is_a_file?
    @file_name ? true : false
  end
  
  def get_root 
    Dir.chdir(@root)
    @root
  end

private
  def clear_file_name
    @file_name = nil
  end
end

