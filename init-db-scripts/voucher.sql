drop table if exists VOUCHER_SESSION;
CREATE TABLE VOUCHER_SESSION (
                                 id 				BIGSERIAL 		PRIMARY KEY NOT NULL,              				-- Unique identifier for each voucher
                                 name 			VARCHAR(255) 	NOT NULL,                     			-- Voucher name
                                 code VARCHAR(50) NOT NULL, -- Voucher code

                                 created_date 	DATE 							default now(),
                                 start_date 		DATE 			NOT null 		default now(),          -- Start date of voucher validity
                                 end_date 		DATE 			NOT NULL,                         		-- End date of voucher validity
                                 min_value 		DECIMAL(15, 2) 	DEFAULT 0,       					-- Minimum order value to apply the voucher

    -- Discount amount or percentage
                                 discount_amount DECIMAL(15, 2) 	DEFAULT NULL,    						-- Discount amount (if it's a fixed discount)
                                 discount_percentage DECIMAL(5, 2) DEFAULT NULL, 						-- Discount percentage (if it's a percentage discount)

                                 voucher_type INT NOT NULL 												-- Voucher type (0: fix amount 1:percentage)
);

drop table if exists VOUCHER_SHOP;
CREATE TABLE VOUCHER_SHOP (
                              id 				BIGSERIAL 		PRIMARY KEY NOT NULL,              				-- Unique identifier for each voucher
                              name 			VARCHAR(255) 	NOT NULL,                     			-- Voucher name
                              code VARCHAR(50) NOT NULL, -- Voucher code

                              created_date 	DATE 							default now(),
                              start_date 		DATE 			NOT null 		default now(),          -- Start date of voucher validity
                              end_date 		DATE 			NOT NULL,                         		-- End date of voucher validity
                              min_value 		DECIMAL(15, 2) 	DEFAULT 0,             					-- Minimum order value to apply the voucher

    -- Discount amount or percentage
                              discount_amount DECIMAL(15, 2) 	DEFAULT NULL,    						-- Discount amount (if it's a fixed discount)
                              discount_percentage DECIMAL(5, 2) DEFAULT NULL, 						-- Discount percentage (if it's a percentage discount)

                              voucher_type INT NOT NULL 												-- Voucher type (0: fix amount 1:percentage)
);
-- Insert sample data for VOUCHER_SESSION with code field
INSERT INTO VOUCHER_SESSION (id, name, start_date, end_date, min_value, discount_amount, discount_percentage, voucher_type, code)
VALUES
    (1, 'Lunar New Year Bonus', '2024-11-01', '2024-12-30', 10000.00, 20000.00, NULL, 0, 'LNY2024'),
    (2, 'Valentine’s Day Offer', '2024-02-01', '2024-02-14', 150000.00, NULL, 10.00, 1, 'VALENTINE10'),
    (3, 'Spring Festival Discount', '2024-03-01', '2024-03-31', 50000.00, 5000.00, NULL, 0, 'SPRING5'),
    (4, 'Women’s Day Special', '2024-03-01', '2024-03-08', 200000.00, NULL, 15.00, 1, 'WOMEN15'),
    (5, 'Summer Bonanza', '2024-06-01', '2024-06-30', 300000.00, 30000.00, NULL, 0, 'SUMMER30'),
    (6, 'Mid-Autumn Sale', '2024-09-01', '2024-09-15', 100000.00, NULL, 12.00, 1, 'MIDAUTUMN12'),
    (7, 'Halloween Deal', '2024-10-01', '2024-10-31', 50000.00, 5000.00, NULL, 0, 'HALLOWEEN5'),
    (8, 'Black Friday Extravaganza', '2024-11-29', '2024-11-29', 500000.00, NULL, 20.00, 1, 'BLACKFRIDAY20'),
    (9, 'Cyber Monday Special', '2024-12-01', '2024-12-01', 400000.00, 50000.00, NULL, 0, 'CYBERMONDAY50'),
    (10, 'Christmas Countdown', '2024-12-01', '2024-12-24', 250000.00, NULL, 10.00, 1, 'XMAS10'),
    (11, 'End of Year Sale', '2024-12-26', '2024-12-31', 150000.00, 15000.00, NULL, 0, 'YEAREND15'),
    (12, 'Back to School', '2024-08-01', '2024-08-31', 120000.00, NULL, 8.00, 1, 'BACK2SCHOOL8'),
    (13, 'Labor Day Discount', '2024-05-01', '2024-05-01', 100000.00, 10000.00, NULL, 0, 'LABORDAY10'),
    (14, 'Mother’s Day Tribute', '2024-05-08', '2024-05-08', 200000.00, NULL, 15.00, 1, 'MOTHERSDAY15'),
    (15, 'Father’s Day Offer', '2024-06-15', '2024-06-15', 200000.00, 25000.00, NULL, 0, 'FATHERSDAY25');

alter sequence voucher_session_id_seq restart with 17;

-- Insert sample data for VOUCHER_SHOP with code field
INSERT INTO VOUCHER_SHOP (id, name, start_date, end_date, min_value, discount_amount, discount_percentage, voucher_type, code)
VALUES
    (1, 'Shop Anniversary', '2024-11-01', '2024-12-30', 15000.00, 20000.00, NULL, 0, 'ANNIV20'),
    (2, 'Flash Sale', '2024-04-01', '2024-04-07', 75000.00, NULL, 5.00, 1, 'FLASH5'),
    (3, 'VIP Member Discount', '2024-05-01', '2024-05-31', 300000.00, 50000.00, NULL, 0, 'VIP50'),
    (4, 'Golden Weekend', '2024-07-01', '2024-07-03', 100000.00, NULL, 8.00, 1, 'GOLDEN8'),
    (5, 'Festival Fever', '2024-09-01', '2024-09-10', 50000.00, 7000.00, NULL, 0, 'FEST7'),
    (6, 'Holiday Countdown', '2024-12-01', '2024-12-15', 250000.00, NULL, 12.00, 1, 'HOLIDAY12'),
    (7, 'New Year Shop Treat', '2024-01-02', '2024-01-08', 100000.00, 15000.00, NULL, 0, 'NY2024TREAT'),
    (8, 'Clearance Deal', '2024-03-20', '2024-03-25', 200000.00, NULL, 10.00, 1, 'CLEARANCE10'),
    (9, 'Lucky Day Offer', '2024-03-18', '2024-03-18', 80000.00, 10000.00, NULL, 0, 'LUCKYDAY10'),
    (10, 'Early Bird Discount', '2024-06-01', '2024-06-03', 60000.00, NULL, 5.00, 1, 'EARLYBIRD5'),
    (11, 'Mega Sale Madness', '2024-07-10', '2024-07-20', 350000.00, 45000.00, NULL, 0, 'MEGASALE45'),
    (12, 'Exclusive Offer', '2024-08-05', '2024-08-10', 300000.00, NULL, 10.00, 1, 'EXCLUSIVE10'),
    (13, 'Birthday Bash', '2024-09-15', '2024-09-15', 120000.00, 15000.00, NULL, 0, 'BIRTHDAY15'),
    (14, 'End of Season Sale', '2024-10-01', '2024-10-07', 70000.00, NULL, 7.00, 1, 'SEASONEND7'),
    (15, 'Happy Hour', '2024-11-11', '2024-11-11', 50000.00, 10000.00, NULL, 0, 'HAPPYHOUR10'),
    (16, 'Weekend Special', '2024-12-20', '2024-12-22', 150000.00, NULL, 8.00, 1, 'WEEKEND8');
alter sequence voucher_shop_id_seq restart with 17;

drop table if exists sales_order_voucher_shop;
create table sales_order_voucher_shop
(
    id              bigserial primary key,
    sale_order_id   bigint not null references sales_order (id),
    voucher_id      bigint not null references VOUCHER_SHOP (id),
    discount_amount DECIMAL(10, 2)
);

insert into sales_order_voucher_shop (id, sale_order_id, voucher_id, discount_amount)
values
    (1, 1, 1, 20000.00),
    (2, 2, 1, 20000.00),
    (3, 3, 1, 20000.00),
    (4, 4, 2, 8000.00);

alter sequence sales_order_voucher_shop_id_seq restart with 11;

drop table if exists sales_order_voucher_session;
create table sales_order_voucher_session
(
    id              bigserial primary key,
    sale_order_id   bigint not null references sales_order (id),
    voucher_id      bigint not null references VOUCHER_SESSION (id),
    discount_amount DECIMAL(10, 2)
);

insert into sales_order_voucher_session (id, sale_order_id, voucher_id, discount_amount)
values
    (1, 1, 1, 20000.00),
    (2, 2, 1, 20000.00),
    (3, 3, 1, 20000.00),
    (4, 5, 2, 26800.00);

alter sequence sales_order_voucher_session_id_seq restart with 11;