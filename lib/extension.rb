require 'extensions/plugins'
require 'extensions/rails'


class Array
  # turns an array into an array of 'number'-sized partition
  # ex: [1,2,3,4,5,6,7].group(2) => [[1,2],[3,4],[5,6],[7]]
  def group(number)
    return [] if empty?
    result = []
    offset, limit = 0, number
    while( (a = self[offset...limit]) != nil && ! a.empty? )
      result << a
      offset, limit = offset + number, limit + number
    end
    result
  end
end

module Kernel
private
   def this_method
     caller[0] =~ /`([^']*)'/ and $1.to_sym
   end
end

# add gzipping of a file
# works on binary and text files
class File
  require 'zlib'

  def self.gzipfile(src_filename, delete_after = false, gzip_filename = nil)
    gzip_filename ||= "#{src_filename}.gz"
    open(gzip_filename, 'wb') do |dest|
      begin
        gzip = Zlib::GzipWriter.new(dest)
        IO.foreach(src_filename) { |line| gzip << line }
      ensure
        gzip.close if gzip && !gzip.closed?
      end
    end
    File.unlink(src_filename) if delete_after    
    gzip_filename
  end
end
