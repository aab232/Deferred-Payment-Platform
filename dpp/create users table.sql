CREATE TABLE users ( 
    id INT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR (255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NULL,
    national_insurance_number VARCHAR(20),
    credit_score INT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);