#!/usr/bin/env ruby

$: << '.' << File.join(File.dirname(__FILE__), '..', 'lib')

require 'fedachparser'

begin
  # fedach is the dbname
  f = FedACHParser.new('http://www.fededirectory.frb.org/FedACHdir.txt',
                      'fedach', 'root', nil)
  f.download
  f.store
  f.disconnect
rescue => e
  puts "Oops, something went wrong: #{e}"
  exit 1
end

exit 0
