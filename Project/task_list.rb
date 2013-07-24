require 'yaml'

class TaskList
  attr_reader :task_list


  def initialize(config)
    refresh(config)
    exit if not_allowed
    @number_of_completed_tasks = 0
  end

  def refresh(config)
    @config		= YAML.load_file(config)
    @task_list	= @config["tasks"]["default"]
    correction_task_list
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
    @task_list.each {|task| puts "ERROR: Task called \"#{task}\" not found" unless tasks_with_descriptions.include?(task)}
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

  def task_config
    @config["descriptions"].each_value do |groups|
      groups.each do |method|
        method.each_key do |key| 
          if key == current_task
          	return method
          end
        end
      end
    end
  end


	public :refresh, :next_task, :current_task, :task_config
	private :not_allowed, :tasks_with_descriptions, :correction_task_list
end

