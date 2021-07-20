require "byebug"
require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    @eles ||= DBConnection.execute2(<<-SQL)
    SELECT *
    FROM "#{self.table_name}"
    SQL

    @eles[0].map(&:to_sym)

  end

  def self.finalize!
    @attributes ||= {}
    self.columns.each do |col|
       @attributes[col] ||= true
    end
  
    @attributes.each do |k, v|
      define_method(k) do
        self.attributes[k]
      end
      arg1 = k.to_s + '='
      define_method(arg1) do |val|
        self.attributes[k] = val
      end

    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...

    params.each do |k, v|
      # debugger
      k = k.to_sym
      # raise "unknown attribute '#{k}'" if key
      self.send(k, v)
    end

  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end


class BigDog < SQLObject
end

p BigDog.table_name # => "big_dogs"