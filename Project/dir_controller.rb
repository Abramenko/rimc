require_relative 'task_list'

class DirController
  def initialize(task_list)
  	@task_list = task_list
    @root = Dir.getwd
  end

  def src_files(*formats)
  	@task_list.task_config.each {|k, v| @src = v if k == "src"}
    Dir.chdir(@root)
    if Dir.exist?(@src)
      Dir.chdir(@src)
      files = Dir.glob("*.*")
      if formats.empty?
        files
      else
        result = Array.new
        formats.each do |format|
          files.each do |file|
            result << file if file.include?(format)
          end
        end
        return result
      end
    else
      puts "ERROR(-#{@task_list.current_task}):No such file or directory - #{@src} inside the folder - #{Dir.getwd}"
      exit
    end
  end

  def dest
  	@task_list.task_config.each {|k, v| @dest = v if k == "dest"}
  	Dir.chdir(@root)
    if Dir.exist?(@dest)
      @dest
    else
      puts "ERROR(-#{@task_list.current_task}):No such file or directory - #{@dest} inside the folder - #{Dir.getwd}"
      exit
    end
  end

  
end
