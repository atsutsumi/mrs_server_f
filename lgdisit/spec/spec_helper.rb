require 'simplecov'

SimpleCov.start do
	add_filter 'spec'
end

MONITOR_BASE_DIR = File.dirname(File.dirname(__FILE__))

require 'lgdisit'
