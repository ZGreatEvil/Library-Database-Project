# Library Database Project

A relational database for managing a library system, built with Microsoft SQL Server. Covers book and user management, borrowing and returns, automated stock tracking via triggers, table partitioning, and query plan analysis.

---

## Table of Contents

- [About](#about)
- [Database Schema](#database-schema)
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [How to Run](#how-to-run)
- [Documentation](#documentation)
- [License](#license)

---

## About

This is a database technology (DBT) academic project implementing a library management system in Microsoft SQL Server. The database handles books, authors, users, borrowing transactions, and returns, with automated triggers to keep stock and user quotas in sync.

---

## Database Schema

The database (`library`) consists of six tables:

| Table | Description |
|---|---|
| `book_data` | Book records — title, ISBN, and author reference |
| `author_data` | Author records — name and birthdate |
| `user_data` | Library member records — name, address, phone |
| `book_availability` | Stock count and shelf location per book |
| `user_availability` | Remaining borrow quota per user |
| `reserve_borrow` | Active borrow transactions — loan and due dates |
| `return_book` | Return records — return date and late fee |

The ERD is available in [`final erd.pdf`](./final%20erd.pdf).

---

## Features

**Triggers** — Two triggers on `reserve_borrow` and `return_book` automatically update stock and user quota:
- On borrow: decrements `book_stock` and `user_kuota`
- On return: increments both back

**Partitioning** — Table partitioning is implemented in `partition.sql` for query performance on large datasets.

**Query Plan Analysis** — `plan_cache.sql` and the `SET SHOWPLAN_ALL` block in `main_code.sql` are used to inspect and analyse SQL Server execution plans.

**Sample Data** — `insert_data.sql` seeds the database with test records.

**Database Export** — `library.bacpac` is a portable SQL Server backup that can be imported directly into SQL Server or Azure SQL.

---

## Project Structure

```
Library-Database-Project/
├── main_code.sql              # Table definitions and schema setup
├── insert_data.sql            # Sample data inserts
├── triggers.sql               # Borrow/return automation triggers
├── partition.sql              # Table partitioning setup
├── plan_cache.sql             # Query plan cache analysis
├── documentation_proofs.sql   # SQL proofs for documentation
├── library.bacpac             # SQL Server database export
├── final erd.pdf              # Entity-Relationship Diagram
├── Clara Jessica-...-DBT Project Documentation.docx  # Full project report
└── LICENSE
```

---

## Getting Started

### Prerequisites

- Microsoft SQL Server (2016 or later recommended)
- SQL Server Management Studio (SSMS)

---

## How to Run

### Option A — Import the .bacpac

1. Open SSMS and connect to your SQL Server instance.
2. Right-click **Databases** > **Import Data-tier Application**.
3. Select `library.bacpac` and follow the prompts.

### Option B — Run scripts manually

Execute the SQL files in this order:

```
1. main_code.sql       -- create all tables
2. insert_data.sql     -- populate with sample data
3. triggers.sql        -- create borrow/return triggers
4. partition.sql       -- apply partitioning (optional)
5. plan_cache.sql      -- run query plan analysis (optional)
```

---

## Documentation

- ERD: [`final erd.pdf`](./final%20erd.pdf)
- Full written report: `Clara Jessica-2702267520-Computer Science (Global Class)-DBT Project Documentation.docx`

---

## License

This project is licensed under the [MIT License](./LICENSE).
