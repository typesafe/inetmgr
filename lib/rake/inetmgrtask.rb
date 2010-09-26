require 'rake/tasklib'

module Inetmgr
  class InetmgrTask < ::Rake::TaskLib
    attr_accessor :name

    def initialize(name, *args, &block)
      @block = block
      args = args.insert(0, name)
      define name, args
    end

    def define(name, args)
      task *args do |task, task_args|
      	@task_args = task_args
        execute name.to_s
      end
    end

    def call_task_block(obj)
      if !@block.nil?
      	if @block.arity == 1
      	  @block.call(obj)
        else
      	  @block.call(obj, @task_args)
  	    end
  	  end
    end
  end
end

def create_task(taskname, task_object_proc, &execute_body)
  taskclass = :"Inetmgr_TaskFor_#{taskname}"
  taskmethod = taskname.to_s.downcase.to_sym

  Object.class_eval(<<-EOF, __FILE__, __LINE__)
    def #{taskmethod}(name=:#{taskname}, *args, &block)
      Inetmgr.const_get("#{taskclass}").new(name, *args, &block)
    end
  EOF

  Inetmgr.class_eval do
    const_set(taskclass, Class.new(Inetmgr::InetmgrTask) do
      define_method :execute do |name|
        task_object = task_object_proc.call

        call_task_block(task_object)
      	execute_body.call(task_object) unless execute_body.nil?
      end
    end)
  end
end


create_task :applicationpool, Proc.new { ApplicationPool.new } do |pool|
  pool.create
end

create_task :application, Proc.new { Application.new } do |pool|
  pool.create
end

create_task :site, Proc.new { Site.new } do |site|
  site.create
end

create_task :auto_start_provider, Proc.new { AutoStartProvider.new } do |p|
  p.create
end

create_task :virtual_directory, Proc.new { VirtualDirectory.new } do |dir|
  dir.create
end
