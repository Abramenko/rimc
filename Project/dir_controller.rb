require_relative 'task_list'

class DirController
  def initialize(task_list)
  	@task_list = task_list
    @root = Dir.getwd
  end

  def src_files
      src
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

  def dest
  	dest = @task_list.task_config("dest")
    if dest.nil?
      puts "ERROR(-#{@task_list.current_task}):Specify the dest"
      exit
    end
  	Dir.chdir(@root)
    dest.split('/').each do |dir|
      if Dir.exist?(dir)
        Dir.chdir(dir)
      else
        Dir.mkdir(dir)
        Dir.chdir(dir)
      end
    end
    dest
  end

  def src
    src = @task_list.task_config("src")
    if src.nil?
      puts "ERROR(-#{@task_list.current_task}):Specify the src"
      exit
    end
    Dir.chdir(@root)
    if Dir.exist?(src)
      Dir.chdir(src)
      src
    else
      puts "ERROR(-#{@task_list.current_task}):No such file or directory - \"#{src}\" inside  -\"#{Dir.getwd}\""
      exit
    end
  end


end
