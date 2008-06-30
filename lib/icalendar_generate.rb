module Icalendar # :nodoc:
  class Calendar # :nodoc:
    def self.generate
      icalendar = new
      yield icalendar
      icalendar.to_ical
    end
  end
end
