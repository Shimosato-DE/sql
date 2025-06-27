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


------ まとめ ------

-----------------
--家賃60000円の振り込みと同時に、手数料420円の支払いを記録
-----------------
BEGIN;

INSERT INTO 家計簿
VALUES('2024-03-20', '住居費', '4月の家賃' 0, 60000)
INSERT INTO 家計簿
VALUES('2024-03-20', '手数料', '4月の家賃の振り込み', 0, 420)

COMMIT;


-----------------
--3月20日のデータを削除したけど、なかったことにしたい
-----------------

BEGIN;

DELETE
FROM 家計簿
WHERE 日付 ='2024-03-20'

ROLLBACK;

-----------------
--処理中、他の人の操作で家計簿テーブルの内容が変化しないようにしながら、各種統計を記録する。
-----------------

BEGIN;

LOCK TABLE 家計簿 IN EXCLUSIVE MODE;

INSERT INTO 統計結果
SELECT 'データ件数', COUNT(*)
FROM 家計簿

INSERT INTO 統計結果
SELECT "出金平均金額", AVG(出金額)
FROM 家計簿

-----------------
-----------------


