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

------ 10-4 ------
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
)


