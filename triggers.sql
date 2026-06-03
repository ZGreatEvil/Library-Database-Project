USE [library]

GO
CREATE TRIGGER reduce_user_quota_and_book_stock_trigger
ON reserve_borrow
AFTER INSERT
AS
BEGIN
    UPDATE ua
    SET ua.user_kuota = ua.user_kuota - 1
    FROM user_availability ua
    INNER JOIN inserted i ON ua.user_id = i.user_id;

    UPDATE ba
    SET ba.book_stock = ba.book_stock - 1
    FROM book_availability ba
    INNER JOIN inserted i ON ba.book_id = i.book_id;
END;
GO

GO
CREATE TRIGGER increase_user_quota_and_book_stock_trigger
ON return_book
AFTER INSERT
AS
BEGIN
    UPDATE ua
    SET ua.user_kuota = ua.user_kuota + 1
    FROM user_availability ua
    INNER JOIN inserted i ON ua.user_id = i.user_id;

    UPDATE ba
    SET ba.book_stock = ba.book_stock + 1
    FROM book_availability ba
    INNER JOIN inserted i ON ba.book_id = i.book_id;
END;
GO
