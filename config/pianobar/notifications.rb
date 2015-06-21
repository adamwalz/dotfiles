#!/usr/bin/env ruby

require 'shellwords'

# Ignore all events except songstart
exit 0 unless ARGV[0] == 'songstart'

event = STDIN.read

# Turn the pianobar data into a useful hash
def parse_event(event)
  fields = event.split("\n")
  return nil unless fields
  fields.map! { |f| f.split('=') }

  # Remove all the empty fields, they'll end up nil anyways
  fields.reject! { |f| f.length != 2 }

  # Create a hash, and fill it
  # Field names are all symbols
  result = {}
  fields.each { |f| result[f[0].to_sym] = f[1] }

  return result
end

data = parse_event(event)

# The data we want
artist = data[:artist]
song   = data[:title]
album  = data[:album]

heart = "<3" if data[:rating] == '1'

# The AppleScript for using OS X notification center
script = <<-END
display notification "by #{artist} on #{album}" with title "Now Playing" subtitle "#{song} #{heart}"
END

# Sometimes the stupid shellwords stuff shits a brick on unicode.
# Ruby 1.9.3 improves this, but for whatever reason it still doesn't
# work randomly. Rather than polluting the pianobar output with a
# stack trace, we'll just ignore it and exit gracefully instead.
begin
  `osascript -e #{script.shellescape}`
rescue Exception
  exit 1
end
