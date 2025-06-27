------ 12-1 ------
--家計管理DBのDDL
------------------

--テーブル作成
CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    account_name VARCHAR(30) NOT NULL
);

CREATE TABLE expenses (
    expense_id CHAR(3) PRIMARY KEY,
    expense_name VARCHAR(30) NOT NULL UNIQUE,
    category CHAR(1) NOT NULL CHECK(category IN('I', 'O'))
);

CREATE TABLE transactions (
    transaction_id CHAR(5) PRIMARY KEY,
    transaction_date DATE NOT NULL,
    account_id INTEGER NOT NULL REFERENCES accounts(account_id),
    note VARCHAR(100)
);

CREATE TABLE transaction_item (
    transaction_id VARCHAR(5) NOT NULL REFERENCES transactions(transaction_id),
    expense_id CHAR(3) NOT NULL REFERENCES expenses(expense_id),
    amount INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY(transaction_id, expense_id)
);

CREATE TABLE tags (
    tag_id INTEGER PRIMARY KEY,
    note VARCHAR(100),
    author_id INTEGER NOT NULL REFERENCES accounts(account_id)
);

CREATE TABLE taggings (
    tag_id INTEGER NOT NULL REFERENCES tags(tag_id),
    transaction_id CHAR(5) NOT NULL REFERENCES transactions(transaction_id),
    PRIMARY KEY(tag_id, transaction_id)
);

--インデックスの作成
CREATE INDEX idx_accounts_account_name
ON accounts(account_name);

CREATE INDEX idx_expenses_expense_name
ON expenses(expense_name);

CREATE INDEX idx_transactions_transaction_date
ON transactions(transaction_date);

CREATE INDEX idx_tramsactions_account_id
ON transactions(transaction_id);

CREATE INDEX idx_transaction_items_expense_id
ON transaction_items(expense_id);

CREATE INDEX idx_transaction_items_amount
ON transaction_items(amount);

CREATE INDEX idx_tags_author_id
ON tags(author_id);


------ 12-2 ------
--利用者を追加する
------------------

INSERT INTO accounts
VALUES(1, '立花いずみ')


------ 12-3 ------
--集計を表示する
------------------

SELECT U.account_name AS 利用者名, H.expense_name AS 費目名, s.total AS 合計名
FROM(
    SELECT K.account_id, M.expense_id, SUM(M.amount) AS total
    FROM transaction_items AS M
    JOIN expense
    ON M.expense_id = H.expense_id
    JOIN transation_item AS K
    ON M.transaction_id = K.transaction_id
    GROUP BY K.account_id, M.expense_id) AS S

JOIN account AS U
ON S.account_id = U.account_id
JOIN expense AS H
ON S.expense_id = H.expense_id