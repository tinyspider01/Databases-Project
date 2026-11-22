CREATE TABLE `Stores`(
    `Store_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Contact_Phone` VARCHAR(20) NOT NULL,
    `Street` VARCHAR(32) NOT NULL,
    `City` VARCHAR(32) NOT NULL,
    `State/Province` VARCHAR(32) NOT NULL,
    `Postal_Code` VARCHAR(8) NOT NULL,
    `Country` CHAR(2) NOT NULL
);
CREATE TABLE `Vendors`(
    `Name` VARCHAR(32) NOT NULL,
    `Item_Price` DECIMAL(15, 2) NOT NULL,
    `Items_Shipped` VARCHAR(32) NOT NULL,
    `Item_Quantity` INT NOT NULL,
    `Fulfillments` INT NOT NULL,
    PRIMARY KEY(`Name`)
);
CREATE TABLE `Items`(
    `UPC` INT NOT NULL COMMENT 'Foreign Key',
    `Name` VARCHAR(32) NOT NULL,
    `Standard_Price` MEDIUMINT NOT NULL,
    `Description` TEXT NOT NULL,
    `Category` VARCHAR(16) NOT NULL,
    PRIMARY KEY(`UPC`)
);
CREATE TABLE `Inventory`(
    `Store_ID` INT NOT NULL,
    `UPC` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Current_Stock` MEDIUMINT NOT NULL,
    `Item_Location` TINYINT NOT NULL,
    `Item_Count` INT NOT NULL,
    `Store_Price` DECIMAL(15, 2) NOT NULL,
    `ETA` DATETIME NOT NULL,
    `Total_Product_Loss` INT NOT NULL,
    `Value_Lost` DECIMAL(15, 2) NOT NULL
);
ALTER TABLE
    `Inventory` ADD UNIQUE `inventory_store_id_unique`(`Store_ID`);
CREATE TABLE `Customer_Accounts`(
    `Account_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Membership_ID` BIGINT NOT NULL,
    `First_Name` VARCHAR(32) NOT NULL,
    `Last_Name` VARCHAR(32) NOT NULL,
    `Street` VARCHAR(32) NULL,
    `City` VARCHAR(32) NULL,
    `State/Province` CHAR(2) NULL,
    `Postal_Code` VARCHAR(8) NULL,
    `Country` CHAR(2) NULL,
    `Age` TINYINT NOT NULL,
    `Sex` VARCHAR(16) NULL,
    `Email` VARCHAR(32) NULL,
    `Phone_Number` VARCHAR(20) NULL,
    `Past_Orders` INT NULL
);
ALTER TABLE
    `Customer_Accounts` ADD UNIQUE `customer_accounts_membership_id_unique`(`Membership_ID`);
ALTER TABLE
    `Customer_Accounts` ADD UNIQUE `customer_accounts_past_orders_unique`(`Past_Orders`);
CREATE TABLE `Shipments`(
    `Shipment_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Vendor_Name` VARCHAR(32) NOT NULL,
    `Store_ID` BIGINT NOT NULL,
    `Date_Shipped` DATETIME NOT NULL,
    `ETA` DATETIME NOT NULL,
    `Total_Cost` DECIMAL(15, 2) NOT NULL
);
ALTER TABLE
    `Shipments` ADD UNIQUE `shipments_vendor_name_unique`(`Vendor_Name`);
ALTER TABLE
    `Shipments` ADD UNIQUE `shipments_store_id_unique`(`Store_ID`);
CREATE TABLE `Online_Orders`(
    `Order_ID` INT NOT NULL,
    `Store_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Account_ID` INT NOT NULL,
    `Street` VARCHAR(32) NOT NULL,
    `City` VARCHAR(32) NOT NULL,
    `State/Province` VARCHAR(32) NOT NULL,
    `Postal_Code` VARCHAR(8) NOT NULL,
    `Country` VARCHAR(32) NOT NULL,
    `Time_Shipped` DATETIME NOT NULL,
    PRIMARY KEY(`Order_ID`)
);
ALTER TABLE
    `Online_Orders` ADD UNIQUE `online_orders_account_id_unique`(`Account_ID`);
CREATE TABLE `Membership`(
    `Membership_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `First_Name` VARCHAR(32) NULL,
    `Last_Name` VARCHAR(32) NULL
);
CREATE TABLE `In_Store_Orders`(
    `Order_ID` INT NOT NULL,
    `Store_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Account_ID` INT NOT NULL,
    `Employee_ID` INT NOT NULL,
    `Time_Order_Processed` DATETIME NOT NULL,
    PRIMARY KEY(`Order_ID`)
);
ALTER TABLE
    `In_Store_Orders` ADD UNIQUE `in_store_orders_account_id_unique`(`Account_ID`);
ALTER TABLE
    `In_Store_Orders` ADD UNIQUE `in_store_orders_employee_id_unique`(`Employee_ID`);
CREATE TABLE `Employees`(
    `Store_ID` INT NOT NULL,
    `Employee_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `First_Name` VARCHAR(32) NOT NULL,
    `Last_Name` VARCHAR(32) NOT NULL,
    `Position` VARCHAR(32) NOT NULL
);
ALTER TABLE
    `Employees` ADD UNIQUE `employees_store_id_unique`(`Store_ID`);
CREATE TABLE `Items_In_Order`(
    `Order_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Items_Ordered` VARCHAR(32) NOT NULL,
    `Items_Cost` DECIMAL(15, 2) NOT NULL
);
CREATE TABLE `Items_In_Shipment`(
    `Shipment_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Items_Received` VARCHAR(32) NOT NULL,
    `Quantity` INT NOT NULL
);
CREATE TABLE `Store Hours`(
    `Store_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Monday_Hours` VARCHAR(64) NOT NULL,
    `Tuesday_Hours` VARCHAR(64) NOT NULL,
    `Wednesday_Hours` VARCHAR(64) NOT NULL,
    `Thursday_Hours` VARCHAR(64) NOT NULL,
    `Friday_Hours` VARCHAR(64) NOT NULL,
    `Saturday_Hours` VARCHAR(64) NOT NULL,
    `Sunday_Hours` VARCHAR(64) NOT NULL,
    `Holiday_Hours` VARCHAR(64) NOT NULL
);
CREATE TABLE `Customer_Order_Log`(
    `Account_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY,
    `Order_ID` INT NOT NULL,
    `Past_Orders` INT NULL
);
ALTER TABLE
    `Customer_Order_Log` ADD UNIQUE `customer_order_log_order_id_unique`(`Order_ID`);
CREATE TABLE `Vendor_Items`(
    `Name` VARCHAR(32) NOT NULL,
    `Items_Supplied` BIGINT NOT NULL,
    `Item_Prices` BIGINT NOT NULL,
    PRIMARY KEY(`Name`)
);
ALTER TABLE
    `Vendor_Items` ADD CONSTRAINT `vendor_items_items_supplied_foreign` FOREIGN KEY(`Items_Supplied`) REFERENCES `Vendors`(`Items_Shipped`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_postal_code_foreign` FOREIGN KEY(`Postal_Code`) REFERENCES `Online_Orders`(`Postal_Code`);
ALTER TABLE
    `Stores` ADD CONSTRAINT `stores_store_id_foreign` FOREIGN KEY(`Store_ID`) REFERENCES `Store Hours`(`Store_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_account_id_foreign` FOREIGN KEY(`Account_ID`) REFERENCES `In_Store_Orders`(`Account_ID`);
ALTER TABLE
    `Online_Orders` ADD CONSTRAINT `online_orders_order_id_foreign` FOREIGN KEY(`Order_ID`) REFERENCES `Items_In_Order`(`Order_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_street_foreign` FOREIGN KEY(`Street`) REFERENCES `Online_Orders`(`Street`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_city_foreign` FOREIGN KEY(`City`) REFERENCES `Online_Orders`(`City`);
ALTER TABLE
    `Stores` ADD CONSTRAINT `stores_store_id_foreign` FOREIGN KEY(`Store_ID`) REFERENCES `Inventory`(`Store_ID`);
ALTER TABLE
    `Stores` ADD CONSTRAINT `stores_store_id_foreign` FOREIGN KEY(`Store_ID`) REFERENCES `Employees`(`Store_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_past_orders_foreign` FOREIGN KEY(`Past_Orders`) REFERENCES `Online_Orders`(`Order_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_first_name_foreign` FOREIGN KEY(`First_Name`) REFERENCES `Membership`(`First_Name`);
ALTER TABLE
    `Stores` ADD CONSTRAINT `stores_store_id_foreign` FOREIGN KEY(`Store_ID`) REFERENCES `Shipments`(`Store_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_state/province_foreign` FOREIGN KEY(`State/Province`) REFERENCES `Online_Orders`(`State/Province`);
ALTER TABLE
    `Vendors` ADD CONSTRAINT `vendors_items_shipped_foreign` FOREIGN KEY(`Items_Shipped`) REFERENCES `Items`(`UPC`);
ALTER TABLE
    `In_Store_Orders` ADD CONSTRAINT `in_store_orders_order_id_foreign` FOREIGN KEY(`Order_ID`) REFERENCES `Customer_Order_Log`(`Order_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_last_name_foreign` FOREIGN KEY(`Last_Name`) REFERENCES `Membership`(`Last_Name`);
ALTER TABLE
    `Vendors` ADD CONSTRAINT `vendors_name_foreign` FOREIGN KEY(`Name`) REFERENCES `Vendor_Items`(`Name`);
ALTER TABLE
    `Online_Orders` ADD CONSTRAINT `online_orders_account_id_foreign` FOREIGN KEY(`Account_ID`) REFERENCES `Customer_Accounts`(`Account_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_membership_id_foreign` FOREIGN KEY(`Membership_ID`) REFERENCES `Membership`(`Membership_ID`);
ALTER TABLE
    `In_Store_Orders` ADD CONSTRAINT `in_store_orders_order_id_foreign` FOREIGN KEY(`Order_ID`) REFERENCES `Items_In_Order`(`Order_ID`);
ALTER TABLE
    `Employees` ADD CONSTRAINT `employees_employee_id_foreign` FOREIGN KEY(`Employee_ID`) REFERENCES `In_Store_Orders`(`Employee_ID`);
ALTER TABLE
    `Shipments` ADD CONSTRAINT `shipments_shipment_id_foreign` FOREIGN KEY(`Shipment_ID`) REFERENCES `Items_In_Shipment`(`Shipment_ID`);
ALTER TABLE
    `Items_In_Shipment` ADD CONSTRAINT `items_in_shipment_items_received_foreign` FOREIGN KEY(`Items_Received`) REFERENCES `Items`(`UPC`);
ALTER TABLE
    `Online_Orders` ADD CONSTRAINT `online_orders_order_id_foreign` FOREIGN KEY(`Order_ID`) REFERENCES `Customer_Order_Log`(`Order_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_account_id_foreign` FOREIGN KEY(`Account_ID`) REFERENCES `Customer_Order_Log`(`Account_ID`);
ALTER TABLE
    `Stores` ADD CONSTRAINT `stores_store_id_foreign` FOREIGN KEY(`Store_ID`) REFERENCES `Online_Orders`(`Store_ID`);
ALTER TABLE
    `Items` ADD CONSTRAINT `items_upc_foreign` FOREIGN KEY(`UPC`) REFERENCES `Inventory`(`UPC`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_past_orders_foreign` FOREIGN KEY(`Past_Orders`) REFERENCES `In_Store_Orders`(`Order_ID`);
ALTER TABLE
    `Stores` ADD CONSTRAINT `stores_store_id_foreign` FOREIGN KEY(`Store_ID`) REFERENCES `In_Store_Orders`(`Store_ID`);
ALTER TABLE
    `Customer_Accounts` ADD CONSTRAINT `customer_accounts_country_foreign` FOREIGN KEY(`Country`) REFERENCES `Online_Orders`(`Country`);
ALTER TABLE
    `Shipments` ADD CONSTRAINT `shipments_vendor_name_foreign` FOREIGN KEY(`Vendor_Name`) REFERENCES `Vendors`(`Name`);