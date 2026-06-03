USE [library]

CREATE TABLE book_data(
    book_id INT NOT NULL, 
    book_title VARCHAR(50) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    author_id INT,
    PRIMARY KEY(book_id)
);

CREATE TABLE author_data( 
    author_id INT NOT NULL, 
    author_name VARCHAR(50) NOT NULL,
    author_birthdate DATE NOT NULL,
    PRIMARY KEY(author_id)
);

ALTER TABLE book_data
ADD FOREIGN KEY(author_id)
REFERENCES author_data(author_id)
ON DELETE SET NULL;

CREATE TABLE user_data(
    user_id INT NOT NULL, 
    user_name VARCHAR(50) NOT NULL,
    user_address VARCHAR(200) NOT NULL,
	user_phone INT NOT NULL,
    PRIMARY KEY(user_id)
);

CREATE TABLE book_availability(
    book_id INT NOT NULL,
    book_stock INT NOT NULL,
    book_shelf VARCHAR(10) NOT NULL,
    FOREIGN KEY(book_id) REFERENCES book_data(book_id) ON DELETE CASCADE,
    PRIMARY KEY(book_id)
);

CREATE TABLE user_availability(
    user_id INT NOT NULL,
    user_kuota INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES user_data(user_id) ON DELETE CASCADE,
    PRIMARY KEY(user_id)
);

CREATE TABLE reserve_borrow(
    borrow_id INT , 
    book_id INT,
    user_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY(user_id) REFERENCES user_data(user_id) ON DELETE CASCADE,
    FOREIGN KEY(book_id) REFERENCES book_data(book_id) ON DELETE SET NULL,
    PRIMARY KEY(borrow_id)
);

CREATE TABLE return_book(
    borrow_id INT,
	book_id INT,
    user_id INT,
    return_date DATE NOT NULL,
    late_fee INT,
    FOREIGN KEY(user_id) REFERENCES user_data(user_id) ON DELETE CASCADE,
    FOREIGN KEY(book_id) REFERENCES book_data(book_id) ON DELETE SET NULL,
    FOREIGN KEY(borrow_id) REFERENCES reserve_borrow(borrow_id) ON DELETE NO ACTION,
    PRIMARY KEY(borrow_id)
);

SET SHOWPLAN_ALL ON;
GO
SELECT * FROM return_book;
GO
SET SHOWPLAN_ALL OFF;

