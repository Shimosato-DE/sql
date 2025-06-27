------ 10-1 ------
--家計簿テーブルを作成する
------------------

CREATE TABLE 家計簿 (

    日付 DATE,
    費目ID INTEGER,
    メモ VARCHAR(255),
    入金額 INTEGER,
    出金額 INTEGER
);

------ 10-2 ------
--家計簿テーブルに対する行の追加
------------------

INSERT INTO 家計簿(日付, メモ, 出金額)
VALUES('2024-04-12', '詳細は後で', 60000)
--特に指定しない場合NULL

------ 10-3 ------
--家計簿テーブルを作成する(DEFAULT値を活用)
------------------

CREATE TABLE 家計簿 (

    日付 DATE,
    費目ID INTEGER,
    メモ VARCHAR(255) DEFAULT '不明',
    入金額 INTEGER DEFAULT 0,
    出金額 INTEGER DEFAULT 0
);

------ 10-4 ------
--列の追加と削除
------------------

ALTER TABLE 家計簿 ADD 関連日 DATE;
ALTER TABLE 家計簿 DROP 関連備;

------ 10-5 ------
--基本的な3つの制約
------------------

CREATE TABLE 家計簿 (

    日付 DATE NOT NULL,
    費目ID INTEGER,
    メモ VARCHAR(255) DEFAULT '不明' NOT NULL,
    入金額 INTEGER DEFAULT 0 CHECK(入金額 >= 0),
    出金額 INTEGER DEFAULT 0 CHECK(入金額 >= 0),
);

CREATE TABLE 費目 (
    ID INTEGER,
    名前 VARCHAR(50) UNIQUE
);


------ 10-6 ------
--デフォルト値の利用
------------------
--メモを明示的に指定してINSERT→家賃が入ってしまう
INSERT INTO 家計簿 (日付, 費目ID, メモ, 入金額, 出金額)
VALUES ('2024-04-04', 2, '家賃', 0, 60000);

--メモを省略してINSERT→'不明が入る'
INSERT INTO 家計簿 (日付, 費目ID, 入金額, 出金額)
VALUES ('2024-04-05', 3, 0, 1350);


------ 10-7 ------
--主キー制約の指定(単独列)
------------------
CREATE TABLE 費目 (
    ID INTEGER PRIMARY KEY,
    名前 VARCHAR(40) UNIQUE
);

------ 10-8 ------
--主キー制約の指定(複合主キー)
------------------
CREATE TABLE 費目 (
    ID INTEGER,
    名前 VARCHAR(50);
    PRIMARY KEY(ID, 名前)
);


------ 10-9 ------
--参照整合性を崩す 4つの操作
------------------
--家計簿テーブルで参照中の費目テーブルを削除
DELETE FROM 費目 WHERE ID = 2;

--家計簿テーブルで参照中の費目テーブルIDの変更
UPDATE 費目 SET ID = 5 WHERE = 1;

--費目テーブルで存在しない費目を指定して、家計簿テーブルに行を追加
INSERT INTO 家計簿
(日付, 費目ID, 入金額, 出金額)
VALUES ('2024-04-06', 99, 0, 800);

--費目テーブルに存在しない費目を指定して、家計簿テーブルの行を更新
UPDATE 家計簿 SET 費目ID = 99 WHERE 日付 = '2024-04-06';


------ 10-10 ------
--外部キー制約の指定
------------------
CREATE TABLE 家計簿 (
    日付 DATE NOT NULL,
    費目ID INTEGER REFERENCES 費目(ID),
    メモ VARCHAR(255) DEFAULT '不明' NOT NULL,
    入金額 INTEGER NOT NULL CHECK(入金額 >= 0),
    出金額 INTEGER NOT NULL CHECK(出金額 >= 0)
);

--FOREIGN KEY 費目ID REFERENCES 費目(ID)と記載もできる