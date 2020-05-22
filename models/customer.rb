require_relative("../db/sql_runner")

class Customer

attr_reader :id
attr_accessor :first_name, :last_name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @first_name = options['first_name']
  @last_name = options['last_name']
  @funds = options['fee']
end

def save()
  sql = "INSERT INTO customers (first_name, last_name, funds) VALUES ($1,$2,$3) RETURNING id"
  values = [@first_name, @last_name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def update()
  sql = "UPDATE customers SET (first_name, last_name, funds) = ($1,$2,$3) WHERE id = $4"
  values = [@first_name, @last_name, @funds, @id]
  customer = SqlRunner.run(sql, values).first
end

def delete()
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM customers"
  customer = SqlRunner.run(sql)
  result = customer.map { |customer| Customer.new(customer)  }
  return result
end

def films()
  sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id
  WHERE tickets.customer_id = $1"
  values = [@id]
  pg_result = SqlRunner.run(sql, values)
  films = pg_result.map { |film_hash| Film.new(film_hash)  }
  return films
end

end
