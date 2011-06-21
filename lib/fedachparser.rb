
require 'curb'
require 'dbi'

class FedACHParser

  # We'll let all exceptions raised by curb or dbi propagate
  # since we can't do anything about them

  def initialize(url, dbname, dbuser, dbpass)
    raise ArgumentError, 'url must not be empty' unless(url && url.size>0)
    raise ArgumentError, 'dbname must not be empty' unless(dbname && dbname.size>0)
    raise ArgumentError, 'dbuser must not be empty' unless(dbuser && dbuser.size>0)

    @url = url

    # we could use ActiveRecord here but it seems overkill,
    # using simple dbi instead
    @dbh = DBI.connect("DBI:Mysql:#{dbname}", dbuser, dbpass)

    # This would probably greatly benefit from batch inserts instead
    # of one insert per line, but I want to keep it simple.
    @i_bank = @dbh.prepare('INSERT INTO banks (routing_number, name) ' +
                            'VALUES (?, ?)')
  end

  # download the file and store it in @data
  def download
    # I find the standard lib http interface awkward,
    # so I'm using libcurl + curb
    c = Curl::Easy.new(@url)
    c.perform
    @data = c.body_str
  end

  # iterator over all institutions
  def each_parsed_line
    @data.each_line do |line|
      h = parse_line(line.chomp)
      # we'll just ditch the lines that can't be parsed
      yield h if h
    end
  end

  # Parse and store the data into the db
  def store
    each_parsed_line do |h|
      store_line h
    end
  end

  # don't forget to release the database connection
  def disconnect
    @dbh.disconnect
  end

  protected

  # range for each column we want to parse
  COLUMNS = { :routing_number  => 0..9,
             :name            => 35..70 }
  MIN_LINE_SIZE = 71


  # converts a line string into a hash
  def parse_line(line)
    return nil unless line.size>MIN_LINE_SIZE

    h = {}
    COLUMNS.each do |k, v|
      h[k] = line[v]
    end
    return h
  end

  # save an entry into the database
  def store_line(h)
    # The assumption is that we start from scratch with an empty database.
    @i_bank.execute(h[:routing_number], h[:name])
  end

end
