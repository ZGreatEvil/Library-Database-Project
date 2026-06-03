USE [library]
GO

CREATE PARTITION FUNCTION yearly_borrowing_partition (DATE)
AS RANGE LEFT FOR VALUES ('2022-01-01', '2023-01-01', '2024-01-01');

CREATE PARTITION SCHEME yearly_borrowing_scheme
AS PARTITION yearly_borrowing_partition
TO (borrowing_before_2022, borrowing_in_2022, borrowing_in_2023, borrowing_after_2023);

BEGIN TRANSACTION
ALTER TABLE [dbo].[return_book] DROP CONSTRAINT [FK__return_bo__borro__66603565]


ALTER TABLE [dbo].[reserve_borrow] DROP CONSTRAINT [PK__reserve___262B57A05EC329DB] WITH ( ONLINE = OFF )


ALTER TABLE [dbo].[reserve_borrow] ADD PRIMARY KEY NONCLUSTERED 
(
	[borrow_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [transaction_file]


CREATE CLUSTERED INDEX [ClusteredIndex_on_yearly_borrowing_scheme_638640246553947084] ON [dbo].[reserve_borrow]
(
	[loan_date]
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [yearly_borrowing_scheme]([loan_date])


DROP INDEX [ClusteredIndex_on_yearly_borrowing_scheme_638640246553947084] ON [dbo].[reserve_borrow]




ALTER TABLE [dbo].[return_book]  WITH CHECK ADD FOREIGN KEY([borrow_id])
REFERENCES [dbo].[reserve_borrow] ([borrow_id])






COMMIT TRANSACTION

SELECT *
FROM [dbo].[reserve_borrow]
WHERE $PARTITION.yearly_borrowing_partition(loan_date) = 4;

