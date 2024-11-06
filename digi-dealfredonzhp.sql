CREATE TABLE auths (
    auth_id BIGSERIAL PRIMARY KEY,
    account_id BIGINT UNIQUE NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE accounts (
    account_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    balance BIGINT NOT NULL,
    referral_account_id BIGINT NULL,
    FOREIGN KEY (referral_account_id) REFERENCES accounts(account_id)
);

CREATE TABLE transaction_categories (
    transaction_category_id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE transactions (
    transaction_id BIGSERIAL PRIMARY KEY,
    transaction_category_id BIGINT NULL,
    account_id BIGINT NOT NULL,
    from_account_id BIGINT NULL,
    to_account_id BIGINT NULL,
    amount BIGINT NOT NULL,
    transaction_date TIMESTAMP NOT NULL,
    FOREIGN KEY (transaction_category_id) REFERENCES transaction_categories(transaction_category_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (from_account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (to_account_id) REFERENCES accounts(account_id)
);

INSERT INTO accounts (name, balance, referral_account_id)
VALUES
    ('John Doe', 1000000, NULL),
    ('Jane Smith', 500000, NULL),
    ('Robert Brown', 300000, 1),
    ('Alice Johnson', 1500000, 2),
    ('Charlie Davis', 750000, 3);

INSERT INTO transaction_categories (name)
VALUES
    ('Deposit'),
    ('Withdrawal');

INSERT INTO transactions (transaction_category_id, account_id, from_account_id, to_account_id, amount, transaction_date)
VALUES
    (1, 1, NULL, 1, 10000, '2024-01-01 00:00:00'),
    (2, 2, 2, NULL, 5000, '2024-02-01 00:00:00'),
    (1, 3, NULL, 3, 20000, '2024-03-01 00:00:00'),
    (2, 4, 4, NULL, 15000, '2024-04-01 00:00:00'),
    (1, 5, NULL, 5, 30000, '2024-05-01 00:00:00'),
    (2, 1, 1, NULL, 8000, '2024-06-01 00:00:00'),
    (1, 2, NULL, 2, 12000, '2024-07-01 00:00:00'),
    (2, 3, 3, NULL, 25000, '2024-08-01 00:00:00'),
    (1, 4, NULL, 4, 18000, '2024-09-01 00:00:00'),
    (2, 5, 5, NULL, 9000, '2024-10-01 00:00:00'),
    (1, 1, NULL, 1, 22000, '2024-11-01 00:00:00'),
    (2, 2, 2, NULL, 11000, '2024-12-01 00:00:00');

UPDATE accounts
SET name = 'Johnathan Doe'
WHERE account_id = 1;

UPDATE accounts
SET balance = 2000000  
WHERE account_id = 2;

SELECT * FROM accounts;

SELECT t.transaction_id, t.transaction_category_id, t.account_id, a.name AS account_name, t.amount, t.transaction_date
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id;

SELECT * FROM accounts
ORDER BY balance DESC
LIMIT 1;

SELECT * FROM transactions
WHERE EXTRACT(MONTH FROM transaction_date) = 5;
