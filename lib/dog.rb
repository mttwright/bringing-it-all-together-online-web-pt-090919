class Dog
  
  attr_accessor :id, :name, :breed
  
  def initialize(id: nil, name:, breed:)
    self.id = id
    self.name = name
    self.breed = breed
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      );
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE dogs;
    SQL
  
    DB[:conn].execute(sql)
  end
  
  def self.new_from_db(array)
    self.new(id: array[0], name: array[1], breed: array[2])
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM dogs
      WHERE name = ?
      LIMIT 1;
    SQL
    
    dog = DB[:conn].execute(sql, name)[0]
    self.new_from_db(dog)
  end
  
  def save
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
  end
  
  
  
  
end