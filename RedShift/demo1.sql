create table customers(
customer_number integer,
name varchar(30),
age integer
);

create table products (
product_number integer,
product_name varchar(30),
price decimal(5,2)
);

create table orders (
customer_number integer,
product_number integer,
quantity integer
);

insert into customers (customer_number, name, age) values (1, 'Alex', 63), (2, 'Brooke', 47), (3, 'Sudhir', 34), (4, 'Taylor', 27), (5, 'Robbie', 54);

insert into products (product_number, product_name, price) values (1, 'Hammer', 9.99), (2, 'Drill', 64.99), (3, 'Pipe wrench', 17.99), (4, 'Hand saw', 14.99);

insert into orders (customer_number, product_number, quantity) values (1, 1, 4), (4, 2, 7), (3, 4, 6), (5, 1, 1), (5, 3, 2);

select * from customers;

select name, product_name, quantity, quantity * price as total_price 
from customers 
join orders on customers.customer_number = orders.customer_number
join products on orders.product_number = products.product_number;