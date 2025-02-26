CREATE TABLE credit_assessments (
    id INT PRIMARY KEY AUTO_INCREMENT,               -- Unique assessment record ID
    user_id INT,                                    -- User ID (Foreign Key)
    credit_score INT,                               -- User's credit score (calculated)
    assessment_decision VARCHAR(50),                 -- Approved/Declined/Review
    income DECIMAL(10,2),                           -- User's income (for assessment)
    credit_utilization DECIMAL(5,2),                -- Credit utilization ratio
    loan_term INT,                                  -- Loan term (in months)
    loan_amount DECIMAL(10,2),                      -- Requested loan amount
    loan_to_income_ratio DECIMAL(5,2),              -- Loan to income ratio
    assessment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when assessment was made
    FOREIGN KEY (user_id) REFERENCES users(id)      -- Reference to the users table
);
