USE [library]

INSERT INTO user_data (user_id, user_name, user_address, user_phone) VALUES ('9999', 'Clara Jessica', 'Pacific Garden', '123456789');

INSERT INTO user_availability (user_id, user_kuota) VALUES ('9999', '1');

SELECT *
FROM user_data u
JOIN user_availability ua ON u.user_id = ua.user_id
WHERE u.user_id = 9999;

SELECT * FROM book_availability
WHERE book_id = '2331';

INSERT INTO reserve_borrow (borrow_id, book_id, user_id, loan_date, due_date) VALUES ('1234', '2331', '9999', '10/14/2024', '12/14/2024');

SELECT * FROM reserve_borrow
WHERE borrow_id = '1234';

SELECT *
FROM book_data b
JOIN book_availability ba ON b.book_id = ba.book_id
WHERE b.book_id = 2331;

SELECT * FROM reserve_borrow
WHERE user_id = '9999';

INSERT INTO return_book(borrow_id, book_id, user_id, return_date, late_fee) VALUES ('1234', '2331', '9999', '10/20/2024', '0');

SELECT *
FROM book_data b
JOIN book_availability ba ON b.book_id = ba.book_id
WHERE b.book_id = 5731;

SELECT *
FROM user_data u
JOIN user_availability ua ON u.user_id = ua.user_id
WHERE u.user_id = '2617';

INSERT INTO reserve_borrow (borrow_id, book_id, user_id, loan_date, due_date) VALUES ('2345', '5731', '2617', '10/14/2024', '12/14/2024');

SELECT * FROM reserve_borrow
WHERE user_id = '2617';

INSERT INTO reserve_borrow (borrow_id, book_id, user_id, loan_date, due_date) VALUES ('4567', '5731', '9999', '12/14/2024', '2/14/2025');

INSERT INTO author_data (author_id, author_name, author_birthdate) VALUES ('2345', 'Anna Tod', '03/20/1989');

SELECT * FROM author_data
WHERE author_id = '2345';

INSERT INTO book_data (book_id, book_title, isbn, author_id) VALUES ('4567', 'After', '978-3-4534-9116-8', '2345');

SELECT * FROM book_data
WHERE book_id = '4567';

INSERT INTO book_availability (book_id, book_stock, book_shelf) VALUES ('6666', '5', 'A7');

SELECT *
FROM book_data b
JOIN book_availability ba ON b.book_id = ba.book_id
WHERE b.book_id = '6666';

SELECT * FROM return_book
WHERE user_id = '9999';

SELECT * FROM reserve_borrow
WHERE user_id = '9999';

DELETE FROM reserve_borrow
WHERE borrow_id = '4567';

SELECT * FROM reserve_borrow
WHERE user_id = '9999';

DELETE FROM user_availability
WHERE user_id = '9999';

DELETE FROM user_data
WHERE user_id = '9999';

SELECT rb.*
FROM reserve_borrow rb
JOIN user_data ud ON rb.user_id = ud.user_id
WHERE ud.user_name LIKE '%DDS%';

SELECT rb.*
FROM reserve_borrow rb
JOIN user_data ud ON rb.user_id = ud.user_id
WHERE ud.user_address LIKE '%New%';

