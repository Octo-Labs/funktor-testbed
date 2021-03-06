# Point at our Gemfile
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# load rubygems & bundler
require "rubygems"
require 'bundler/setup'

# Set up gems listed in the Gemfile.
Bundler.require(:default, :production)

# Load all ruby files in the app directory
require_rel File.join('..', 'app')
