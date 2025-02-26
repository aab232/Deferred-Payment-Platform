USE dpp_db;

CREATE TABLE credit_data (
    id INT PRIMARY KEY AUTO_INCREMENT,   -- Unique identifier for each row
    employment_status VARCHAR(3),        -- Yes/No values (VARCHAR to store 'Yes' or 'No')
    person_income DECIMAL(10,2),         -- Income with 2 decimal places
    credit_utilization_ratio DECIMAL(5,2), -- Ratio with 2 decimal places
    payment_history DECIMAL(10,2),       -- Payment history (e.g., amounts like 2685.0)
    loan_term DECIMAL(5,2),              -- Loan term (e.g., 48.0 months)
    loan_amount DECIMAL(10,2),           -- Loan amount (e.g., 35000.00)
    loan_percent_income DECIMAL(5,2)    -- Loan-to-income ratio (e.g., 0.59)
);

ALTER TABLE credit_data
ADD COLUMN buffer_bag_balance DECIMAL (10,2) DEFAULT 0.00;