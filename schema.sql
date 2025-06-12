create database if not exists web_database;

use web_database;

-- users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    location VARCHAR(100)
);

create table search_history (
    id int auto_increment primary key,
    user_id int not null,
    search_term varchar(255) not null,
    search_date datetime not null
);
create table cart (
    id int auto_increment primary key,
    user_id int not null,
    product_id int not null,
    quantity int default 1
);
create table product_comparisons (
    id int auto_increment primary key,
    user_id int not null,
    product_id int not null
);
-- orders
create table orders (
    id int auto_increment primary key,
    user_id int not null,
    order_date datetime,
    order_status varchar(50),
    order_total decimal(10, 2)
);
create table order_items (
    id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int,
    price_each decimal(10, 2)
);

-- employees
create table employees (
    id int auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) unique not null,
    position varchar(50),
    hired_date date,
    is_active boolean
);

-- products
create table products (
    id int auto_increment primary key,
    name varchar(100) not null,
    description text,
    price decimal(10, 2) not null,
    stock int,
    sku varchar(50) unique,
    category_id int,
    brand varchar(50),
    weight decimal(10, 2),
    dimensions varchar(100),
    color varchar(50),
    image_url varchar(255),
    is_active boolean,
    created_by int,
    updated_by int
);
create table categories (
    id int auto_increment primary key,
    name varchar(100) not null unique,
    description text
);


-- joins
alter table search_history
    add foreign key (user_id) references users(id);

alter table orders
    add foreign key (user_id) references users(id);

alter table order_items
    add foreign key (order_id) references orders(id),
    add foreign key (product_id) references products(id);

alter table products
    add foreign key (category_id) references categories(id),
    add foreign key (created_by) references employees(id),
    add foreign key (updated_by) references employees(id);

alter table cart
    add foreign key (user_id) references users(id) on delete cascade,
    add foreign key (product_id) references products(id) on delete cascade;

alter table product_comparisons
  add foreign key (user_id) references users(id) on delete cascade,
  add foreign key (product_id) references products(id) on delete cascade;




-- shecdomebi, !!washale da shecvale table!!
alter table employees
modify COLUMN position enum('admin', 'manager', 'staff') default 'staff';



-- idk add admin

insert into employees (id,first_name,last_name,email,position,hired_date,is_active
) values (1,'zuriko','unknown','admin@gmail.com','admin',date('2025-06-05'),TRUE);

-- data
-- products
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic gadgets and devices'),
('Home Appliances', 'Appliances for home use'),
('Sports Equipment', 'Gear and equipment for sports activities');


INSERT INTO products (name, description, price, stock, sku, category_id, brand, weight, dimensions, color, image_url, is_active, created_by, updated_by) VALUES
('Mountain Bike', '21-speed mountain bike', 499.99, 25, 'SPORT001', 3, 'RideFast', 15, '1700x600x1000 mm', 'Red', NULL, TRUE, 1, 1),
('Tennis Racket', 'Lightweight tennis racket', 149.99, 50, 'SPORT002', 3, 'AceSport', 0.3, '680x270 mm', 'Blue', NULL, TRUE, 1, 1),
('Football', 'Official size and weight football', 29.99, 100, 'SPORT003', 3, 'KickPro', 0.5, '220 mm diameter', 'White', NULL, TRUE, 1, 1),
('Basketball', 'Indoor/outdoor basketball', 34.99, 80, 'SPORT004', 3, 'HoopStar', 0.6, '240 mm diameter', 'Orange', NULL, TRUE, 1, 1),
('Yoga Mat', 'Non-slip yoga mat', 39.99, 150, 'SPORT005', 3, 'FlexFit', 1.5, '1800x600x6 mm', 'Purple', NULL, TRUE, 1, 1),
('Dumbbell Set', 'Adjustable dumbbells up to 20kg', 199.99, 30, 'SPORT006', 3, 'StrongFit', 20, 'various', 'Black', NULL, TRUE, 1, 1),
('Running Shoes', 'Lightweight running shoes', 119.99, 70, 'SPORT007', 3, 'SpeedRunner', 0.8, 'various', 'White', NULL, TRUE, 1, 1),
('Golf Clubs Set', 'Complete golf clubs set', 899.99, 10, 'SPORT008', 3, 'ProGolf', 5, 'various', 'Silver', NULL, TRUE, 1, 1),
('Swimming Goggles', 'Anti-fog swim goggles', 19.99, 100, 'SPORT009', 3, 'AquaView', 0.1, 'various', 'Blue', NULL, TRUE, 1, 1),
('Baseball Bat', 'Wooden baseball bat', 59.99, 40, 'SPORT010', 3, 'BatMaster', 1, '900x70 mm', 'Natural', NULL, TRUE, 1, 1),
('Boxing Gloves', '16oz boxing gloves', 79.99, 50, 'SPORT011', 3, 'FightPro', 1.2, 'various', 'Red', NULL, TRUE, 1, 1),
('Exercise Bike', 'Stationary exercise bike', 399.99, 15, 'SPORT012', 3, 'FitCycle', 25, '1200x600x1000 mm', 'Black', NULL, TRUE, 1, 1),
('Skateboard', 'Classic skateboard', 89.99, 30, 'SPORT013', 3, 'BoardX', 3, '800x200 mm', 'Black', NULL, TRUE, 1, 1),
('Jump Rope', 'Adjustable jump rope', 14.99, 120, 'SPORT014', 3, 'JumpFit', 0.2, 'various', 'Red', NULL, TRUE, 1, 1),
('Treadmill', 'Folding electric treadmill', 699.99, 10, 'SPORT015', 3, 'RunFast', 50, '1600x700x1200 mm', 'Gray', NULL, TRUE, 1, 1),
('Climbing Helmet', 'Safety climbing helmet', 79.99, 40, 'SPORT016', 3, 'SafeClimb', 0.7, 'various', 'White', NULL, TRUE, 1, 1),
('Kayak', 'Single person kayak', 499.99, 8, 'SPORT017', 3, 'WaterRide', 25, '3200x800x400 mm', 'Blue', NULL, TRUE, 1, 1),
('Hiking Backpack', '50L hiking backpack', 129.99, 60, 'SPORT018', 3, 'TrailGear', 2, 'various', 'Green', NULL, TRUE, 1, 1),
('Soccer Cleats', 'Firm ground soccer cleats', 89.99, 70, 'SPORT019', 3, 'KickPro', 0.7, 'various', 'Black', NULL, TRUE, 1, 1),
('Golf Balls (12-pack)', 'Pack of 12 golf balls', 29.99, 150, 'SPORT020', 3, 'ProGolf', 0.2, 'various', 'White', NULL, TRUE, 1, 1);
('Refrigerator 300L', 'Energy efficient refrigerator', 899.99, 30, 'HOME001', 2, 'CoolHome', 70, '1800x700x700 mm', 'Silver', NULL, TRUE, 1, 1),
('Microwave Oven', '1000W microwave oven', 149.99, 50, 'HOME002', 2, 'HeatWave', 15, '500x350x300 mm', 'Black', NULL, TRUE, 1, 1),
('Washing Machine', '7kg front load washing machine', 499.99, 25, 'HOME003', 2, 'WashPro', 65, '850x600x600 mm', 'White', NULL, TRUE, 1, 1),
('Vacuum Cleaner', 'Cordless stick vacuum', 299.99, 40, 'HOME004', 2, 'CleanMax', 3, '1200x250x250 mm', 'Red', NULL, TRUE, 1, 1),
('Air Conditioner 1.5 Ton', 'Split AC with inverter tech', 799.99, 20, 'HOME005', 2, 'CoolAir', 35, '900x300x200 mm', 'White', NULL, TRUE, 1, 1),
('Electric Kettle', '1.7L fast boil kettle', 49.99, 100, 'HOME006', 2, 'BoilQuick', 1.2, '250x150x220 mm', 'Silver', NULL, TRUE, 1, 1),
('Dishwasher', '12 place settings dishwasher', 699.99, 15, 'HOME007', 2, 'DishClean', 50, '850x600x600 mm', 'White', NULL, TRUE, 1, 1),
('Coffee Maker', '12-cup programmable coffee maker', 129.99, 60, 'HOME008', 2, 'BrewMaster', 4.5, '350x250x350 mm', 'Black', NULL, TRUE, 1, 1),
('Toaster', '4-slice toaster', 39.99, 80, 'HOME009', 2, 'ToastPro', 2, '300x200x150 mm', 'Chrome', NULL, TRUE, 1, 1),
('Blender', 'Multi-speed blender', 59.99, 90, 'HOME010', 2, 'MixIt', 3, '400x200x200 mm', 'White', NULL, TRUE, 1, 1),
('Ceiling Fan', '52-inch ceiling fan', 99.99, 70, 'HOME011', 2, 'AirFlow', 6, '1300x1300x350 mm', 'Brown', NULL, TRUE, 1, 1),
('Water Heater', '10L electric water heater', 199.99, 30, 'HOME012', 2, 'HeatFlow', 10, '600x350x350 mm', 'White', NULL, TRUE, 1, 1),
('Rice Cooker', '5-cup rice cooker', 49.99, 50, 'HOME013', 2, 'CookWell', 2.5, '300x250x250 mm', 'Silver', NULL, TRUE, 1, 1),
('Electric Grill', 'Indoor electric grill', 79.99, 40, 'HOME014', 2, 'GrillMaster', 4, '350x250x150 mm', 'Black', NULL, TRUE, 1, 1),
('Slow Cooker', '6-quart slow cooker', 69.99, 45, 'HOME015', 2, 'CookEase', 3.5, '350x300x300 mm', 'White', NULL, TRUE, 1, 1),
('Ice Maker', 'Countertop ice maker', 149.99, 20, 'HOME016', 2, 'IceCool', 7, '400x350x300 mm', 'Silver', NULL, TRUE, 1, 1),
('Air Purifier', 'HEPA air purifier', 199.99, 25, 'HOME017', 2, 'PureAir', 5, '400x250x250 mm', 'White', NULL, TRUE, 1, 1),
('Food Processor', '10-cup food processor', 129.99, 30, 'HOME018', 2, 'ChopIt', 6, '350x250x250 mm', 'Black', NULL, TRUE, 1, 1),
('Juicer', 'Cold press juicer', 159.99, 35, 'HOME019', 2, 'JuiceFresh', 4, '400x250x250 mm', 'Silver', NULL, TRUE, 1, 1),
('Electric Oven', 'Countertop convection oven', 179.99, 20, 'HOME020', 2, 'BakePro', 9, '450x400x350 mm', 'Black', NULL, TRUE, 1, 1);
('Smartphone X100', 'Latest smartphone with OLED display', 699.99, 50, 'ELEC001', 1, 'TechBrand', 0.3, '150x70x8 mm', 'Black', NULL, TRUE, 1, 1),
('Laptop Pro 15"', 'Powerful laptop for professionals', 1299.99, 35, 'ELEC002', 1, 'CompTech', 2.0, '350x240x18 mm', 'Silver', NULL, TRUE, 1, 1),
('Wireless Headphones', 'Noise-cancelling over-ear headphones', 199.99, 80, 'ELEC003', 1, 'SoundMax', 0.25, '180x170x80 mm', 'White', NULL, TRUE, 1, 1),
('Smartwatch Z', 'Smartwatch with fitness tracking', 249.99, 60, 'ELEC004', 1, 'WristTech', 0.05, '45x45x12 mm', 'Black', NULL, TRUE, 1, 1),
('Bluetooth Speaker', 'Portable Bluetooth speaker', 99.99, 100, 'ELEC005', 1, 'AudioBeat', 0.6, '200x80x80 mm', 'Blue', NULL, TRUE, 1, 1),
('4K TV 50"', 'Ultra HD 4K television', 799.99, 20, 'ELEC006', 1, 'VisionCorp', 10, '1120x650x70 mm', 'Black', NULL, TRUE, 1, 1),
('Gaming Console X', 'Next-gen gaming console', 499.99, 40, 'ELEC007', 1, 'GamePro', 3.5, '300x250x100 mm', 'Black', NULL, TRUE, 1, 1),
('Digital Camera 24MP', 'DSLR camera with 24MP sensor', 899.99, 15, 'ELEC008', 1, 'PhotoPlus', 0.8, '140x100x80 mm', 'Black', NULL, TRUE, 1, 1),
('External SSD 1TB', 'Fast external solid state drive', 179.99, 70, 'ELEC009', 1, 'DataStore', 0.1, '100x70x10 mm', 'Gray', NULL, TRUE, 1, 1),
('Wireless Mouse', 'Ergonomic wireless mouse', 49.99, 120, 'ELEC010', 1, 'ClickTech', 0.09, '110x60x40 mm', 'Black', NULL, TRUE, 1, 1),
('Mechanical Keyboard', 'RGB backlit mechanical keyboard', 89.99, 90, 'ELEC011', 1, 'KeyMaster', 1.2, '450x130x40 mm', 'Black', NULL, TRUE, 1, 1),
('Smart Home Hub', 'Control your smart devices', 129.99, 30, 'ELEC012', 1, 'HomeSync', 0.7, '120x120x50 mm', 'White', NULL, TRUE, 1, 1),
('Action Camera', 'Waterproof 4K action camera', 299.99, 25, 'ELEC013', 1, 'AdventureCam', 0.2, '75x50x40 mm', 'Black', NULL, TRUE, 1, 1),
('E-Reader', '6-inch display e-reader', 119.99, 40, 'ELEC014', 1, 'ReadTech', 0.18, '160x110x8 mm', 'Black', NULL, TRUE, 1, 1),
('VR Headset', 'Virtual reality headset', 399.99, 15, 'ELEC015', 1, 'VirtualX', 0.6, '200x150x120 mm', 'Black', NULL, TRUE, 1, 1),
('Portable Charger', '10000mAh power bank', 39.99, 130, 'ELEC016', 1, 'ChargeIt', 0.25, '90x60x20 mm', 'Black', NULL, TRUE, 1, 1),
('Smart Thermostat', 'Control home temperature remotely', 179.99, 35, 'ELEC017', 1, 'ClimateControl', 0.3, '120x120x35 mm', 'White', NULL, TRUE, 1, 1),
('Noise Cancelling Earbuds', 'True wireless earbuds', 149.99, 80, 'ELEC018', 1, 'SoundMax', 0.05, '25x25x20 mm', 'Black', NULL, TRUE, 1, 1),
('Desktop Monitor 27"', 'QHD 27-inch display', 299.99, 25, 'ELEC019', 1, 'ViewTech', 4.0, '620x370x60 mm', 'Black', NULL, TRUE, 1, 1),
('Smart Light Bulb', 'Wi-Fi enabled LED bulb', 29.99, 200, 'ELEC020', 1, 'LightBright', 0.1, '60x110 mm', 'White', NULL, TRUE, 1, 1);


-- Insert Users
INSERT INTO users (username, email, first_name, last_name, location) VALUES
('jdoe', 'jdoe@example.com', 'John', 'Doe', 'New York'),
('asmith', 'asmith@example.com', 'Alice', 'Smith', 'Los Angeles'),
('bjones', 'bjones@example.com', 'Bob', 'Jones', 'Chicago'),
('ckent', 'ckent@example.com', 'Clark', 'Kent', 'Metropolis'),
('dwayne', 'dwayne@example.com', 'Dwayne', 'Johnson', 'Miami'),
('emilyw', 'emilyw@example.com', 'Emily', 'Williams', 'Seattle'),
('frankb', 'frankb@example.com', 'Frank', 'Brown', 'Houston'),
('gloria', 'gloria@example.com', 'Gloria', 'Lopez', 'Phoenix'),
('henryk', 'henryk@example.com', 'Henry', 'Kim', 'San Francisco'),
('isabell', 'isabell@example.com', 'Isabel', 'Lee', 'Boston');

INSERT INTO search_history (user_id, search_term, search_date) VALUES
(1, 'smartphones', '2025-06-01 10:00:00'),
(2, 'gaming laptops', '2025-06-02 14:30:00'),
(3, 'wireless headphones', '2025-06-03 09:15:00'),
(4, 'home air conditioners', '2025-06-03 11:45:00'),
(5, 'yoga mats', '2025-06-04 16:20:00'),
(1, '4k televisions', '2025-06-04 18:00:00'),
(2, 'electric kettles', '2025-06-05 08:45:00');

INSERT INTO cart (user_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 5, 2),
(2, 12, 1),
(3, 7, 1),
(4, 25, 3),
(5, 40, 1),
(6, 60, 2);

INSERT INTO product_comparisons (user_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 7),
(3, 20),
(4, 40),
(5, 60);

INSERT INTO orders (user_id, order_date, order_status, order_total) VALUES
(1, '2025-05-15 13:00:00', 'completed', 799.97),
(2, '2025-05-20 17:45:00', 'processing', 1299.99),
(3, '2025-05-25 09:30:00', 'shipped', 299.99),
(4, '2025-05-28 15:10:00', 'cancelled', 149.99),
(5, '2025-06-01 12:00:00', 'completed', 199.98);

INSERT INTO order_items (order_id, product_id, quantity, price_each) VALUES
(1, 1, 1, 699.99),
(1, 5, 1, 99.99),
(2, 2, 1, 1299.99),
(3, 7, 1, 299.99),
(4, 6, 1, 149.99),
(5, 16, 2, 99.99);

-- Insert Employees
INSERT INTO employees (first_name, last_name, email, position, hired_date, is_active) VALUES
('Alice', 'Green', 'alice.green@example.com', 'manager', '2023-01-10', TRUE),
('Bob', 'White', 'bob.white@example.com', 'staff', '2022-08-15', TRUE),
('Carol', 'Black', 'carol.black@example.com', 'staff', '2024-03-05', TRUE),
('David', 'Brown', 'david.brown@example.com', 'staff', '2023-11-20', TRUE),
('Eva', 'Davis', 'eva.davis@example.com', 'manager', '2022-06-30', TRUE);


