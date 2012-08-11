# Rails::BacktraceCleaner#add_gem_filters strips gem paths from
# backtraces. This means Stratify gems implicated in errors will be
# unhelpfully removed from backtraces -- collectors in particular.

# Prevent this by creating a custom backtrace filter for all loaded
# Stratify gems wherein the telltale portion from each backtrace line
# gets stripped out before it can be targeted by #add_gem_filters.

def separator
  File.const_get("SEPARATOR")
end

def add_filter(path)
  Rails::backtrace_cleaner.add_filter do |line|
    line.gsub(path + separator, '')
  end
end

def stratify_gems
  Gem::Specification.find_all { |gem| gem.name =~ /stratify-/ }
end

stratify_gems.each { |gem| add_filter(gem.gem_dir) }
