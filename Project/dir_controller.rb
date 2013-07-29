require_relative 'task_list'

class DirController
  def initialize(task_list)
  	@task_list = task_list
    @root = Dir.getwd
    @file_name = nil
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
  	clear_file_name
    dest = @task_list.task_config("dest")
    if dest.nil?
      puts "ERROR(-#{@task_list.current_task}):Specify the dest"
      exit
    end

  	  Dir.chdir(@root)
      result = "./"
      dest.split('/').each do |dir|
        if Dir.exist?(dir)
          
          Dir.chdir(dir)
          result += dir + "/"
        elsif dir.include?('.')
          @file_name = dir
        else
          Dir.mkdir(dir)
          Dir.chdir(dir)
        end
      end
      result
  end

  def get_src
    clear_file_name
    src = @task_list.task_config("src")
    if src.nil?
      puts "ERROR(-#{@task_list.current_task}):Specify the src"
      exit
    end

    Dir.chdir(@root)
    result = "./"
    src.split('/').each do |dir|
      if Dir.exist?(dir)
        Dir.chdir(dir)
        result += dir + "/"
      elsif File.file?(dir)
        @file_name = dir
      else
        puts "ERROR(-#{@task_list.current_task}):No such file or directory - \"#{src}\" inside  -\"#{Dir.getwd}\""
        exit
      end
    end
    result
  end

  def dest_file_name
    @file_name
  end

private
  def clear_file_name
    @file_name = nil
  end
end
