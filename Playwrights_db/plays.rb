require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_playwright(name)
    data = PlayDBConnection.instance.execute(<<-SQL,name)
      SELECT plays.*
      FROM plays
      INNER JOIN playwrights
      ON plays.playwright_id = playwrights.id
      WHERE playwrights.name = ?
    SQL
    data.map { |datum| Play.new(datum)}
  end

  def self.find_by_title(title)
    data = PlayDBConnection.instance.execute(<<-SQL,title)
      SELECT * FROM plays WHERE title = ?
    SQL
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :id, :name, :birth_year
  def self.all
    data = PlayDBConnection.instance.execute(<<-SQL)
      SELECT *
      FROM playwrights
    SQL

    data.map {|datum| Playwright.new(datum)}
  end

  def self.find_by_name(name)
    data = PlayDBConnection.instance.execute(<<-SQL,name)
      SELECT *
      FROM playwrights
      WHERE name = ?
    SQL

    data.map {|datum| Playwright.new(datum)}
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL,self.name,self.birth_year)
      INSERT INTO playwrights (name, birth_year)
      VALUES (?, ?)
    SQL
    self.id = PlayDBConnection.instance.execute.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL,self.name,self.birth_year,self.id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    data = PlayDBConnection.instance.execute(<<-SQL,self.name)
      SELECT plays.*
      FROM playwrights
      INNER JOIN plays
      ON plays.playwright_id = playwrights.id
      WHERE playwrights.name = ?
    SQL

    data.map {|datum| Play.new(datum)}
  end
end