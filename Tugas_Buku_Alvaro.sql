CREATE TYPE account_status AS ENUM ('active', 'inactive', 'suspended');

CREATE TABLE example_table (
    -- Exact Numeric Types
    id INTEGER PRIMARY KEY,
    small_value SMALLINT,
    large_value BIGINT,
    precise_value NUMERIC(10, 2),
    another_precise_value DECIMAL(15, 4),

    -- Approximate Numeric Types
    real_value REAL,
    float_value FLOAT(8),
    double_precision_value DOUBLE PRECISION,

    -- String Types
    fixed_char_value CHAR(10),
    varying_char_value VARCHAR(100),
    large_char_object TEXT,  -- Replaced CLOB with TEXT

    -- Date and Time Types
    date_of_birth DATE,
    time_of_event TIME,
    event_timestamp TIMESTAMP,
    full_datetime TIMESTAMP, -- PostgreSQL uses TIMESTAMP instead of DATETIME

    -- Boolean Type
    is_active BOOLEAN,

    -- User-Defined Enum Type
    status account_status
);

CREATE DOMAIN USDollar AS DECIMAL(9, 2)
    CHECK (VALUE >= 0);

CREATE DOMAIN UKPound AS DECIMAL(9, 2)
    CHECK (VALUE >= 0);

CREATE TABLE AmericaInvoice(
InvoiceID INTEGER PRIMARY KEY,
CustomerID INTEGER,
OrderID INTEGER,
TotalSaleAmt USDollar,
ShippingFee USDollar
);

CREATE TABLE UnitedKingdomInvoice(
InvoiceID INTEGER PRIMARY KEY,
CustomerID INTEGER,
OrderID INTEGER,
TotalSaleAmt USDollar,
ShippingFee USDollar
);

CREATE TABLE Customer_TBL(
CustomerID INTEGER NOT NULL PRIMARY KEY,
CustomerName VARCHAR NOT NULL,
JobPosition VARCHAR,
CompanyName VARCHAR NOT NULL,
USState VARCHAR NOT NULL,
ContactNo BIGINT NOT NULL
);

ALTER TABLE Customer_TBL ADD
CompanyAdd VARCHAR;

DROP TABLE Customer_TBL;

INSERT INTO Customer_TBL (CustomerID, CustomerName, JobPosition, CompanyName, USState, ContactNo)
VALUES (1, 'Kathy Ale', 'President', 'Tile Industrial', 'TX', 3461234567);

INSERT INTO Customer_TBL
VALUES (2, 'Kevin Lord', 'VP', 'Best Tooling', 'NY', 5181234567);

INSERT INTO Customer_TBL
VALUES
(3, 'Kim Ash', 'Director', 'Car World', 'CA', 5101234567),
(4, 'Abby Karr', 'Manager', 'West Mart', 'NV', 7751234567);

INSERT INTO Customer_TBL (CustomerID, CustomerName, CompanyName, USState, ContactNo)
VALUES (5, 'Mike Armhs', '1 Driving School', 'NJ', 2011234567);

UPDATE Customer_TBL
SET JobPosition = 'VP'
WHERE CustomerName = 'Mike Armhs';

UPDATE Customer_TBL
SET JobPosition = 'Vice-President'
WHERE JobPosition = 'VP';

UPDATE Customer_TBL
SET CustomerName = UPPER(CustomerName);

DELETE FROM Customer_TBL
WHERE CustomerName = 'Kathy Ale';

DELETE FROM Customer_TBL
WHERE JobPosition = 'Vice-President';

DELETE FROM Customer_TBL;

SELECT * FROM Customer_TBL;

SELECT *
FROM Customer_TBL
WHERE JobPosition = 'Vice-President';

SELECT CustomerName, CompanyName
FROM Customer_TBL
WHERE JobPosition = 'Vice-President';

SELECT *
FROM Customer_TBL
ORDER BY USState;

SELECT *
FROM Customer_TBL
ORDER BY USState DESC;

SELECT JobPosition, COUNT(*) AS number_of_record FROM Customer_TBL
GROUP BY JobPosition;

SELECT JobPosition, COUNT(*) AS number_of_record FROM Customer_TBL
GROUP BY JobPosition
ORDER BY JobPosition DESC;