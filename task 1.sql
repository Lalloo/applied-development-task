create table cars (
    id serial primary key,
    make varchar not null,
    model varchar not null,
    year integer not null,
	color varchar not null,
    license_plate varchar unique not null
)
;

create table owners (
    id serial primary key,
    first_name varchar not null,
    last_name varchar not null,
    email varchar unique not null,
    phone varchar not null
)
;

create table cars_owner (
    car_owner_id serial primary key,
    car_id integer references cars(id) on delete cascade,
    owner_id integer references owners(id) on delete cascade,
    start_date date not null,
    end_date date
)
;

insert into cars (make, model, year, color, license_plate) 
values  ('Honda', 'Civic', 2020, 'White', 'AB1234CD'),
        ('Toyota', 'Camry', 2018, 'Black', 'EF5678GH'),
        ('Ford', 'F-150', 2019, 'Blue', 'IJ9012KL'),
        ('Chevrolet', 'Cruze', 2019, 'Red', 'MN3456OP')
;

insert into owners (first_name, last_name, email, phone)
values  ('John', 'Doe', 'johndoe@example.com', '555-1234'),
        ('Jane','Smith', 'janesmITH@example.com', '555-5678'),
        ('Bob', 'Johnson','bobjohnson@example.com', '555-9012'),
        ('Alice', 'Jones', 'alicejones@hotmail.com', '456-789-0123');
;

insert into cars_owners (car_id, owner_id, start_date, end_date)
values
(1, 1, '2019-01-01', '2020-12-31'),
(1, 2, '2021-01-01', NULL),
(2, 3, '2020-01-01', '2022-06-30'),
(3, 4, '2017-05-01', NULL),
(4, 2, '2019-06-01', '2020-12-31'),
(4, 3, '2021-01-01', NULL);
;

select distinct o.first_name, o.last_name, o.email, o.phone
from 
	owners o
join cars_owners c_o
	on o.id = c_o.owner_id
join cars c 
	on c_o.car_id = c.id
where (
	c_o.start_date <= '2022-01-01' 
	and (c_o.end_date is null 
		 or c_o.end_date >= '2022-01-01')
)
;

select o.first_name, o.last_name, count(c.id)
from 
	owners o
inner join cars_owners c_o
	on o.id = c_o.owner_id
inner join cars c
	on c.id = c_o.car_id
group by o.first_name, o.last_name