require 'jbuilder'

require "fdbq/fdbq"
require "fdbq/rails/engine"

module Fdbq
  module Rails
    def self.controller_parent
      if latest?
        'ApplicationController'
      else
        'ActionController::Base'
      end
    end

    def self.model_parent
      if latest?
        'ApplicationRecord'
      else
        'ActiveRecord::Base'
      end
    end

    def self.latest?
      ::Rails.version.to_i >= 5
    end
  end
end
