require 'abstract_controller'
require 'action_view'
require 'action_mailer/collector'

module Emailvision4rails
	class BaseController < ::AbstractController::Base
    warn "EmailVision4Rails::BaseController"
    abstract!

		include AbstractController::Logger
		include AbstractController::Rendering
		include AbstractController::Layouts

		append_view_path "#{Rails.root}/app/views"

		private_class_method :new

		class << self
			def respond_to?(method, include_private = false)
        warn "EmailVision4Rails::BaseController#respond_to"
        super || action_methods.include?(method.to_s)
			end

			protected

			def method_missing(method, *args)
        warn "EmailVision4Rails::BaseController#method_missing"
				return super unless respond_to?(method)
				instance = new(method, *args)
				instance.render_views
				instance.rendered_views
			end		
		end

		attr_internal :rendered_views

	  def initialize(method_name=nil, *args)
      warn "EmailVision4Rails::BaseController#initialize"
      super()
	    lookup_context.formats = [:text, :html] # Restrict rendering formats to html and text
	    process(method_name, *args) if method_name
	  end

		def process(method_name, *args)
      warn "EmailVision4Rails::BaseController#process"
      lookup_context.skip_default_locale!
			super(method_name, *args)
		end

		def render_views
      warn "EmailVision4Rails::BaseController#render_views"
      self.rendered_views = ::Emailvision4rails::RenderedViews.new(collect_responses(lookup_context.formats))
		end

		private

		def collect_responses(formats)
      warn "EmailVision4Rails::BaseController#collect_response"
      collector = ActionMailer::Collector.new(lookup_context) do
				render(action_name)
			end			
			responses = {}
			formats.each do |f|
				collector.send(f)
				responses[f] = collector.responses.last[:body]
			end
			responses
		end

	end	
end