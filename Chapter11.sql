------ 11-1 ------
--家計簿テーブルにインデックスを2つ作る
------------------
CREATE INDEX 費目IDインデックス ON 家計簿(費目ID);
CREATE INDEX メモインデックス ON 家計簿(メモ);

------ 11-2 ------
--インデックス列をWHERE句に指定(完全一致検索)
------------------
SELECT * FROM 家計簿
WHERE メモ = '不明'

------ 11-3 ------
--インデックス列をWHERE句に指定(前方一致検索)
------------------
SELECT * FROM 家計簿
WHERE メモ LIKE "1月の%"

------ 11-4 ------
--ORDER BY による並び替え
------------------
SELECT * FROM 家計簿
ORDER BY 費目ID

------ 11-5 ------
--インデックス列をJOINの結合条件に指定
------------------
SELECT * FROM 家計簿
JOIN 費目
ON 家計簿.費目ID = 費目.ID

------ 11-6 ------
--4月の家計簿に関する様々なSELECT文の実行
------------------
SELECT * FROM 家計簿
WHERE 日付 >= '2024-04-01'
AND 日付 <= '2024-04-30'
SELECT DISTINCT 費目ID FROM 家計簿
WHERE 日付 >= '2024-04-01'
AND 日付 <= '2024-04-30'

--日付指定が重複している

------ 11-7 ------
--4月の家計簿データのみを持つビューを定義
------------------
CREATE VIEW 家計簿4月 AS
SELECT * FROM 家計簿
WHERE 日付 >= '2024-04-01'
AND 日付 <= '2024-04-30'

------ 11-8 ------
--家計簿4月ビューを使ったSELECT文の実行
------------------
SELECT * FROM 家計簿4月;


------ 11-9 ------
--連番の指定の例
------------------
--宣言に修飾する
CREATE TABLE 費目 (
    ID INTEGER GENERATED AS IDENTITY PRIMARY KEY,
    名前 VARCHAR(50)
);

--型を利用する
CREATE TABLE 費目 (
    ID SERIAL PRIMARY KEY,
    名前 VARCHAR(50)
);


------ 11-10 ------
--OracleDBにおけるシーケンスの作成と取得
------------------
CREATE SEQUENCE 費目シーケンス;

--次の値に進み、その値を取得
SELECT 費目シーケンス.NEXTVAL FROM DUAL;

--現在の値を取得
SELECT 費目シーケンス.CURRVAL FROM DUAL;



------ 11-11 ------
--Db2 におけるシーケンスの作成と取得
------------------
CREATE SEQUENCE 費目シーケンス;

--次の値に進み、その値を取得
SELECT NEXTVAL FOR 費目シーケンス FROM SYSIBM.SYSBUMMY1;
--現在の値を取得
SELECT PREVVAL FOR 費目シーケンス FROM SYSIBM.SYSBUMMY1;


------ 11-12 ------
--PostgreSQL におけるシーケンスの作成と取得
------------------
CREATE SEQUENCE 費目シーケンス;
--次の値に進み、その値を取得
SELECT NEXTVAL('費目シーケンス');
--現在の値を取得
SELECT CURRVAL('費目シーケンス');

------ 11-13 ------
--PostgreSQL における費目行の追加
------------------
INSERT INTO 費目 (ID, 名前)
VALUES ((SELECT NEXTVAL('費目シーケンス')), '接待交際費')