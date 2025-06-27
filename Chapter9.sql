------ 9-1 ------
--1月のデータをアーカイブテーブルに移動する
-----------------

BEGIN;

--処理1:アーカイブテーブルへコピー
INSERT INTO 家計簿アーカイブ
SELECT * FROM 家計簿
WHERE 日付 <= '2024-01-31';

--処理2:家計簿テーブルから削除
DELETE
FROM 家計簿
WHERE 日付 <= '2024-01-31';

COMMIT;


------ 9-2 ------
--SERIALIZABLE分離レベルを選択する
-----------------

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


------ 9-3 ------
--2月以降の行をロックして集計する
-----------------

BEGIN;

SELECT * FROM 家計簿
WHERE 日付 >= "2024-02-01"
FOR UPDATE;

--集計処理1
SELECT ;
--集計処理2
SELECT ;
--集計処理3
SELECT ;

COMMIT;

------ 9-4 ------
--家計簿テーブルをロックして集計する
-----------------

BEGIN;

LOCK TABLE 家計簿 IN EXCLUSIVE MODE;

--集計処理1
SELECT ;
--集計処理2
SELECT ;
--集計処理3
SELECT ;

COMMIT;
