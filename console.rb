require_relative('models/ticket')
require_relative('models/film')
require_relative('models/customer')

require('pry')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({
  'title' => 'Pulp Fiction',
  'price' => 10
  })

film1.save()

film2 = Film.new({
  'title' => 'Gladiator',
  'price' => 10
  })

film2.save()

customer1 = Customer.new({
  'first_name' => 'Bob',
  'last_name' => 'Smith',
  'funds' => 20
  })

customer1.save()

  customer2 = Customer.new({
    'first_name' => 'Frank',
    'last_name' => 'Allan',
    'funds' => 30
    })

customer2.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket2.save()




binding.pry
nil
