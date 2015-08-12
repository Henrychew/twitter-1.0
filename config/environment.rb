# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'
require 'twitter'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'
require 'byebug'
require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')


$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "J98pinhVc7sJ2P0bkeigNtRCv"
  config.consumer_secret     = "G2UppNhdXObTjYhkgdNce9QfC5WR5IPflXncefplbHDGTc9VGS"
  config.access_token        = "612492229-fBurH1Iih2478bfwciFKlYIFvDBwsMzaOVwBwakg"
  config.access_token_secret = "TydrDCZLmZPxl2IR8Ii9O95y1HEt2Q8Pe8PoYrbSM7yaZ"
end
