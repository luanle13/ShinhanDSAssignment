-- Bài 1: Viết lệnh tạo bảng
CREATE TABLE CAMPUS
(
    Campus_ID VARCHAR2(5) NOT NULL,
    Campus_Name VARCHAR2(100) NOT NULL,
    Street VARCHAR2(100) NOT NULL,
    City VARCHAR2(100) NOT NULL,
    State VARCHAR2(100) NOT NULL,
    Zip VARCHAR2(100) NOT NULL,
    Phone VARCHAR2(100) NOT NULL,
    Campus_Discount DECIMAL(2,2) NOT NULL,
    CONSTRAINT Campus_PK PRIMARY KEY (Campus_ID)
);

CREATE TABLE POSITION
(
    Position_ID VARCHAR2(5) NOT NULL,
    Position VARCHAR2(100) NOT NULL,
    Yearly_Membership_Fee DECIMAL(7,2) NOT NULL,
    CONSTRAINT Position_PK PRIMARY KEY (Position_ID)
);

CREATE TABLE MEMBERS
(
    Member_ID VARCHAR2(5) NOT NULL,
    Last_Name VARCHAR2(100) NOT NULL,
    First_Name VARCHAR2(100) NOT NULL,
    Campus_Address VARCHAR2(100) NOT NULL,
    Campus_Phone VARCHAR2(100) NOT NULL,
    Campus_ID VARCHAR2(5),
    Position_ID VARCHAR2(5),
    Contract_Duration INTEGER NOT NULL,
    CONSTRAINT Member_PK PRIMARY KEY (Member_ID),
    FOREIGN KEY (Position_ID)
        REFERENCES POSITION(Position_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Campus_ID)
        REFERENCES CAMPUS(Campus_ID)
        ON DELETE CASCADE
);

CREATE TABLE PRICES
(
    Food_Item_Type_ID NUMBER(20),
    Meal_Type VARCHAR2(100),
    Meal_Price DECIMAL(7,2),
    CONSTRAINT Price_PK PRIMARY KEY (Food_Item_Type_ID)
);

CREATE TABLE FOODITEMS
(
    Food_Item_ID VARCHAR2(5),
    Food_Item_Name VARCHAR2(100),
    Food_Item_Type_ID NUMBER(20),
    CONSTRAINT FoodItem_PK PRIMARY KEY (Food_Item_ID),
    FOREIGN KEY (Food_Item_Type_ID)
        REFERENCES PRICES(Food_Item_Type_ID)
        ON DELETE CASCADE 
);

CREATE TABLE ORDERS
(
    Order_ID VARCHAR2(5),
    Member_ID VARCHAR2(5),
    Order_Date VARCHAR2(25),
    CONSTRAINT Order_PK PRIMARY KEY (Order_ID),
    FOREIGN KEY (Member_ID)
        REFERENCES MEMBERS(Member_ID)
        ON DELETE CASCADE
);

CREATE TABLE ORDERLINE
(
    Order_ID VARCHAR2(5),
    Food_Items_ID VARCHAR2(5),
    Quantity INTEGER,
    CONSTRAINT OrderLine_PK PRIMARY KEY (Order_ID, Food_Items_ID),
    FOREIGN KEY (Order_ID)
        REFERENCES ORDERS(Order_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Food_Items_ID)
        REFERENCES FOODITEMS(Food_Item_ID)
        ON DELETE CASCADE
);

CREATE SEQUENCE Prices_FoodItemTypeID_SEQ;

-- Bài 2: Viết lệnh chèn dữ liệu
INSERT ALL
	INTO CAMPUS (Campus_ID, Campus_Name, Street, City, State, Zip, Phone, Campus_Discount) 
        VALUES ('1','IUPUI','425 University Blvd.','Indianapolis', 'IN','46202', '317-274-4591',.08)
	INTO CAMPUS (Campus_ID, Campus_Name, Street, City, State, Zip, Phone, Campus_Discount) 
        VALUES ('2','Indiana University','107 S. Indiana Ave.','Bloomington', 'IN','47405', '812-855-4848',.07)
    INTO CAMPUS (Campus_ID, Campus_Name, Street, City, State, Zip, Phone, Campus_Discount) 
        VALUES ('3','Purdue University','475 Stadium Mall Drive','West Lafayette', 'IN','47907', '765-494-1776',.06)
SELECT * FROM dual;

INSERT ALL
	INTO POSITION (Position_ID, Position, Yearly_Membership_Fee) 
        VALUES ('1','Lecturer', 1050.50)
	INTO POSITION (Position_ID, Position, Yearly_Membership_Fee) 
        VALUES ('2','Associate Professor', 900.50)
    INTO POSITION (Position_ID, Position, Yearly_Membership_Fee) 
        VALUES ('3','Assistant Professor', 875.50)
    INTO POSITION (Position_ID, Position, Yearly_Membership_Fee) 
        VALUES ('4','Professor', 700.75)
    INTO POSITION (Position_ID, Position, Yearly_Membership_Fee) 
        VALUES ('5','Full Professor', 500.50)
SELECT * FROM dual;

INSERT ALL
	INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('1','Ellen','Monk','009 Purnell', '812-123-1234', '2', '5', 12)
	INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('2','Joe','Brady','008 Statford Hall', '765-234-2345', '3', '2', 10)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('3','Dave','Davidson','007 Purnell', '812-345-3456', '2', '3', 10)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('4','Sebastian','Cole','210 Rutherford Hall', '765-234-2345', '3', '5', 10)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('5','Michael','Doo','66C Peobody', '812-548-8956', '2', '1', 10)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('6','Jerome','Clark','SL 220', '317-274-9766', '1', '1', 12)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('7','Bob','House','ET 329', '317-278-9098', '1', '4', 10)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('8','Bridget','Stanley','SI 234', '317-274-5678', '1', '1', 12)
    INTO MEMBERS (Member_ID, Last_Name, First_Name, Campus_Address, Campus_Phone, Campus_ID, Position_ID, Contract_Duration) 
        VALUES ('9','Bradley','Wilson','334 Statford Hall', '765-258-2567', '3', '2', 10)
SELECT * FROM dual;

INSERT INTO PRICES (Food_Item_Type_ID, Meal_Type, Meal_Price) VALUES (Prices_FoodItemTypeID_SEQ.Nextval,'Beer/Wine', 5.50);
INSERT INTO PRICES (Food_Item_Type_ID, Meal_Type, Meal_Price) VALUES (Prices_FoodItemTypeID_SEQ.Nextval,'Dessert', 2.75);
INSERT INTO PRICES (Food_Item_Type_ID, Meal_Type, Meal_Price) VALUES (Prices_FoodItemTypeID_SEQ.Nextval,'Dinner', 15.50);
INSERT INTO PRICES (Food_Item_Type_ID, Meal_Type, Meal_Price) VALUES (Prices_FoodItemTypeID_SEQ.Nextval,'Soft Drink', 2.50);
INSERT INTO PRICES (Food_Item_Type_ID, Meal_Type, Meal_Price) VALUES (Prices_FoodItemTypeID_SEQ.Nextval,'Lunch', 7.25);

INSERT ALL
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10001','Lager', 1)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10002','Red Wine', 1)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10003','White Wine', 1)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10004','Coke', 4)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10005','Coffee', 4)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10006','Chicken a la King', 3)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10007','Rib Steak', 3)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10008','Fish and Chips', 3)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10009','Veggie Delight', 3)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10010','Chocolate Mousse', 2)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10011','Carrot Cake', 2)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10012','Fruit Cup', 2)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10013','Fish and Chips', 5)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10014','Angus Beef Burger', 5)
    INTO FOODITEMS (Food_Item_ID, Food_Item_Name, Food_Item_Type_ID) 
        VALUES ('10015','Cobb Salad', 5)
SELECT * FROM dual;

INSERT ALL
    INTO ORDERS (Order_ID, Member_ID, Order_Date)
        VALUES ('1', '9', 'March 5, 2005')
    INTO ORDERS (Order_ID, Member_ID, Order_Date)
        VALUES ('2', '8', 'March 5, 2005')
    INTO ORDERS (Order_ID, Member_ID, Order_Date)
        VALUES ('3', '7', 'March 5, 2005')
    INTO ORDERS (Order_ID, Member_ID, Order_Date)
        VALUES ('4', '6', 'March 7, 2005')
    INTO ORDERS (Order_ID, Member_ID, Order_Date)
        VALUES ('5', '5', 'March 7, 2005')
    INTO ORDERS (Order_ID, Member_ID, Order_Date)
        VALUES ('6', '4', 'March 10, 2005')
SELECT * FROM dual;

INSERT ALL
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('1','10001',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('1','10006',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('1','10012',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('2','10004',2)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('2','10013',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('2','10014',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('3','10005',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('3','10011',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('4','10005',2)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('4','10004',2)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('4','10006',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('4','10007',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('4','10010',2)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('5','10003',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('6','10002',2)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('6','10005',2)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('5','10005',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('6','10011',1)
    INTO ORDERLINE (Order_ID, Food_Items_ID, Quantity)
        VALUES ('6','10001',1)
SELECT * FROM dual;

-- Bài 3: Viết lệnh truy vấn theo yêu cầu
--  3.1
SELECT * FROM USER_CONSTRAINTS;
-- 3.2
SELECT table_name FROM USER_TABLES;
-- 3.3
SELECT sequence_name FROM USER_SEQUENCES;
-- 3.4
SELECT First_Name, Last_Name, Position, Campus_Name, Yearly_Membership_Fee/12 AS Monthly_Dues
FROM MEMBERS JOIN POSITION ON MEMBERS.Position_ID = POSITION.Position_ID
JOIN CAMPUS ON MEMBERS.Campus_ID = CAMPUS.Campus_ID
ORDER BY Campus_Name DESC, Last_Name ASC;