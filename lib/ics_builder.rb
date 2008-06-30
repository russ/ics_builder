require 'icalendar'

module ActionView # :nodoc:
  module TemplateHandlers
    # Template handler for ics templates
    #
    # Add events to your calendar file in the template.
    #
    #   @events.each do |event|
    #     calendar.event do
    #       dtstart(event.start_time)
    #       dtend(event.end_time)
    #       summary(event.title)
    #       description(event.description)
    #     end
    #   end
    #
    # You can set the default filename for that a browser will use for 'save as' by
    # setting <tt>@filename</tt> instance variable in your controller's action method
    # e.g.
    #
    #   @filename = 'events.ics'
 
    class IcsBuilder < TemplateHandler
      include Compilable
 
      def self.line_offset
        7
      end
 
 
      def compile(template)
        <<-EOV
        unless defined?(ActionMailer) && defined?(ActionMailer::Base) && controller.is_a?(ActionMailer::Base)
          @filename ||= "\#{controller.action_name}.ics"
          controller.response.headers["Content-Type"] ||= 'text/icalendar'
          controller.response.headers['Content-Disposition'] = "attachment; filename=\#{@filename}"
        end

        result = Icalendar::Calendar.generate do |calendar|
          #{template.source}
        end

        result
        EOV
      end
    end
  end
end
