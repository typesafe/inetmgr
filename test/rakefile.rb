require '../lib/inetmgr'

task :default => [:show_all_settings]

task :show_all_settings do
  
  cfg = IisConfiguration.new
  
  puts "APPLICATION POOLS:"
  puts ""
  puts "name                     |auto_start|runtime_version|classic_pipeline|always_running"
  puts "------------------------------------------------------------------------------------"
  cfg.get_application_pools.each do |p|
    puts sprintf "%-25s|%-10s|%-15s|%-16s|%-s", p.name, p.auto_start, p.runtime_version, p.classic_pipeline, p.always_running
  end

  puts "SITES:"
  puts ""
  puts "name                     |auto_start"
  puts "------------------------------------------"
  cfg.get_sites.each do |s|
    puts sprintf "%-25s|%-10s", s.name, s.auto_start
  end
end



