require 'yaml'

class TaskList
  attr_reader :task_list


  def initialize(config)
    refresh(config)
  end

  def refresh(config)
    @config    = YAML.load_file(config)
    @task_list  = @config["tasks"]["default"]
    correction_task_list
    exit if not_allowed
    @number_of_completed_tasks = 0
  end
	
  def not_allowed
    if @task_list.length == 0
      puts "Missing tasks or not correctly defined"
      true
    end
    #Something else...
  end

  def correction_task_list
    return [] unless @task_list.is_a? Array
    @task_list.each {|task| puts "ERROR(TaskList): Task called \"#{task}\" not found" unless tasks_with_descriptions.include?(task)}
    @task_list.select! {|task| tasks_with_descriptions.include?(task)} 
  end

  def tasks_with_descriptions
  	tasks = Array.new
    @config["descriptions"].each_value do |groups|
      groups.each do |method|
        method.each_key{|key| tasks << key}
      end
    end
    tasks
  end

  def next_task
    if @number_of_completed_tasks < @task_list.length
      task = @task_list[@number_of_completed_tasks]
      @number_of_completed_tasks += 1
      task
    else
      nil
    end
  end

  def current_task
    @task_list[@number_of_completed_tasks]
  end

  def task_config(*option)
    @config["descriptions"].each_value do |groups|
      groups.each do |method|
        method.each do |key, value| 
        if key == current_task
          if option.empty?
            return value
          elsif option.length == 1
            result = nil
            value.each {|k, v| result = v if k == option[0]}
            return result
          else
            result = Array.new
            value.each {|k, v| result << v if option.include?(k)}
            return result
          end
        end
        end
      end
    end
  end


	public :refresh, :next_task, :current_task, :task_config
	private :not_allowed, :tasks_with_descriptions, :correction_task_list
end

