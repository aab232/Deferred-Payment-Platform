CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,                -- Unique transaction ID
    user_id INT,                                      -- User ID (Foreign Key)
    transaction_type VARCHAR(50),                      -- Type: "Purchase", "Payment", "Buffer Deposit", "Buffer Withdrawal"
    amount DECIMAL(10,2),                              -- Amount of the transaction
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of when transaction occurred
    transaction_status VARCHAR(50),                    -- Status of the transaction: "Completed", "Pending", "Failed"
    description TEXT,                                  -- Description or reference for the transaction (e.g., store name, loan details, buffer deposit/withdrawal)
    is_buffer_transaction BOOLEAN DEFAULT FALSE,       -- Indicates if this transaction is related to the buffer bag (TRUE/FALSE)
    FOREIGN KEY (user_id) REFERENCES users(id)        -- Reference to the users table
);