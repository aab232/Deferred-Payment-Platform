// creating express server
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 5000;

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

// connection error handling
db.connect((err) => {
    if (err) {
        console.error('DB connection failed:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});


// user registration
app.post('/register', (req, res) => {
    console.log(req.body);  // This will log the request body to the console to verify it's being sent properly

    const { email, password, name } = req.body;

    // hash the password before saving to database
    const hashedPassword = bcrypt.hashSync(password, 10);  // Hash password with a salt of 10 rounds

    if (!email || !password || !name) {
        return res.status(400).json({ message: "Please provide all fields" });
    }

    // check if email already exists
    db.query('SELECT * FROM users WHERE email = ?', [email], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Database error' });
        }

        if (result.length > 0) {
            return res.status(400).json({ message: 'Email already registered' });
        }

        // hash the password
        const hashedPassword = bcrypt.hashSync(password, 10);

        // insert new user into the database
        const query = 'INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)';
        db.query(query, [name, email, hashedPassword], (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).json({ message: 'Error saving user' });
            }
            res.status(201).json({ message: 'User registered successfully' });
        });
    });
});



// user login
const jwt = require('jsonwebtoken');

app.post('/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: "Please provide email and password" });
    }

    // check if the user exists
    db.query('SELECT * FROM users WHERE email = ?', [email], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Database error' });
        }

        if (result.length === 0) {
            return res.status(400).json({ message: 'User not found' });
        }

        // compare password with the hashed password
        const user = result[0];
        const isMatch = bcrypt.compareSync(password, user.password_hash);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid password' });
        }

        // generate JWT token
        const token = jwt.sign({ userId: user.id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '1h' });

        res.json({ message: 'Login successful', token });
    });
});

// middleware protection
const authenticateToken = require('./authMiddleware');

app.get('/profile', authenticateToken, (req, res) => {
    const userId = req.user.userId;

    db.query('SELECT * FROM users WHERE id = ?', [userId], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Database error' });
        }

        res.json(result[0]);
    });
});