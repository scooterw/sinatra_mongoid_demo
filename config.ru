$:.unshift File.join(File.expand_path(File.dirname(__FILE__)))
require 'server'
run MongoidDemo::Server

