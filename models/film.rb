require_relative("../db/sql_runner")

class Film

attr_reader :id
attr_accessor :title, :price

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @price = options['price']
end

def save()
  sql = "INSERT INTO films (title, price) VALUES ($1,$2) RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run(sql, values).first
  @id = film['id'].to_i
end

def update()
  sql = "UPDATE films SET (title, price) = ($1,$2) WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM films"
  film = SqlRunner.run(sql)
  result = film.map { |film| Film.new(film)  }
  return result
end

def customers()
  sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customer.id
  WHERE customers.film_id = $1"
  values = [@id]
  pg_result = SqlRunner.run(sql, values)
  customers = pg_result.map { |customers_hash| Customer.new(customers_hash)  }
  return customers
end


end
