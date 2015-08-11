current_dir = File.dirname(__FILE__)
  user = ENV['USER']
  node_name user
  syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntax_check_cache"
  cookbook_path ["#{current_dir}/../cookbooks"]
  cookbook_copyright "E Source Companies, LLC"
  cookbook_license "DO NOT DISTRIBUTE"
  cookbook_email "dev@esource.com"