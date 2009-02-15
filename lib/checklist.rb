require 'rubygems'
require 'sequel'
DB = Sequel.sqlite

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

if DB.tables.empty?
  require 'migrations/run'
end

require 'checklist/task'

module Checklist
  VERSION = '0.0.1'
end