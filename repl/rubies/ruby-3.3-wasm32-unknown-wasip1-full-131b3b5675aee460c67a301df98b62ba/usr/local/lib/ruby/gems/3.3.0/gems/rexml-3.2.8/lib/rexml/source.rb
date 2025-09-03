# coding: US-ASCII
# frozen_string_literal: false
require_relative 'encoding'

module REXML
  # Generates Source-s.  USE THIS CLASS.
  class SourceFactory
    # Generates a Source object
    # @param arg Either a String, or an IO
    # @return a Source, or nil if a bad argument was given
    def SourceFactory::create_from(arg)
      if arg.respond_to? :read and
          arg.respond_to? :readline and
          arg.respond_to? :nil? and
          arg.respond_to? :eof?
        IOSource.new(arg)
      elsif arg.respond_to? :to_str
        require 'stringio'
        IOSource.new(StringIO.new(arg))
      elsif arg.kind_of? Source
        arg
      else
        raise "#{arg.class} is not a valid input stream.  It must walk \n"+
          "like either a String, an IO, or a Source."
      end
    end
  end

  # A Source can be searched for patterns, and wraps buffers and other
  # objects and provides consumption of text
  class Source
    include Encoding
    # The line number of the last consumed text
    attr_reader :line
    attr_reader :encoding

    # Constructor
    # @param arg must be a String, and should be a valid XML document
    # @param encoding if non-null, sets the encoding of the source to this
    # value, overriding all encoding detection
    def initialize(arg, encoding=nil)
      @orig = arg
      @scanner = StringScanner.new(@orig)
      if encoding
        self.encoding = encoding
      else
        detect_encoding
      end
      @line = 0
    end

    # The current buffer (what we're going to read next)
    def buffer
      @scanner.rest
    end

    def buffer_encoding=(encoding)
      @scanner.string.force_encoding(encoding)
    end

    # Inherited from Encoding
    # Overridden to support optimized en/decoding
    def encoding=(enc)
      return unless super
      encoding_updated
    end

    def read(term = nil)
    end

    def read_until(term)
      @scanner.scan_until(Regexp.union(term)) or @scanner.rest
    end

    def ensure_buffer
    end

    def match(pattern, cons=false)
      if cons
        @scanner.scan(pattern).nil? ? nil : @scanner
      else
        @scanner.check(pattern).nil? ? nil : @scanner
      end
    end

    def position
      @scanner.pos
    end

    def position=(pos)
      @scanner.pos = pos
    end

    # @return true if the Source is exhausted
    def empty?
      @scanner.eos?
    end

    # @return the current line in the source
    def current_line
      lines = @orig.split
      res = lines.grep @scanner.rest[0..30]
      res = res[-1] if res.kind_of? Array
      lines.index( res ) if res
    end

    private

    def detect_encoding
      scanner_encoding = @scanner.rest.encoding
      detected_encoding = "UTF-8"
      begin
        @scanner.string.force_encoding("ASCII-8BIT")
        if @scanner.scan(/\xfe\xff/n)
          detected_encoding = "UTF-16BE"
        elsif @scanner.scan(/\xff\xfe/n)
          detected_encoding = "UTF-16LE"
        elsif @scanner.scan(/\xef\xbb\xbf/n)
          detected_encoding = "UTF-8"
        end
      ensure
        @scanner.string.force_encoding(scanner_encoding)
      end
      self.encoding = detected_encoding
    end

    def encoding_updated
      if @encoding != 'UTF-8'
        @scanner.string = decode(@scanner.rest)
        @to_utf = true
      else
        @to_utf = false
        @scanner.string.force_encoding(::Encoding::UTF_8)
      end
    end
  end

  # A Source that wraps an IO.  See the Source class for method
  # documentation
  class IOSource < Source
    #attr_reader :block_size

    # block_size has been deprecated
    def initialize(arg, block_size=500, encoding=nil)
      @er_source = @source = arg
      @to_utf = false
      @pending_buffer = nil

      if encoding
        super("", encoding)
      else
        super(@source.read(3) || "")
      end

      if !@to_utf and
          @orig.respond_to?(:force_encoding) and
          @source.respond_to?(:external_encoding) and
          @source.external_encoding != ::Encoding::UTF_8
        @force_utf8 = true
      else
        @force_utf8 = false
      end
    end

    def read(term = nil)
      begin
        @scanner << readline(term)
        true
      rescue Exception, NameError
        @source = nil
        false
      end
    end

    def read_until(term)
      pattern = Regexp.union(term)
      begin
        until str = @scanner.scan_until(pattern)
          @scanner << readline(term)
        end
      rescue EOFError
        @scanner.rest
      else
        read if @scanner.eos? and !@source.eof?
        str
      end
    end

    def ensure_buffer
      read if @scanner.eos? && @source
    end

    # Note: When specifying a string for 'pattern', it must not include '>' except in the following formats:
    # - ">"
    # - "XXX>" (X is any string excluding '>')
    def match( pattern, cons=false )
      while true
        if cons
          md = @scanner.scan(pattern)
        else
          md = @scanner.check(pattern)
        end
        break if md
        return nil if pattern.is_a?(String)
        return nil if @source.nil?
        return nil unless read
      end

      md.nil? ? nil : @scanner
    end

    def empty?
      super and ( @source.nil? || @source.eof? )
    end

    # @return the current line in the source
    def current_line
      begin
        pos = @er_source.pos        # The byte position in the source
        lineno = @er_source.lineno  # The XML < position in the source
        @er_source.rewind
        line = 0                    # The \r\n position in the source
        begin
          while @er_source.pos < pos
            @er_source.readline
            line += 1
          end
        rescue
        end
        @er_source.seek(pos)
      rescue IOError
        pos = -1
        line = -1
      end
      [pos, lineno, line]
    end

    private
    def readline(term = nil)
      str = @source.readline(term || @line_break)
      if @pending_buffer
        if str.nil?
          str = @pending_buffer
        else
          str = @pending_buffer + str
        end
        @pending_buffer = nil
      end
      return nil if str.nil?

      if @to_utf
        decode(str)
      else
        str.force_encoding(::Encoding::UTF_8) if @force_utf8
        str
      end
    end

    def encoding_updated
      case @encoding
      when "UTF-16BE", "UTF-16LE"
        @source.binmode
        @source.set_encoding(@encoding, @encoding)
      end
      @line_break = encode(">")
      @pending_buffer, @scanner.string = @scanner.rest, ""
      @pending_buffer.force_encoding(@encoding)
      super
    end
  end
end
