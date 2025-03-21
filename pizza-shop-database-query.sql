create database pizza_shop;
use pizza_shop;

CREATE TABLE Customers (
	customer_id int primary key,
    customer_name varchar(75),
    phone_number varchar(15)
    );

CREATE TABLE Orders (
	order_id int primary key,
    customer_id int,
    order_date_and_time datetime,
    foreign key (customer_id) references Customers(customer_id) on delete cascade
    );

CREATE TABLE Pizzas (
	pizza_id int auto_increment primary key,
    pizza_name varchar(50),
    price decimal(5,2)
    );
    
CREATE TABLE Order_Pizzas (
	order_id int not null,
    pizza_id int not null,
    quantity int not null,
	primary key (order_id, pizza_id),
    foreign key (order_id) references Orders(order_id) on delete cascade,
    foreign key (pizza_id) references Pizzas(pizza_id) on delete cascade
    );

INSERT INTO Pizzas (pizza_id, pizza_name, price) VALUES
(1, 'Pepperoni & Cheese', 7.99),
(2, 'Vegetarian', 9.99),
(3, 'Meat Lovers', 14.99),
(4, 'Hawaiian', 12.99);

INSERT INTO Customers (customer_id, customer_name, phone_number) VALUES
(1, 'Trevor Page', 226-555-4892),
(2, 'John Doe', 555-555-9498); 

INSERT INTO  Orders (order_id, customer_id, order_date_and_time) VALUES
(1, 1, '2023-09-10 09:47:00'),
(2, 2, '2023-09-10 13:20:00'),
(3, 1, '2023-09-10 09:47:00'),
(4, 2, '2023-10-10 10:37:00');

INSERT INTO Order_Pizzas (order_id, pizza_id, quantity) VALUES 
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1),
(3, 4, 1),
(4, 2, 3),
(4, 4, 1);

select c.customer_name, sum(p.price * op.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Pizzas op ON o.order_id = op.order_id
JOIN Pizzas p ON op.pizza_id = p.pizza_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;
 
 select c.customer_name, DATE(o.order_date_and_time) AS order_date, sum(p.price * op.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Pizzas op ON o.order_id = op.order_id
JOIN Pizzas p ON op.pizza_id = p.pizza_id
GROUP BY c.customer_name, order_date
ORDER BY c.customer_name, order_date;
    