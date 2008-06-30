require 'ics_builder'
require 'icalendar_generate'

ActionView::Template.register_template_handler 'icsbuilder', ActionView::TemplateHandlers::IcsBuilder
