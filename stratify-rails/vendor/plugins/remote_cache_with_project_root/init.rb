# This "plugin" is only intended for use during deployment.  As such, we
# don't want to load the plugin (or perform any initialization, for that
# matter) in init.rb.  To use this plugin during deployment, add the lib
# dir to your load path at the top of your deploy.rb file:
#
#   $:.unshift File.expand_path('../../vendor/plugins/remote_cache_with_project_root/lib', __FILE__)
