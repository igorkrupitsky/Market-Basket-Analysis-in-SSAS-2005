--DROP DATABASE Northwind

CREATE DATABASE Northwind
GO

Use Northwind
GO

CREATE TABLE [dbo].[Categories] (
	[CategoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[CategoryName] [nvarchar] (50)  NOT NULL ,
	[Description] [ntext]  NULL ,
	[Picture] [image] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Order Details] (
	[OrderID] [int] NOT NULL ,
	[ProductID] [int] NOT NULL ,
	[UnitPrice] [money] NOT NULL ,
	[Quantity] [smallint] NOT NULL ,
	[Discount] [real] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Orders] (
	[OrderID] [int] IDENTITY (1, 1) NOT NULL ,
	[CustomerID] [nchar] (5)  NULL ,
	[EmployeeID] [int] NULL ,
	[OrderDate] [datetime] NULL ,
	[RequiredDate] [datetime] NULL ,
	[ShippedDate] [datetime] NULL ,
	[ShipVia] [int] NULL ,
	[Freight] [money] NULL ,
	[ShipName] [nvarchar] (40)  NULL ,
	[ShipAddress] [nvarchar] (60)  NULL ,
	[ShipCity] [nvarchar] (15)  NULL ,
	[ShipRegion] [nvarchar] (15)  NULL ,
	[ShipPostalCode] [nvarchar] (10)  NULL ,
	[ShipCountry] [nvarchar] (15)  NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Products] (
	[ProductID] [int] IDENTITY (1, 1) NOT NULL ,
	[ProductName] [nvarchar] (40)  NOT NULL ,
	[SupplierID] [int] NULL ,
	[CategoryID] [int] NULL ,
	[QuantityPerUnit] [nvarchar] (20)  NULL ,
	[UnitPrice] [money] NULL ,
	[UnitsInStock] [smallint] NULL ,
	[UnitsOnOrder] [smallint] NULL ,
	[ReorderLevel] [smallint] NULL ,
	[Discontinued] [bit] NOT NULL ,
	[LastUserId] [int] NULL ,
	[LastDateUpdated] [datetime] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Categories] ADD 
	CONSTRAINT [PK_Categories] PRIMARY KEY  CLUSTERED 
	(
		[CategoryID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Order Details] ADD 
	CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT (0) FOR [UnitPrice],
	CONSTRAINT [DF_Order_Details_Quantity] DEFAULT (1) FOR [Quantity],
	CONSTRAINT [DF_Order_Details_Discount] DEFAULT (0) FOR [Discount],
	CONSTRAINT [PK_Order_Details] PRIMARY KEY  CLUSTERED 
	(
		[OrderID],
		[ProductID]
	)  ON [PRIMARY] ,
	CONSTRAINT [CK_Discount] CHECK ([Discount] >= 0 and [Discount] <= 1),
	CONSTRAINT [CK_Quantity] CHECK ([Quantity] > 0),
	CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice] >= 0)
GO

ALTER TABLE [dbo].[Orders] ADD 
	CONSTRAINT [DF_Orders_Freight] DEFAULT (0) FOR [Freight],
	CONSTRAINT [PK_Orders] PRIMARY KEY  CLUSTERED 
	(
		[OrderID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Products] ADD 
	CONSTRAINT [DF_Products_UnitPrice] DEFAULT (0) FOR [UnitPrice],
	CONSTRAINT [DF_Products_UnitsInStock] DEFAULT (0) FOR [UnitsInStock],
	CONSTRAINT [DF_Products_UnitsOnOrder] DEFAULT (0) FOR [UnitsOnOrder],
	CONSTRAINT [DF_Products_ReorderLevel] DEFAULT (0) FOR [ReorderLevel],
	CONSTRAINT [DF_Products_Discontinued] DEFAULT (0) FOR [Discontinued],
	CONSTRAINT [PK_Products] PRIMARY KEY  CLUSTERED 
	(
		[ProductID]
	)  ON [PRIMARY] ,
	CONSTRAINT [CK_Products_UnitPrice] CHECK ([UnitPrice] >= 0),
	CONSTRAINT [CK_ReorderLevel] CHECK ([ReorderLevel] >= 0),
	CONSTRAINT [CK_UnitsInStock] CHECK ([UnitsInStock] >= 0),
	CONSTRAINT [CK_UnitsOnOrder] CHECK ([UnitsOnOrder] >= 0)
GO

ALTER TABLE [dbo].[Order Details] ADD 
	CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY 
	(
		[OrderID]
	) REFERENCES [dbo].[Orders] (
		[OrderID]
	),
	CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY 
	(
		[ProductID]
	) REFERENCES [dbo].[Products] (
		[ProductID]
	)
GO

ALTER TABLE [dbo].[Products] ADD 
	CONSTRAINT [FK_Products_Categories] FOREIGN KEY 
	(
		[CategoryID]
	) REFERENCES [dbo].[Categories] (
		[CategoryID]
	)
GO
----------------------------------------------------


--Categories

SET IDENTITY_INSERT Categories ON

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (1, N'Beverages', N'2', 0x151C2F00020000000D000E)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (2, N'Condiments', N'1', 0x151C2F00020000000D000E)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (3, N'Confections', N'Desserts, candies, and sweet breads', 0x151C2F00020000000D000E)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (4, N'Dairy Products', N'1', 0x4749463839614903EB00F7)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal', 0x151C2F00020000000D000E)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (6, N'Meat/Poultry', N'Prepared meats', 0x151C2F00020000000D000E)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (7, N'Produce', N'Dried fruit and bean curd', 0x151C2F00020000000D000E)

INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
VALUES (8, N'Seafood', N'Seaweed and fish', 0x151C2F00020000000D000E)

SET IDENTITY_INSERT Categories OFF

--Products

SET IDENTITY_INSERT Products ON

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (1, N'Chai', 1, 1, N'10 boxes x 20 bags', 18, 39, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (2, N'Chang', 1, 1, N'24 - 12 oz bottles', 19, 17, 40, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (3, N'Aniseed Syrup', 1, 2, N'12 - 550 ml bottles', 10, 13, 70, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (4, N'Chef Anton''s Cajun Seasoning', 2, 2, N'48 - 6 oz jars', 22, 53, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (5, N'Chef Anton''s Gumbo Mix', 2, 2, N'36 boxes', 21.35, 0, 0, 0, 1, 1, '10/7/2008 2:31:10 AM')

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (6, N'Grandma''s Boysenberry Spread', 3, 2, N'12 - 8 oz jars', 25, 120, 0, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (7, N'Uncle Bob''s Organic Dried Pears', 3, 7, N'12 - 1 lb pkgs.', 30, 15, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (8, N'Northwoods Cranberry Sauce', 3, 2, N'12 - 12 oz jars', 40, 6, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (9, N'Mishi Kobe Niku', 4, 6, N'18 - 500 g pkgs.', 97, 29, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (10, N'Ikura', 4, 8, N'12 - 200 ml jars', 31, 31, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (11, N'Queso Cabrales', 5, 4, N'1 kg pkg.', 21, 22, 30, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (12, N'Queso Manchego La Pastora', 5, 4, N'10 - 500 g pkgs.', 38, 86, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (13, N'Konbu', 6, 8, N'2 kg box', 6, 24, 0, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (14, N'Tofu', 6, 7, N'40 - 100 g pkgs.', 23.25, 35, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (15, N'Genen Shouyu', 6, 2, N'24 - 250 ml bottles', 15.5, 39, 0, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (16, N'Pavlova', 7, 3, N'32 - 500 g boxes', 17.45, 29, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (17, N'Alice Mutton', 7, 6, N'20 - 1 kg tins', 39, 0, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (18, N'Carnarvon Tigers', 7, 8, N'16 kg pkg.', 62.5, 42, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (19, N'Teatime Chocolate Biscuits', 8, 3, N'10 boxes x 12 pieces', 9.2, 25, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (20, N'Sir Rodney''s Marmalade', 8, 3, N'30 gift boxes', 81, 40, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (21, N'Sir Rodney''s Scones', 8, 3, N'24 pkgs. x 4 pieces', 10, 3, 40, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (22, N'Gustaf''s Kn?ckebr?d', 9, 5, N'24 - 500 g pkgs.', 21, 104, 0, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (23, N'Tunnbr?d', 9, 5, N'12 - 250 g pkgs.', 9, 61, 0, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (24, N'Guaran? Fant?stica', 10, 1, N'12 - 355 ml cans', 4.5, 20, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (25, N'NuNuCa Nu?-Nougat-Creme', 11, 3, N'20 - 450 g glasses', 14, 76, 0, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (26, N'Gumb?r Gummib?rchen', 11, 3, N'100 - 250 g bags', 31.23, 15, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (27, N'Schoggi Schokolade', 11, 3, N'100 - 100 g pieces', 43.9, 49, 0, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (28, N'R?ssle Sauerkraut', 12, 7, N'25 - 825 g cans', 45.6, 26, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (29, N'Th?ringer Rostbratwurst', 12, 6, N'50 bags x 30 sausgs.', 123.79, 0, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (30, N'Nord-Ost Matjeshering', 13, 8, N'10 - 200 g glasses', 25.89, 10, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (31, N'Gorgonzola Telino', 14, 4, N'12 - 100 g pkgs', 12.5, 0, 70, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (32, N'Mascarpone Fabioli', 14, 4, N'24 - 200 g pkgs.', 32, 9, 40, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (33, N'Geitost', 15, 4, N'500 g', 2.5, 112, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (34, N'Sasquatch Ale', 16, 1, N'24 - 12 oz bottles', 14, 111, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (35, N'Steeleye Stout', 16, 1, N'24 - 12 oz bottles', 18, 20, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (36, N'Inlagd Sill', 17, 8, N'24 - 250 g  jars', 19, 112, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (37, N'Gravad lax', 17, 8, N'12 - 500 g pkgs.', 26, 11, 50, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (38, N'C?te de Blaye', 18, 1, N'12 - 75 cl bottles', 263.5, 17, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (39, N'Chartreuse verte', 18, 1, N'750 cc per bottle', 18, 69, 0, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (40, N'Boston Crab Meat', 19, 8, N'24 - 4 oz tins', 18.4, 123, 0, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (41, N'Jack''s New England Clam Chowder', 19, 8, N'12 - 12 oz cans', 9.65, 85, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (42, N'Singaporean Hokkien Fried Mee', 20, 5, N'32 - 1 kg pkgs.', 14, 26, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (43, N'Ipoh Coffee', 20, 1, N'16 - 500 g tins', 46, 17, 10, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (44, N'Gula Malacca', 20, 2, N'20 - 2 kg bags', 19.45, 27, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (45, N'Rogede sild', 21, 8, N'1k pkg.', 9.5, 5, 70, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (46, N'Spegesild', 21, 8, N'4 - 450 g glasses', 12, 95, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (47, N'Zaanse koeken', 22, 3, N'10 - 4 oz boxes', 9.5, 36, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (48, N'Chocolade', 22, 3, N'10 pkgs.', 12.75, 15, 70, 25, 0, 1, '10/7/2008 2:27:39 AM')

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (49, N'Maxilaku', 23, 3, N'24 - 50 g pkgs.', 20, 10, 60, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (50, N'Valkoinen suklaa', 23, 3, N'12 - 100 g bars', 16.25, 65, 0, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (51, N'Manjimup Dried Apples', 24, 7, N'50 - 300 g pkgs.', 53, 20, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (52, N'Filo Mix', 24, 5, N'16 - 2 kg boxes', 7, 38, 0, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (53, N'Perth Pasties', 24, 6, N'48 pieces', 32.8, 0, 0, 0, 1, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (54, N'Tourti?re', 25, 6, N'16 pies', 7.45, 21, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (55, N'P?t? chinois', 25, 6, N'24 boxes x 2 pies', 24, 115, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (56, N'Gnocchi di nonna Alice', 26, 5, N'24 - 250 g pkgs.', 38, 21, 10, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (57, N'Ravioli Angelo', 26, 5, N'24 - 250 g pkgs.', 19.5, 36, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (58, N'Escargots de Bourgogne', 27, 8, N'24 pieces', 13.25, 62, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (59, N'Raclette Courdavault', 28, 4, N'5 kg pkg.', 55, 79, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (60, N'Camembert Pierrot', 28, 4, N'15 - 300 g rounds', 34, 19, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (61, N'Sirop d''?rable', 29, 2, N'24 - 500 ml bottles', 28.5, 113, 0, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (62, N'Tarte au sucre', 29, 3, N'48 pies', 49.3, 17, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (63, N'Vegie-spread', 7, 2, N'15 - 625 g jars', 43.9, 24, 0, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (64, N'Wimmers gute Semmelkn?del', 12, 5, N'20 bags x 4 pieces', 33.25, 22, 80, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (65, N'Louisiana Fiery Hot Pepper Sauce', 2, 2, N'32 - 8 oz bottles', 21.05, 76, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (66, N'Louisiana Hot Spiced Okra', 2, 2, N'24 - 8 oz jars', 17, 4, 100, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (67, N'Laughing Lumberjack Lager', 16, 1, N'24 - 12 oz bottles', 14, 52, 0, 10, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (68, N'Scottish Longbreads', 8, 3, N'10 boxes x 8 pieces', 12.5, 6, 10, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (69, N'Gudbrandsdalsost', 15, 4, N'10 kg pkg.', 36, 26, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (70, N'Outback Lager', 7, 1, N'24 - 355 ml bottles', 15, 15, 10, 30, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (71, N'Flotemysost', 15, 4, N'10 - 500 g pkgs.', 21.5, 26, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (72, N'Mozzarella di Giovanni', 14, 4, N'24 - 200 g pkgs.', 34.8, 14, 0, 0, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (73, N'R?d Kaviar', 17, 8, N'24 - 150 g jars', 15, 101, 0, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (74, N'Longlife Tofu', 4, 7, N'5 kg pkg.', 10, 4, 20, 5, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (75, N'Rh?nbr?u Klosterbier', 12, 1, N'24 - 0.5 l bottles', 7.75, 125, 0, 25, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (76, N'Lakkalik??ri', 23, 1, N'500 ml', 18, 57, 0, 20, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (77, N'Original Frankfurter gr?ne So?e', 12, 2, N'12 boxes', 13, 32, 0, 15, 0, NULL, NULL)

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, LastUserId, LastDateUpdated)
VALUES (78, N'Test Product', 12, NULL, N'1M bucs', 1000, 12, 2, 22, 0, NULL, NULL)

SET IDENTITY_INSERT Products OFF

--------------------------------------------------------------------------------------------
--Orders

SET IDENTITY_INSERT Orders ON

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10248, N'VINET', 5, '7/4/1996 12:00:00 AM', '8/1/1996 12:00:00 AM', '7/16/1996 12:00:00 AM', 3, 32.38, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10249, N'TOMSP', 6, '7/5/1996 12:00:00 AM', '8/16/1996 12:00:00 AM', '7/10/1996 12:00:00 AM', 1, 11.61, N'Toms Spezialit?ten', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10250, N'HANAR', 4, '7/8/1996 12:00:00 AM', '8/5/1996 12:00:00 AM', '7/12/1996 12:00:00 AM', 2, 65.83, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10251, N'VICTE', 3, '7/8/1996 12:00:00 AM', '8/5/1996 12:00:00 AM', '7/15/1996 12:00:00 AM', 1, 41.34, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10252, N'SUPRD', 4, '7/9/1996 12:00:00 AM', '8/6/1996 12:00:00 AM', '7/11/1996 12:00:00 AM', 2, 51.3, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10253, N'HANAR', 3, '7/10/1996 12:00:00 AM', '7/24/1996 12:00:00 AM', '7/16/1996 12:00:00 AM', 2, 58.17, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10254, N'CHOPS', 5, '7/11/1996 12:00:00 AM', '8/8/1996 12:00:00 AM', '7/23/1996 12:00:00 AM', 2, 22.98, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10255, N'RICSU', 9, '7/12/1996 12:00:00 AM', '8/9/1996 12:00:00 AM', '7/15/1996 12:00:00 AM', 3, 148.33, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10256, N'WELLI', 3, '7/15/1996 12:00:00 AM', '8/12/1996 12:00:00 AM', '7/17/1996 12:00:00 AM', 2, 13.97, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10257, N'HILAA', 4, '7/16/1996 12:00:00 AM', '8/13/1996 12:00:00 AM', '7/22/1996 12:00:00 AM', 3, 81.91, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10258, N'ERNSH', 1, '7/17/1996 12:00:00 AM', '8/14/1996 12:00:00 AM', '7/11/1996 12:00:00 AM', 2, 140.51, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10259, N'CENTC', 4, '7/18/1996 12:00:00 AM', '8/15/1996 12:00:00 AM', '7/25/1996 12:00:00 AM', 3, 3.25, N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'M?xico D.F.', NULL, N'05022', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10260, N'OTTIK', 4, '7/19/1996 12:00:00 AM', '8/16/1996 12:00:00 AM', '7/29/1996 12:00:00 AM', 1, 55.09, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10261, N'QUEDE', 4, '7/19/1996 12:00:00 AM', '8/16/1996 12:00:00 AM', '7/30/1996 12:00:00 AM', 2, 3.05, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10262, N'RATTC', 8, '7/22/1996 12:00:00 AM', '8/19/1996 12:00:00 AM', '7/25/1996 12:00:00 AM', 3, 48.29, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10263, N'ERNSH', 9, '7/23/1996 12:00:00 AM', '8/20/1996 12:00:00 AM', '7/31/1996 12:00:00 AM', 3, 146.06, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10264, N'FOLKO', 6, '7/24/1996 12:00:00 AM', '8/21/1996 12:00:00 AM', '8/23/1996 12:00:00 AM', 3, 3.67, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10265, N'BLONP', 2, '7/25/1996 12:00:00 AM', '8/22/1996 12:00:00 AM', '8/12/1996 12:00:00 AM', 1, 55.28, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10266, N'WARTH', 3, '7/26/1996 12:00:00 AM', '9/6/1996 12:00:00 AM', '7/31/1996 12:00:00 AM', 3, 25.73, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10267, N'FRANK', 4, '7/29/1996 12:00:00 AM', '8/26/1996 12:00:00 AM', '8/6/1996 12:00:00 AM', 1, 208.58, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10268, N'GROSR', 8, '7/30/1996 12:00:00 AM', '8/27/1996 12:00:00 AM', '8/2/1996 12:00:00 AM', 3, 66.29, N'GROSELLA-Restaurante', N'5? Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10269, N'WHITC', 5, '7/31/1996 12:00:00 AM', '8/14/1996 12:00:00 AM', '8/9/1996 12:00:00 AM', 1, 4.56, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10270, N'WARTH', 1, '8/1/1996 12:00:00 AM', '8/29/1996 12:00:00 AM', '8/2/1996 12:00:00 AM', 1, 136.54, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10271, N'SPLIR', 6, '8/1/1996 12:00:00 AM', '8/29/1996 12:00:00 AM', '8/30/1996 12:00:00 AM', 2, 4.54, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10272, N'RATTC', 6, '8/2/1996 12:00:00 AM', '8/30/1996 12:00:00 AM', '8/6/1996 12:00:00 AM', 2, 98.03, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10273, N'QUICK', 3, '8/5/1996 12:00:00 AM', '9/2/1996 12:00:00 AM', '8/12/1996 12:00:00 AM', 3, 76.07, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10274, N'VINET', 6, '8/6/1996 12:00:00 AM', '9/3/1996 12:00:00 AM', '8/16/1996 12:00:00 AM', 1, 6.01, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10275, N'MAGAA', 1, '8/7/1996 12:00:00 AM', '9/4/1996 12:00:00 AM', '8/9/1996 12:00:00 AM', 1, 26.93, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10276, N'TORTU', 8, '8/8/1996 12:00:00 AM', '8/22/1996 12:00:00 AM', '8/14/1996 12:00:00 AM', 3, 13.84, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10277, N'MORGK', 2, '8/9/1996 12:00:00 AM', '9/6/1996 12:00:00 AM', '8/13/1996 12:00:00 AM', 3, 125.77, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10278, N'BERGS', 8, '8/12/1996 12:00:00 AM', '9/9/1996 12:00:00 AM', '8/16/1996 12:00:00 AM', 2, 92.69, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10279, N'LEHMS', 8, '8/13/1996 12:00:00 AM', '9/10/1996 12:00:00 AM', '8/16/1996 12:00:00 AM', 2, 25.83, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10280, N'BERGS', 2, '8/14/1996 12:00:00 AM', '9/11/1996 12:00:00 AM', '9/12/1996 12:00:00 AM', 1, 8.98, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10281, N'ROMEY', 4, '8/14/1996 12:00:00 AM', '8/28/1996 12:00:00 AM', '8/21/1996 12:00:00 AM', 1, 2.94, N'Romero y tomillo', N'Gran V?a, 1', N'Madrid', NULL, N'28001', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10282, N'ROMEY', 4, '8/15/1996 12:00:00 AM', '9/12/1996 12:00:00 AM', '8/21/1996 12:00:00 AM', 1, 12.69, N'Romero y tomillo', N'Gran V?a, 1', N'Madrid', NULL, N'28001', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10283, N'LILAS', 3, '8/16/1996 12:00:00 AM', '9/13/1996 12:00:00 AM', '8/23/1996 12:00:00 AM', 3, 84.81, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10284, N'LEHMS', 4, '8/19/1996 12:00:00 AM', '9/16/1996 12:00:00 AM', '8/27/1996 12:00:00 AM', 1, 76.56, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10285, N'QUICK', 1, '8/20/1996 12:00:00 AM', '9/17/1996 12:00:00 AM', '8/26/1996 12:00:00 AM', 2, 76.83, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10286, N'QUICK', 8, '8/21/1996 12:00:00 AM', '9/18/1996 12:00:00 AM', '8/30/1996 12:00:00 AM', 3, 229.24, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10287, N'RICAR', 8, '8/22/1996 12:00:00 AM', '9/19/1996 12:00:00 AM', '8/28/1996 12:00:00 AM', 3, 12.76, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10288, N'REGGC', 4, '8/23/1996 12:00:00 AM', '9/20/1996 12:00:00 AM', '9/3/1996 12:00:00 AM', 1, 7.45, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10289, N'BSBEV', 7, '8/26/1996 12:00:00 AM', '9/23/1996 12:00:00 AM', '8/28/1996 12:00:00 AM', 3, 22.77, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10290, N'COMMI', 8, '8/27/1996 12:00:00 AM', '9/24/1996 12:00:00 AM', '9/3/1996 12:00:00 AM', 1, 79.7, N'Com?rcio Mineiro', N'Av. dos Lus?adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10291, N'QUEDE', 6, '8/27/1996 12:00:00 AM', '9/24/1996 12:00:00 AM', '9/4/1996 12:00:00 AM', 2, 6.4, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10292, N'TRADH', 1, '8/28/1996 12:00:00 AM', '9/25/1996 12:00:00 AM', '9/2/1996 12:00:00 AM', 2, 1.35, N'Tradi?ao Hipermercados', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10293, N'TORTU', 1, '8/29/1996 12:00:00 AM', '9/26/1996 12:00:00 AM', '9/11/1996 12:00:00 AM', 3, 21.18, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10294, N'RATTC', 4, '8/30/1996 12:00:00 AM', '9/27/1996 12:00:00 AM', '9/5/1996 12:00:00 AM', 2, 147.26, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10295, N'VINET', 2, '9/2/1996 12:00:00 AM', '9/30/1996 12:00:00 AM', '9/10/1996 12:00:00 AM', 2, 1.15, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10296, N'LILAS', 6, '9/3/1996 12:00:00 AM', '10/1/1996 12:00:00 AM', '9/11/1996 12:00:00 AM', 1, 0.12, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10297, N'BLONP', 5, '9/4/1996 12:00:00 AM', '10/16/1996 12:00:00 AM', '9/10/1996 12:00:00 AM', 2, 5.74, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10298, N'HUNGO', 6, '9/5/1996 12:00:00 AM', '10/3/1996 12:00:00 AM', '9/11/1996 12:00:00 AM', 2, 168.22, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10299, N'RICAR', 4, '9/6/1996 12:00:00 AM', '10/4/1996 12:00:00 AM', '9/13/1996 12:00:00 AM', 2, 29.76, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10300, N'MAGAA', 2, '9/9/1996 12:00:00 AM', '10/7/1996 12:00:00 AM', '9/18/1996 12:00:00 AM', 2, 17.68, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10301, N'WANDK', 8, '9/9/1996 12:00:00 AM', '10/7/1996 12:00:00 AM', '9/17/1996 12:00:00 AM', 2, 45.08, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10302, N'SUPRD', 4, '9/10/1996 12:00:00 AM', '10/8/1996 12:00:00 AM', '10/9/1996 12:00:00 AM', 2, 6.27, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10303, N'GODOS', 7, '9/11/1996 12:00:00 AM', '10/9/1996 12:00:00 AM', '9/18/1996 12:00:00 AM', 2, 107.83, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10304, N'TORTU', 1, '9/12/1996 12:00:00 AM', '10/10/1996 12:00:00 AM', '9/17/1996 12:00:00 AM', 2, 63.79, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10305, N'OLDWO', 8, '9/13/1996 12:00:00 AM', '10/11/1996 12:00:00 AM', '10/9/1996 12:00:00 AM', 3, 257.62, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10306, N'ROMEY', 1, '9/16/1996 12:00:00 AM', '10/14/1996 12:00:00 AM', '9/23/1996 12:00:00 AM', 3, 7.56, N'Romero y tomillo', N'Gran V?a, 1', N'Madrid', NULL, N'28001', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10307, N'LONEP', 2, '9/17/1996 12:00:00 AM', '10/15/1996 12:00:00 AM', '9/25/1996 12:00:00 AM', 2, 0.56, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10308, N'ANATR', 7, '9/18/1996 12:00:00 AM', '10/16/1996 12:00:00 AM', '9/24/1996 12:00:00 AM', 3, 1.61, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci?n 2222', N'M?xico D.F.', NULL, N'05021', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10309, N'HUNGO', 3, '9/19/1996 12:00:00 AM', '10/17/1996 12:00:00 AM', '10/23/1996 12:00:00 AM', 1, 47.3, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10310, N'THEBI', 8, '9/20/1996 12:00:00 AM', '10/18/1996 12:00:00 AM', '9/27/1996 12:00:00 AM', 2, 17.52, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10311, N'DUMON', 1, '9/20/1996 12:00:00 AM', '10/4/1996 12:00:00 AM', '9/26/1996 12:00:00 AM', 3, 24.69, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10312, N'WANDK', 2, '9/23/1996 12:00:00 AM', '10/21/1996 12:00:00 AM', '10/3/1996 12:00:00 AM', 2, 40.26, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10313, N'QUICK', 2, '9/24/1996 12:00:00 AM', '10/22/1996 12:00:00 AM', '10/4/1996 12:00:00 AM', 2, 1.96, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10314, N'RATTC', 1, '9/25/1996 12:00:00 AM', '10/23/1996 12:00:00 AM', '10/4/1996 12:00:00 AM', 2, 74.16, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10315, N'ISLAT', 4, '9/26/1996 12:00:00 AM', '10/24/1996 12:00:00 AM', '10/3/1996 12:00:00 AM', 2, 41.76, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10316, N'RATTC', 1, '9/27/1996 12:00:00 AM', '10/25/1996 12:00:00 AM', '10/8/1996 12:00:00 AM', 3, 150.15, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10317, N'LONEP', 6, '9/30/1996 12:00:00 AM', '10/28/1996 12:00:00 AM', '10/10/1996 12:00:00 AM', 1, 12.69, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10318, N'ISLAT', 8, '10/1/1996 12:00:00 AM', '10/29/1996 12:00:00 AM', '10/4/1996 12:00:00 AM', 2, 4.73, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10319, N'TORTU', 7, '10/2/1996 12:00:00 AM', '10/30/1996 12:00:00 AM', '10/11/1996 12:00:00 AM', 3, 64.5, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10320, N'WARTH', 5, '10/3/1996 12:00:00 AM', '10/17/1996 12:00:00 AM', '10/18/1996 12:00:00 AM', 3, 34.57, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10321, N'ISLAT', 3, '10/3/1996 12:00:00 AM', '10/31/1996 12:00:00 AM', '10/11/1996 12:00:00 AM', 2, 3.43, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10322, N'PERIC', 7, '10/4/1996 12:00:00 AM', '11/1/1996 12:00:00 AM', '10/23/1996 12:00:00 AM', 3, 0.4, N'Pericles Comidas cl?sicas', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10323, N'KOENE', 4, '10/7/1996 12:00:00 AM', '11/4/1996 12:00:00 AM', '10/14/1996 12:00:00 AM', 1, 4.88, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10324, N'SAVEA', 9, '10/8/1996 12:00:00 AM', '11/5/1996 12:00:00 AM', '10/10/1996 12:00:00 AM', 1, 214.27, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10325, N'KOENE', 1, '10/9/1996 12:00:00 AM', '10/23/1996 12:00:00 AM', '10/14/1996 12:00:00 AM', 3, 64.86, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10326, N'BOLID', 4, '10/10/1996 12:00:00 AM', '11/7/1996 12:00:00 AM', '10/14/1996 12:00:00 AM', 2, 77.92, N'B?lido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10327, N'FOLKO', 2, '10/11/1996 12:00:00 AM', '11/8/1996 12:00:00 AM', '10/14/1996 12:00:00 AM', 1, 63.36, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10328, N'FURIB', 4, '10/14/1996 12:00:00 AM', '11/11/1996 12:00:00 AM', '10/17/1996 12:00:00 AM', 3, 87.03, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10329, N'SPLIR', 4, '10/15/1996 12:00:00 AM', '11/26/1996 12:00:00 AM', '10/23/1996 12:00:00 AM', 2, 191.67, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10330, N'LILAS', 3, '10/16/1996 12:00:00 AM', '11/13/1996 12:00:00 AM', '10/28/1996 12:00:00 AM', 1, 12.75, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10331, N'BONAP', 9, '10/16/1996 12:00:00 AM', '11/27/1996 12:00:00 AM', '10/21/1996 12:00:00 AM', 1, 10.19, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10332, N'MEREP', 3, '10/17/1996 12:00:00 AM', '11/28/1996 12:00:00 AM', '10/21/1996 12:00:00 AM', 2, 52.84, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10333, N'WARTH', 5, '10/18/1996 12:00:00 AM', '11/15/1996 12:00:00 AM', '10/25/1996 12:00:00 AM', 3, 0.59, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10334, N'VICTE', 8, '10/21/1996 12:00:00 AM', '11/18/1996 12:00:00 AM', '10/28/1996 12:00:00 AM', 2, 8.56, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10335, N'HUNGO', 7, '10/22/1996 12:00:00 AM', '11/19/1996 12:00:00 AM', '10/24/1996 12:00:00 AM', 2, 42.11, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10336, N'PRINI', 7, '10/23/1996 12:00:00 AM', '11/20/1996 12:00:00 AM', '10/25/1996 12:00:00 AM', 2, 15.51, N'Princesa Isabel Vinhos', N'Estrada da sa?de n. 58', N'Lisboa', NULL, N'1756', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10337, N'FRANK', 4, '10/24/1996 12:00:00 AM', '11/21/1996 12:00:00 AM', '10/29/1996 12:00:00 AM', 3, 108.26, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10338, N'OLDWO', 4, '10/25/1996 12:00:00 AM', '11/22/1996 12:00:00 AM', '10/29/1996 12:00:00 AM', 3, 84.21, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10339, N'MEREP', 2, '10/28/1996 12:00:00 AM', '11/25/1996 12:00:00 AM', '11/4/1996 12:00:00 AM', 2, 15.66, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10340, N'BONAP', 1, '10/29/1996 12:00:00 AM', '11/26/1996 12:00:00 AM', '11/8/1996 12:00:00 AM', 3, 166.31, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10341, N'SIMOB', 7, '10/29/1996 12:00:00 AM', '11/26/1996 12:00:00 AM', '11/5/1996 12:00:00 AM', 3, 26.78, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10342, N'FRANK', 4, '10/30/1996 12:00:00 AM', '11/13/1996 12:00:00 AM', '11/4/1996 12:00:00 AM', 2, 54.83, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10343, N'LEHMS', 4, '10/31/1996 12:00:00 AM', '11/28/1996 12:00:00 AM', '11/6/1996 12:00:00 AM', 1, 110.37, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10344, N'WHITC', 4, '11/1/1996 12:00:00 AM', '11/29/1996 12:00:00 AM', '11/5/1996 12:00:00 AM', 2, 23.29, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10345, N'QUICK', 2, '11/4/1996 12:00:00 AM', '12/2/1996 12:00:00 AM', '11/11/1996 12:00:00 AM', 2, 249.06, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10346, N'RATTC', 3, '11/5/1996 12:00:00 AM', '12/17/1996 12:00:00 AM', '11/8/1996 12:00:00 AM', 3, 142.08, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10347, N'FAMIA', 4, '11/6/1996 12:00:00 AM', '12/4/1996 12:00:00 AM', '11/8/1996 12:00:00 AM', 3, 3.1, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10348, N'WANDK', 4, '11/7/1996 12:00:00 AM', '12/5/1996 12:00:00 AM', '11/15/1996 12:00:00 AM', 2, 0.78, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10349, N'SPLIR', 7, '11/8/1996 12:00:00 AM', '12/6/1996 12:00:00 AM', '11/15/1996 12:00:00 AM', 1, 8.63, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10350, N'LAMAI', 6, '11/11/1996 12:00:00 AM', '12/9/1996 12:00:00 AM', '12/3/1996 12:00:00 AM', 2, 64.19, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10351, N'ERNSH', 1, '11/11/1996 12:00:00 AM', '12/9/1996 12:00:00 AM', '11/20/1996 12:00:00 AM', 1, 162.33, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10352, N'FURIB', 3, '11/12/1996 12:00:00 AM', '11/26/1996 12:00:00 AM', '11/18/1996 12:00:00 AM', 3, 1.3, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10353, N'PICCO', 7, '11/13/1996 12:00:00 AM', '12/11/1996 12:00:00 AM', '11/25/1996 12:00:00 AM', 3, 360.63, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10354, N'PERIC', 8, '11/14/1996 12:00:00 AM', '12/12/1996 12:00:00 AM', '11/20/1996 12:00:00 AM', 3, 53.8, N'Pericles Comidas cl?sicas', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10355, N'AROUT', 6, '11/15/1996 12:00:00 AM', '12/13/1996 12:00:00 AM', '11/20/1996 12:00:00 AM', 1, 41.95, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10356, N'WANDK', 6, '11/18/1996 12:00:00 AM', '12/16/1996 12:00:00 AM', '11/27/1996 12:00:00 AM', 2, 36.71, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10357, N'LILAS', 1, '11/19/1996 12:00:00 AM', '12/17/1996 12:00:00 AM', '12/2/1996 12:00:00 AM', 3, 34.88, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10358, N'LAMAI', 5, '11/20/1996 12:00:00 AM', '12/18/1996 12:00:00 AM', '11/27/1996 12:00:00 AM', 1, 19.64, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10359, N'SEVES', 5, '11/21/1996 12:00:00 AM', '12/19/1996 12:00:00 AM', '11/26/1996 12:00:00 AM', 3, 288.43, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10360, N'BLONP', 4, '11/22/1996 12:00:00 AM', '12/20/1996 12:00:00 AM', '12/2/1996 12:00:00 AM', 3, 131.7, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10361, N'QUICK', 1, '11/22/1996 12:00:00 AM', '12/20/1996 12:00:00 AM', '12/3/1996 12:00:00 AM', 2, 183.17, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10362, N'BONAP', 3, '11/25/1996 12:00:00 AM', '12/23/1996 12:00:00 AM', '11/28/1996 12:00:00 AM', 1, 96.04, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10363, N'DRACD', 4, '11/26/1996 12:00:00 AM', '12/24/1996 12:00:00 AM', '12/4/1996 12:00:00 AM', 3, 30.54, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10364, N'EASTC', 1, '11/26/1996 12:00:00 AM', '1/7/1997 12:00:00 AM', '12/4/1996 12:00:00 AM', 1, 71.97, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10365, N'ANTON', 3, '11/27/1996 12:00:00 AM', '12/25/1996 12:00:00 AM', '12/2/1996 12:00:00 AM', 2, 22, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10366, N'GALED', 8, '11/28/1996 12:00:00 AM', '1/9/1997 12:00:00 AM', '12/30/1996 12:00:00 AM', 2, 10.14, N'Galer?a del gastron?mo', N'Rambla de Catalu?a, 23', N'Barcelona', NULL, N'8022', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10367, N'VAFFE', 7, '11/28/1996 12:00:00 AM', '12/26/1996 12:00:00 AM', '12/2/1996 12:00:00 AM', 3, 13.55, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10368, N'ERNSH', 2, '11/29/1996 12:00:00 AM', '12/27/1996 12:00:00 AM', '12/2/1996 12:00:00 AM', 2, 101.95, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10369, N'SPLIR', 8, '12/2/1996 12:00:00 AM', '12/30/1996 12:00:00 AM', '12/9/1996 12:00:00 AM', 2, 195.68, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10370, N'CHOPS', 6, '12/3/1996 12:00:00 AM', '12/31/1996 12:00:00 AM', '12/27/1996 12:00:00 AM', 2, 1.17, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10371, N'LAMAI', 1, '12/3/1996 12:00:00 AM', '12/31/1996 12:00:00 AM', '12/24/1996 12:00:00 AM', 1, 0.45, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10372, N'QUEEN', 5, '12/4/1996 12:00:00 AM', '1/1/1997 12:00:00 AM', '12/9/1996 12:00:00 AM', 2, 890.78, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10373, N'HUNGO', 4, '12/5/1996 12:00:00 AM', '1/2/1997 12:00:00 AM', '12/11/1996 12:00:00 AM', 3, 124.12, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10374, N'WOLZA', 1, '12/5/1996 12:00:00 AM', '1/2/1997 12:00:00 AM', '12/9/1996 12:00:00 AM', 3, 3.94, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10375, N'HUNGC', 3, '12/6/1996 12:00:00 AM', '1/3/1997 12:00:00 AM', '12/9/1996 12:00:00 AM', 2, 20.12, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10376, N'MEREP', 1, '12/9/1996 12:00:00 AM', '1/6/1997 12:00:00 AM', '12/13/1996 12:00:00 AM', 2, 20.39, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10377, N'SEVES', 1, '12/9/1996 12:00:00 AM', '1/6/1997 12:00:00 AM', '12/13/1996 12:00:00 AM', 3, 22.21, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10378, N'FOLKO', 5, '12/10/1996 12:00:00 AM', '1/7/1997 12:00:00 AM', '12/19/1996 12:00:00 AM', 3, 5.44, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10379, N'QUEDE', 2, '12/11/1996 12:00:00 AM', '1/8/1997 12:00:00 AM', '12/13/1996 12:00:00 AM', 1, 45.03, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10380, N'HUNGO', 8, '12/12/1996 12:00:00 AM', '1/9/1997 12:00:00 AM', '1/16/1997 12:00:00 AM', 3, 35.03, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10381, N'LILAS', 3, '12/12/1996 12:00:00 AM', '1/9/1997 12:00:00 AM', '12/13/1996 12:00:00 AM', 3, 7.99, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10382, N'ERNSH', 4, '12/13/1996 12:00:00 AM', '1/10/1997 12:00:00 AM', '12/16/1996 12:00:00 AM', 1, 94.77, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10383, N'AROUT', 8, '12/16/1996 12:00:00 AM', '1/13/1997 12:00:00 AM', '12/18/1996 12:00:00 AM', 3, 34.24, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10384, N'BERGS', 3, '12/16/1996 12:00:00 AM', '1/13/1997 12:00:00 AM', '12/20/1996 12:00:00 AM', 3, 168.64, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10385, N'SPLIR', 1, '12/17/1996 12:00:00 AM', '1/14/1997 12:00:00 AM', '12/23/1996 12:00:00 AM', 2, 30.96, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10386, N'FAMIA', 9, '12/18/1996 12:00:00 AM', '1/1/1997 12:00:00 AM', '12/25/1996 12:00:00 AM', 3, 13.99, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10387, N'SANTG', 1, '12/18/1996 12:00:00 AM', '1/15/1997 12:00:00 AM', '12/20/1996 12:00:00 AM', 2, 93.63, N'Sant? Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10388, N'SEVES', 2, '12/19/1996 12:00:00 AM', '1/16/1997 12:00:00 AM', '12/20/1996 12:00:00 AM', 1, 34.86, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10389, N'BOTTM', 4, '12/20/1996 12:00:00 AM', '1/17/1997 12:00:00 AM', '12/24/1996 12:00:00 AM', 2, 47.42, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10390, N'ERNSH', 6, '12/23/1996 12:00:00 AM', '1/20/1997 12:00:00 AM', '12/26/1996 12:00:00 AM', 1, 126.38, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10391, N'DRACD', 3, '12/23/1996 12:00:00 AM', '1/20/1997 12:00:00 AM', '12/31/1996 12:00:00 AM', 3, 5.45, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10392, N'PICCO', 2, '12/24/1996 12:00:00 AM', '1/21/1997 12:00:00 AM', '1/1/1997 12:00:00 AM', 3, 122.46, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10393, N'SAVEA', 1, '12/25/1996 12:00:00 AM', '1/22/1997 12:00:00 AM', '1/3/1997 12:00:00 AM', 3, 126.56, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10394, N'HUNGC', 1, '12/25/1996 12:00:00 AM', '1/22/1997 12:00:00 AM', '1/3/1997 12:00:00 AM', 3, 30.34, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10395, N'HILAA', 6, '12/26/1996 12:00:00 AM', '1/23/1997 12:00:00 AM', '1/3/1997 12:00:00 AM', 1, 184.41, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10396, N'FRANK', 1, '12/27/1996 12:00:00 AM', '1/10/1997 12:00:00 AM', '1/6/1997 12:00:00 AM', 3, 135.35, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10397, N'PRINI', 5, '12/27/1996 12:00:00 AM', '1/24/1997 12:00:00 AM', '1/2/1997 12:00:00 AM', 1, 60.26, N'Princesa Isabel Vinhos', N'Estrada da sa?de n. 58', N'Lisboa', NULL, N'1756', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10398, N'SAVEA', 2, '12/30/1996 12:00:00 AM', '1/27/1997 12:00:00 AM', '1/9/1997 12:00:00 AM', 3, 89.16, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10399, N'VAFFE', 8, '12/31/1996 12:00:00 AM', '1/14/1997 12:00:00 AM', '1/8/1997 12:00:00 AM', 3, 27.36, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10400, N'EASTC', 1, '1/1/1997 12:00:00 AM', '1/29/1997 12:00:00 AM', '1/16/1997 12:00:00 AM', 3, 83.93, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10401, N'RATTC', 1, '1/1/1997 12:00:00 AM', '1/29/1997 12:00:00 AM', '1/10/1997 12:00:00 AM', 1, 12.51, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10402, N'ERNSH', 8, '1/2/1997 12:00:00 AM', '2/13/1997 12:00:00 AM', '1/10/1997 12:00:00 AM', 2, 67.88, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10403, N'ERNSH', 4, '1/3/1997 12:00:00 AM', '1/31/1997 12:00:00 AM', '1/9/1997 12:00:00 AM', 3, 73.79, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10404, N'MAGAA', 2, '1/3/1997 12:00:00 AM', '1/31/1997 12:00:00 AM', '1/8/1997 12:00:00 AM', 1, 155.97, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10405, N'LINOD', 1, '1/6/1997 12:00:00 AM', '2/3/1997 12:00:00 AM', '1/22/1997 12:00:00 AM', 1, 34.82, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10406, N'QUEEN', 7, '1/7/1997 12:00:00 AM', '2/18/1997 12:00:00 AM', '1/13/1997 12:00:00 AM', 1, 108.04, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10407, N'OTTIK', 2, '1/7/1997 12:00:00 AM', '2/4/1997 12:00:00 AM', '1/30/1997 12:00:00 AM', 2, 91.48, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10408, N'FOLIG', 8, '1/8/1997 12:00:00 AM', '2/5/1997 12:00:00 AM', '1/14/1997 12:00:00 AM', 1, 11.26, N'Folies gourmandes', N'184, chauss?e de Tournai', N'Lille', NULL, N'59000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10409, N'OCEAN', 3, '1/9/1997 12:00:00 AM', '2/6/1997 12:00:00 AM', '1/14/1997 12:00:00 AM', 1, 29.83, N'Oc?ano Atl?ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10410, N'BOTTM', 3, '1/10/1997 12:00:00 AM', '2/7/1997 12:00:00 AM', '1/15/1997 12:00:00 AM', 3, 2.4, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10411, N'BOTTM', 9, '1/10/1997 12:00:00 AM', '2/7/1997 12:00:00 AM', '1/21/1997 12:00:00 AM', 3, 23.65, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10412, N'WARTH', 8, '1/13/1997 12:00:00 AM', '2/10/1997 12:00:00 AM', '1/15/1997 12:00:00 AM', 2, 3.77, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10413, N'LAMAI', 3, '1/14/1997 12:00:00 AM', '2/11/1997 12:00:00 AM', '1/16/1997 12:00:00 AM', 2, 95.66, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10414, N'FAMIA', 2, '1/14/1997 12:00:00 AM', '2/11/1997 12:00:00 AM', '1/17/1997 12:00:00 AM', 3, 21.48, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10415, N'HUNGC', 3, '1/15/1997 12:00:00 AM', '2/12/1997 12:00:00 AM', '1/24/1997 12:00:00 AM', 1, 0.2, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10416, N'WARTH', 8, '1/16/1997 12:00:00 AM', '2/13/1997 12:00:00 AM', '1/27/1997 12:00:00 AM', 3, 22.72, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10417, N'SIMOB', 4, '1/16/1997 12:00:00 AM', '2/13/1997 12:00:00 AM', '1/28/1997 12:00:00 AM', 3, 70.29, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10418, N'QUICK', 4, '1/17/1997 12:00:00 AM', '2/14/1997 12:00:00 AM', '1/24/1997 12:00:00 AM', 1, 17.55, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10419, N'RICSU', 4, '1/20/1997 12:00:00 AM', '2/17/1997 12:00:00 AM', '1/30/1997 12:00:00 AM', 2, 137.35, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10420, N'WELLI', 3, '1/21/1997 12:00:00 AM', '2/18/1997 12:00:00 AM', '1/27/1997 12:00:00 AM', 1, 44.12, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10421, N'QUEDE', 8, '1/21/1997 12:00:00 AM', '3/4/1997 12:00:00 AM', '1/27/1997 12:00:00 AM', 1, 99.23, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10422, N'FRANS', 2, '1/22/1997 12:00:00 AM', '2/19/1997 12:00:00 AM', '1/31/1997 12:00:00 AM', 1, 3.02, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10423, N'GOURL', 6, '1/23/1997 12:00:00 AM', '2/6/1997 12:00:00 AM', '2/24/1997 12:00:00 AM', 3, 24.5, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10424, N'MEREP', 7, '1/23/1997 12:00:00 AM', '2/20/1997 12:00:00 AM', '1/27/1997 12:00:00 AM', 2, 370.61, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10425, N'LAMAI', 6, '1/24/1997 12:00:00 AM', '2/21/1997 12:00:00 AM', '2/14/1997 12:00:00 AM', 2, 7.93, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10426, N'GALED', 4, '1/27/1997 12:00:00 AM', '2/24/1997 12:00:00 AM', '2/6/1997 12:00:00 AM', 1, 18.69, N'Galer?a del gastron?mo', N'Rambla de Catalu?a, 23', N'Barcelona', NULL, N'8022', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10427, N'PICCO', 4, '1/27/1997 12:00:00 AM', '2/24/1997 12:00:00 AM', '3/3/1997 12:00:00 AM', 2, 31.29, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10428, N'REGGC', 7, '1/28/1997 12:00:00 AM', '2/25/1997 12:00:00 AM', '2/4/1997 12:00:00 AM', 1, 11.09, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10429, N'HUNGO', 3, '1/29/1997 12:00:00 AM', '3/12/1997 12:00:00 AM', '2/7/1997 12:00:00 AM', 2, 56.63, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10430, N'ERNSH', 4, '1/30/1997 12:00:00 AM', '2/13/1997 12:00:00 AM', '2/3/1997 12:00:00 AM', 1, 458.78, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10431, N'BOTTM', 4, '1/30/1997 12:00:00 AM', '2/13/1997 12:00:00 AM', '2/7/1997 12:00:00 AM', 2, 44.17, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10432, N'SPLIR', 3, '1/31/1997 12:00:00 AM', '2/14/1997 12:00:00 AM', '2/7/1997 12:00:00 AM', 2, 4.34, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10433, N'PRINI', 3, '2/3/1997 12:00:00 AM', '3/3/1997 12:00:00 AM', '3/4/1997 12:00:00 AM', 3, 73.83, N'Princesa Isabel Vinhos', N'Estrada da sa?de n. 58', N'Lisboa', NULL, N'1756', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10434, N'FOLKO', 3, '2/3/1997 12:00:00 AM', '3/3/1997 12:00:00 AM', '2/13/1997 12:00:00 AM', 2, 17.92, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10435, N'CONSH', 8, '2/4/1997 12:00:00 AM', '3/18/1997 12:00:00 AM', '2/7/1997 12:00:00 AM', 2, 9.21, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10436, N'BLONP', 3, '2/5/1997 12:00:00 AM', '3/5/1997 12:00:00 AM', '2/11/1997 12:00:00 AM', 2, 156.66, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10437, N'WARTH', 8, '2/5/1997 12:00:00 AM', '3/5/1997 12:00:00 AM', '2/12/1997 12:00:00 AM', 1, 19.97, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10438, N'TOMSP', 3, '2/6/1997 12:00:00 AM', '3/6/1997 12:00:00 AM', '2/14/1997 12:00:00 AM', 2, 8.24, N'Toms Spezialit?ten', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10439, N'MEREP', 6, '2/7/1997 12:00:00 AM', '3/7/1997 12:00:00 AM', '2/10/1997 12:00:00 AM', 3, 4.07, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10440, N'SAVEA', 4, '2/10/1997 12:00:00 AM', '3/10/1997 12:00:00 AM', '2/28/1997 12:00:00 AM', 2, 86.53, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10441, N'OLDWO', 3, '2/10/1997 12:00:00 AM', '3/24/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', 2, 73.02, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10442, N'ERNSH', 3, '2/11/1997 12:00:00 AM', '3/11/1997 12:00:00 AM', '2/18/1997 12:00:00 AM', 2, 47.94, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10443, N'REGGC', 8, '2/12/1997 12:00:00 AM', '3/12/1997 12:00:00 AM', '2/14/1997 12:00:00 AM', 1, 13.95, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10444, N'BERGS', 3, '2/12/1997 12:00:00 AM', '3/12/1997 12:00:00 AM', '2/21/1997 12:00:00 AM', 3, 3.5, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10445, N'BERGS', 3, '2/13/1997 12:00:00 AM', '3/13/1997 12:00:00 AM', '2/20/1997 12:00:00 AM', 1, 9.3, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10446, N'TOMSP', 6, '2/14/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', '2/19/1997 12:00:00 AM', 1, 14.68, N'Toms Spezialit?ten', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10447, N'RICAR', 4, '2/14/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', '3/7/1997 12:00:00 AM', 2, 68.66, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10448, N'RANCH', 4, '2/17/1997 12:00:00 AM', '3/17/1997 12:00:00 AM', '2/24/1997 12:00:00 AM', 2, 38.82, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10449, N'BLONP', 3, '2/18/1997 12:00:00 AM', '3/18/1997 12:00:00 AM', '2/27/1997 12:00:00 AM', 2, 53.3, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10450, N'VICTE', 8, '2/19/1997 12:00:00 AM', '3/19/1997 12:00:00 AM', '3/11/1997 12:00:00 AM', 2, 7.23, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10451, N'QUICK', 4, '2/19/1997 12:00:00 AM', '3/5/1997 12:00:00 AM', '3/12/1997 12:00:00 AM', 3, 189.09, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10452, N'SAVEA', 8, '2/20/1997 12:00:00 AM', '3/20/1997 12:00:00 AM', '2/26/1997 12:00:00 AM', 1, 140.26, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10453, N'AROUT', 1, '2/21/1997 12:00:00 AM', '3/21/1997 12:00:00 AM', '2/26/1997 12:00:00 AM', 2, 25.36, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10454, N'LAMAI', 4, '2/21/1997 12:00:00 AM', '3/21/1997 12:00:00 AM', '2/25/1997 12:00:00 AM', 3, 2.74, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10455, N'WARTH', 8, '2/24/1997 12:00:00 AM', '4/7/1997 12:00:00 AM', '3/3/1997 12:00:00 AM', 2, 180.45, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10456, N'KOENE', 8, '2/25/1997 12:00:00 AM', '4/8/1997 12:00:00 AM', '2/28/1997 12:00:00 AM', 2, 8.12, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10457, N'KOENE', 2, '2/25/1997 12:00:00 AM', '3/25/1997 12:00:00 AM', '3/3/1997 12:00:00 AM', 1, 11.57, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10458, N'SUPRD', 7, '2/26/1997 12:00:00 AM', '3/26/1997 12:00:00 AM', '3/4/1997 12:00:00 AM', 3, 147.06, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10459, N'VICTE', 4, '2/27/1997 12:00:00 AM', '3/27/1997 12:00:00 AM', '2/28/1997 12:00:00 AM', 2, 25.09, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10460, N'FOLKO', 8, '2/28/1997 12:00:00 AM', '3/28/1997 12:00:00 AM', '3/3/1997 12:00:00 AM', 1, 16.27, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10461, N'LILAS', 1, '2/28/1997 12:00:00 AM', '3/28/1997 12:00:00 AM', '3/5/1997 12:00:00 AM', 3, 148.61, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10462, N'CONSH', 2, '3/3/1997 12:00:00 AM', '3/31/1997 12:00:00 AM', '3/18/1997 12:00:00 AM', 1, 6.17, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10463, N'SUPRD', 5, '3/4/1997 12:00:00 AM', '4/1/1997 12:00:00 AM', '3/6/1997 12:00:00 AM', 3, 14.78, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10464, N'FURIB', 4, '3/4/1997 12:00:00 AM', '4/1/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', 2, 89, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10465, N'VAFFE', 1, '3/5/1997 12:00:00 AM', '4/2/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', 3, 145.04, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10466, N'COMMI', 4, '3/6/1997 12:00:00 AM', '4/3/1997 12:00:00 AM', '3/13/1997 12:00:00 AM', 1, 11.93, N'Com?rcio Mineiro', N'Av. dos Lus?adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10467, N'MAGAA', 8, '3/6/1997 12:00:00 AM', '4/3/1997 12:00:00 AM', '3/11/1997 12:00:00 AM', 2, 4.93, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10468, N'KOENE', 3, '3/7/1997 12:00:00 AM', '4/4/1997 12:00:00 AM', '3/12/1997 12:00:00 AM', 3, 44.12, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10469, N'WHITC', 1, '3/10/1997 12:00:00 AM', '4/7/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', 1, 60.18, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10470, N'BONAP', 4, '3/11/1997 12:00:00 AM', '4/8/1997 12:00:00 AM', '3/14/1997 12:00:00 AM', 2, 64.56, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10471, N'BSBEV', 2, '3/11/1997 12:00:00 AM', '4/8/1997 12:00:00 AM', '3/18/1997 12:00:00 AM', 3, 45.59, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10472, N'SEVES', 8, '3/12/1997 12:00:00 AM', '4/9/1997 12:00:00 AM', '3/19/1997 12:00:00 AM', 1, 4.2, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10473, N'ISLAT', 1, '3/13/1997 12:00:00 AM', '3/27/1997 12:00:00 AM', '3/21/1997 12:00:00 AM', 3, 16.37, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10474, N'PERIC', 5, '3/13/1997 12:00:00 AM', '4/10/1997 12:00:00 AM', '3/21/1997 12:00:00 AM', 2, 83.49, N'Pericles Comidas cl?sicas', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10475, N'SUPRD', 9, '3/14/1997 12:00:00 AM', '4/11/1997 12:00:00 AM', '4/4/1997 12:00:00 AM', 1, 68.52, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10476, N'HILAA', 8, '3/17/1997 12:00:00 AM', '4/14/1997 12:00:00 AM', '3/24/1997 12:00:00 AM', 3, 4.41, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10477, N'PRINI', 5, '3/17/1997 12:00:00 AM', '4/14/1997 12:00:00 AM', '3/25/1997 12:00:00 AM', 2, 13.02, N'Princesa Isabel Vinhos', N'Estrada da sa?de n. 58', N'Lisboa', NULL, N'1756', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10478, N'VICTE', 2, '3/18/1997 12:00:00 AM', '4/1/1997 12:00:00 AM', '3/26/1997 12:00:00 AM', 3, 4.81, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10479, N'RATTC', 3, '3/19/1997 12:00:00 AM', '4/16/1997 12:00:00 AM', '3/21/1997 12:00:00 AM', 3, 708.95, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10480, N'FOLIG', 6, '3/20/1997 12:00:00 AM', '4/17/1997 12:00:00 AM', '3/24/1997 12:00:00 AM', 2, 1.35, N'Folies gourmandes', N'184, chauss?e de Tournai', N'Lille', NULL, N'59000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10481, N'RICAR', 8, '3/20/1997 12:00:00 AM', '4/17/1997 12:00:00 AM', '3/25/1997 12:00:00 AM', 2, 64.33, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10482, N'LAZYK', 1, '3/21/1997 12:00:00 AM', '4/18/1997 12:00:00 AM', '4/10/1997 12:00:00 AM', 3, 7.48, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10483, N'WHITC', 7, '3/24/1997 12:00:00 AM', '4/21/1997 12:00:00 AM', '4/25/1997 12:00:00 AM', 2, 15.28, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10484, N'BSBEV', 3, '3/24/1997 12:00:00 AM', '4/21/1997 12:00:00 AM', '4/1/1997 12:00:00 AM', 3, 6.88, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10485, N'LINOD', 4, '3/25/1997 12:00:00 AM', '4/8/1997 12:00:00 AM', '3/31/1997 12:00:00 AM', 2, 64.45, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10486, N'HILAA', 1, '3/26/1997 12:00:00 AM', '4/23/1997 12:00:00 AM', '4/2/1997 12:00:00 AM', 2, 30.53, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10487, N'QUEEN', 2, '3/26/1997 12:00:00 AM', '4/23/1997 12:00:00 AM', '3/28/1997 12:00:00 AM', 2, 71.07, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10488, N'FRANK', 8, '3/27/1997 12:00:00 AM', '4/24/1997 12:00:00 AM', '4/2/1997 12:00:00 AM', 2, 4.93, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10489, N'PICCO', 6, '3/28/1997 12:00:00 AM', '4/25/1997 12:00:00 AM', '4/9/1997 12:00:00 AM', 2, 5.29, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10490, N'HILAA', 7, '3/31/1997 12:00:00 AM', '4/28/1997 12:00:00 AM', '4/3/1997 12:00:00 AM', 2, 210.19, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10491, N'FURIB', 8, '3/31/1997 12:00:00 AM', '4/28/1997 12:00:00 AM', '4/8/1997 12:00:00 AM', 3, 16.96, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10492, N'BOTTM', 3, '4/1/1997 12:00:00 AM', '4/29/1997 12:00:00 AM', '4/11/1997 12:00:00 AM', 1, 62.89, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10493, N'LAMAI', 4, '4/2/1997 12:00:00 AM', '4/30/1997 12:00:00 AM', '4/10/1997 12:00:00 AM', 3, 10.64, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10494, N'COMMI', 4, '4/2/1997 12:00:00 AM', '4/30/1997 12:00:00 AM', '4/9/1997 12:00:00 AM', 2, 65.99, N'Com?rcio Mineiro', N'Av. dos Lus?adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10495, N'LAUGB', 3, '4/3/1997 12:00:00 AM', '5/1/1997 12:00:00 AM', '4/11/1997 12:00:00 AM', 3, 4.65, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10496, N'TRADH', 7, '4/4/1997 12:00:00 AM', '5/2/1997 12:00:00 AM', '4/7/1997 12:00:00 AM', 2, 46.77, N'Tradi?ao Hipermercados', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10497, N'LEHMS', 7, '4/4/1997 12:00:00 AM', '5/2/1997 12:00:00 AM', '4/7/1997 12:00:00 AM', 1, 36.21, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10498, N'HILAA', 8, '4/7/1997 12:00:00 AM', '5/5/1997 12:00:00 AM', '4/11/1997 12:00:00 AM', 2, 29.75, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10499, N'LILAS', 4, '4/8/1997 12:00:00 AM', '5/6/1997 12:00:00 AM', '4/16/1997 12:00:00 AM', 2, 102.02, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10500, N'LAMAI', 6, '4/9/1997 12:00:00 AM', '5/7/1997 12:00:00 AM', '4/17/1997 12:00:00 AM', 1, 42.68, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10501, N'BLAUS', 9, '4/9/1997 12:00:00 AM', '5/7/1997 12:00:00 AM', '4/16/1997 12:00:00 AM', 3, 8.85, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10502, N'PERIC', 2, '4/10/1997 12:00:00 AM', '5/8/1997 12:00:00 AM', '4/29/1997 12:00:00 AM', 1, 69.32, N'Pericles Comidas cl?sicas', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10503, N'HUNGO', 6, '4/11/1997 12:00:00 AM', '5/9/1997 12:00:00 AM', '4/16/1997 12:00:00 AM', 2, 16.74, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10504, N'WHITC', 4, '4/11/1997 12:00:00 AM', '5/9/1997 12:00:00 AM', '4/18/1997 12:00:00 AM', 3, 59.13, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10505, N'MEREP', 3, '4/14/1997 12:00:00 AM', '5/12/1997 12:00:00 AM', '4/21/1997 12:00:00 AM', 3, 7.13, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10506, N'KOENE', 9, '4/15/1997 12:00:00 AM', '5/13/1997 12:00:00 AM', '5/2/1997 12:00:00 AM', 2, 21.19, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10507, N'ANTON', 7, '4/15/1997 12:00:00 AM', '5/13/1997 12:00:00 AM', '4/22/1997 12:00:00 AM', 1, 47.45, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10508, N'OTTIK', 1, '4/16/1997 12:00:00 AM', '5/14/1997 12:00:00 AM', '5/13/1997 12:00:00 AM', 2, 4.99, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10509, N'BLAUS', 4, '4/17/1997 12:00:00 AM', '5/15/1997 12:00:00 AM', '4/29/1997 12:00:00 AM', 1, 0.15, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10510, N'SAVEA', 6, '4/18/1997 12:00:00 AM', '5/16/1997 12:00:00 AM', '4/28/1997 12:00:00 AM', 3, 367.63, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10511, N'BONAP', 4, '4/18/1997 12:00:00 AM', '5/16/1997 12:00:00 AM', '4/21/1997 12:00:00 AM', 3, 350.64, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10512, N'FAMIA', 7, '4/21/1997 12:00:00 AM', '5/19/1997 12:00:00 AM', '4/24/1997 12:00:00 AM', 2, 3.53, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10513, N'WANDK', 7, '4/22/1997 12:00:00 AM', '6/3/1997 12:00:00 AM', '4/28/1997 12:00:00 AM', 1, 105.65, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10514, N'ERNSH', 3, '4/22/1997 12:00:00 AM', '5/20/1997 12:00:00 AM', '5/16/1997 12:00:00 AM', 2, 789.95, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10515, N'QUICK', 2, '4/23/1997 12:00:00 AM', '5/7/1997 12:00:00 AM', '5/23/1997 12:00:00 AM', 1, 204.47, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10516, N'HUNGO', 2, '4/24/1997 12:00:00 AM', '5/22/1997 12:00:00 AM', '5/1/1997 12:00:00 AM', 3, 62.78, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10517, N'NORTS', 3, '4/24/1997 12:00:00 AM', '5/22/1997 12:00:00 AM', '4/29/1997 12:00:00 AM', 3, 32.07, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10518, N'TORTU', 4, '4/25/1997 12:00:00 AM', '5/9/1997 12:00:00 AM', '5/5/1997 12:00:00 AM', 2, 218.15, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10519, N'CHOPS', 6, '4/28/1997 12:00:00 AM', '5/26/1997 12:00:00 AM', '5/1/1997 12:00:00 AM', 3, 91.76, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10520, N'SANTG', 7, '4/29/1997 12:00:00 AM', '5/27/1997 12:00:00 AM', '5/1/1997 12:00:00 AM', 1, 13.37, N'Sant? Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10521, N'CACTU', 8, '4/29/1997 12:00:00 AM', '5/27/1997 12:00:00 AM', '5/2/1997 12:00:00 AM', 2, 17.22, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10522, N'LEHMS', 4, '4/30/1997 12:00:00 AM', '5/28/1997 12:00:00 AM', '5/6/1997 12:00:00 AM', 1, 45.33, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10523, N'SEVES', 7, '5/1/1997 12:00:00 AM', '5/29/1997 12:00:00 AM', '5/30/1997 12:00:00 AM', 2, 77.63, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10524, N'BERGS', 1, '5/1/1997 12:00:00 AM', '5/29/1997 12:00:00 AM', '5/7/1997 12:00:00 AM', 2, 244.79, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10525, N'BONAP', 1, '5/2/1997 12:00:00 AM', '5/30/1997 12:00:00 AM', '5/23/1997 12:00:00 AM', 2, 11.06, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10526, N'WARTH', 4, '5/5/1997 12:00:00 AM', '6/2/1997 12:00:00 AM', '5/15/1997 12:00:00 AM', 2, 58.59, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10527, N'QUICK', 7, '5/5/1997 12:00:00 AM', '6/2/1997 12:00:00 AM', '5/7/1997 12:00:00 AM', 1, 41.9, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10528, N'GREAL', 6, '5/6/1997 12:00:00 AM', '5/20/1997 12:00:00 AM', '5/9/1997 12:00:00 AM', 2, 3.35, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10529, N'MAISD', 5, '5/7/1997 12:00:00 AM', '6/4/1997 12:00:00 AM', '5/9/1997 12:00:00 AM', 2, 66.69, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10530, N'PICCO', 3, '5/8/1997 12:00:00 AM', '6/5/1997 12:00:00 AM', '5/12/1997 12:00:00 AM', 2, 339.22, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10531, N'OCEAN', 7, '5/8/1997 12:00:00 AM', '6/5/1997 12:00:00 AM', '5/19/1997 12:00:00 AM', 1, 8.12, N'Oc?ano Atl?ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10532, N'EASTC', 7, '5/9/1997 12:00:00 AM', '6/6/1997 12:00:00 AM', '5/12/1997 12:00:00 AM', 3, 74.46, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10533, N'FOLKO', 8, '5/12/1997 12:00:00 AM', '6/9/1997 12:00:00 AM', '5/22/1997 12:00:00 AM', 1, 188.04, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10534, N'LEHMS', 8, '5/12/1997 12:00:00 AM', '6/9/1997 12:00:00 AM', '5/14/1997 12:00:00 AM', 2, 27.94, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10535, N'ANTON', 4, '5/13/1997 12:00:00 AM', '6/10/1997 12:00:00 AM', '5/21/1997 12:00:00 AM', 1, 15.64, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10536, N'LEHMS', 3, '5/14/1997 12:00:00 AM', '6/11/1997 12:00:00 AM', '6/6/1997 12:00:00 AM', 2, 58.88, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10537, N'RICSU', 1, '5/14/1997 12:00:00 AM', '5/28/1997 12:00:00 AM', '5/19/1997 12:00:00 AM', 1, 78.85, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10538, N'BSBEV', 9, '5/15/1997 12:00:00 AM', '6/12/1997 12:00:00 AM', '5/16/1997 12:00:00 AM', 3, 4.87, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10539, N'BSBEV', 6, '5/16/1997 12:00:00 AM', '6/13/1997 12:00:00 AM', '5/23/1997 12:00:00 AM', 3, 12.36, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10540, N'QUICK', 3, '5/19/1997 12:00:00 AM', '6/16/1997 12:00:00 AM', '6/13/1997 12:00:00 AM', 3, 1007.64, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10541, N'HANAR', 2, '5/19/1997 12:00:00 AM', '6/16/1997 12:00:00 AM', '5/29/1997 12:00:00 AM', 1, 68.65, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10542, N'KOENE', 1, '5/20/1997 12:00:00 AM', '6/17/1997 12:00:00 AM', '5/26/1997 12:00:00 AM', 3, 10.95, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10543, N'LILAS', 8, '5/21/1997 12:00:00 AM', '6/18/1997 12:00:00 AM', '5/23/1997 12:00:00 AM', 2, 48.17, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10544, N'LONEP', 4, '5/21/1997 12:00:00 AM', '6/18/1997 12:00:00 AM', '5/30/1997 12:00:00 AM', 1, 24.91, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10545, N'LAZYK', 8, '5/22/1997 12:00:00 AM', '6/19/1997 12:00:00 AM', '6/26/1997 12:00:00 AM', 2, 11.92, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10546, N'VICTE', 1, '5/23/1997 12:00:00 AM', '6/20/1997 12:00:00 AM', '5/27/1997 12:00:00 AM', 3, 194.72, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10547, N'SEVES', 3, '5/23/1997 12:00:00 AM', '6/20/1997 12:00:00 AM', '6/2/1997 12:00:00 AM', 2, 178.43, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10548, N'TOMSP', 3, '5/26/1997 12:00:00 AM', '6/23/1997 12:00:00 AM', '6/2/1997 12:00:00 AM', 2, 1.43, N'Toms Spezialit?ten', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10549, N'QUICK', 5, '5/27/1997 12:00:00 AM', '6/10/1997 12:00:00 AM', '5/30/1997 12:00:00 AM', 1, 171.24, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10550, N'GODOS', 7, '5/28/1997 12:00:00 AM', '6/25/1997 12:00:00 AM', '6/6/1997 12:00:00 AM', 3, 4.32, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10551, N'FURIB', 4, '5/28/1997 12:00:00 AM', '7/9/1997 12:00:00 AM', '6/6/1997 12:00:00 AM', 3, 72.95, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10552, N'HILAA', 2, '5/29/1997 12:00:00 AM', '6/26/1997 12:00:00 AM', '6/5/1997 12:00:00 AM', 1, 83.22, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10553, N'WARTH', 2, '5/30/1997 12:00:00 AM', '6/27/1997 12:00:00 AM', '6/3/1997 12:00:00 AM', 2, 149.49, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10554, N'OTTIK', 4, '5/30/1997 12:00:00 AM', '6/27/1997 12:00:00 AM', '6/5/1997 12:00:00 AM', 3, 120.97, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10555, N'SAVEA', 6, '6/2/1997 12:00:00 AM', '6/30/1997 12:00:00 AM', '6/4/1997 12:00:00 AM', 3, 252.49, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10556, N'SIMOB', 2, '6/3/1997 12:00:00 AM', '7/15/1997 12:00:00 AM', '6/13/1997 12:00:00 AM', 1, 9.8, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10557, N'LEHMS', 9, '6/3/1997 12:00:00 AM', '6/17/1997 12:00:00 AM', '6/6/1997 12:00:00 AM', 2, 96.72, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10558, N'AROUT', 1, '6/4/1997 12:00:00 AM', '7/2/1997 12:00:00 AM', '6/10/1997 12:00:00 AM', 2, 72.97, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10559, N'BLONP', 6, '6/5/1997 12:00:00 AM', '7/3/1997 12:00:00 AM', '6/13/1997 12:00:00 AM', 1, 8.05, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10560, N'FRANK', 8, '6/6/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', '6/9/1997 12:00:00 AM', 1, 36.65, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10561, N'FOLKO', 2, '6/6/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', '6/9/1997 12:00:00 AM', 2, 242.21, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10562, N'REGGC', 1, '6/9/1997 12:00:00 AM', '7/7/1997 12:00:00 AM', '6/12/1997 12:00:00 AM', 1, 22.95, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10563, N'RICAR', 2, '6/10/1997 12:00:00 AM', '7/22/1997 12:00:00 AM', '6/24/1997 12:00:00 AM', 2, 60.43, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10564, N'RATTC', 4, '6/10/1997 12:00:00 AM', '7/8/1997 12:00:00 AM', '6/16/1997 12:00:00 AM', 3, 13.75, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10565, N'MEREP', 8, '6/11/1997 12:00:00 AM', '7/9/1997 12:00:00 AM', '6/18/1997 12:00:00 AM', 2, 7.15, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10566, N'BLONP', 9, '6/12/1997 12:00:00 AM', '7/10/1997 12:00:00 AM', '6/18/1997 12:00:00 AM', 1, 88.4, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10567, N'HUNGO', 1, '6/12/1997 12:00:00 AM', '7/10/1997 12:00:00 AM', '6/17/1997 12:00:00 AM', 1, 33.97, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10568, N'GALED', 3, '6/13/1997 12:00:00 AM', '7/11/1997 12:00:00 AM', '7/9/1997 12:00:00 AM', 3, 6.54, N'Galer?a del gastron?mo', N'Rambla de Catalu?a, 23', N'Barcelona', NULL, N'8022', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10569, N'RATTC', 5, '6/16/1997 12:00:00 AM', '7/14/1997 12:00:00 AM', '7/11/1997 12:00:00 AM', 1, 58.98, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10570, N'MEREP', 3, '6/17/1997 12:00:00 AM', '7/15/1997 12:00:00 AM', '6/19/1997 12:00:00 AM', 3, 188.99, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10571, N'ERNSH', 8, '6/17/1997 12:00:00 AM', '7/29/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', 3, 26.06, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10572, N'BERGS', 3, '6/18/1997 12:00:00 AM', '7/16/1997 12:00:00 AM', '6/25/1997 12:00:00 AM', 2, 116.43, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10573, N'ANTON', 7, '6/19/1997 12:00:00 AM', '7/17/1997 12:00:00 AM', '6/20/1997 12:00:00 AM', 3, 84.84, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10574, N'TRAIH', 4, '6/19/1997 12:00:00 AM', '7/17/1997 12:00:00 AM', '6/30/1997 12:00:00 AM', 2, 37.6, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10575, N'MORGK', 5, '6/20/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', '6/30/1997 12:00:00 AM', 1, 127.34, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10576, N'TORTU', 3, '6/23/1997 12:00:00 AM', '7/7/1997 12:00:00 AM', '6/30/1997 12:00:00 AM', 3, 18.56, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10577, N'TRAIH', 9, '6/23/1997 12:00:00 AM', '8/4/1997 12:00:00 AM', '6/30/1997 12:00:00 AM', 2, 25.41, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10578, N'BSBEV', 4, '6/24/1997 12:00:00 AM', '7/22/1997 12:00:00 AM', '7/25/1997 12:00:00 AM', 3, 29.6, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10579, N'LETSS', 1, '6/25/1997 12:00:00 AM', '7/23/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', 2, 13.73, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10580, N'OTTIK', 4, '6/26/1997 12:00:00 AM', '7/24/1997 12:00:00 AM', '7/1/1997 12:00:00 AM', 3, 75.89, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10581, N'FAMIA', 3, '6/26/1997 12:00:00 AM', '7/24/1997 12:00:00 AM', '7/2/1997 12:00:00 AM', 1, 3.01, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10582, N'BLAUS', 3, '6/27/1997 12:00:00 AM', '7/25/1997 12:00:00 AM', '7/14/1997 12:00:00 AM', 2, 27.71, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10583, N'WARTH', 2, '6/30/1997 12:00:00 AM', '7/28/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', 2, 7.28, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10584, N'BLONP', 4, '6/30/1997 12:00:00 AM', '7/28/1997 12:00:00 AM', '7/4/1997 12:00:00 AM', 1, 59.14, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10585, N'WELLI', 7, '7/1/1997 12:00:00 AM', '7/29/1997 12:00:00 AM', '7/10/1997 12:00:00 AM', 1, 13.41, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10586, N'REGGC', 9, '7/2/1997 12:00:00 AM', '7/30/1997 12:00:00 AM', '7/9/1997 12:00:00 AM', 1, 0.48, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10587, N'QUEDE', 1, '7/2/1997 12:00:00 AM', '7/30/1997 12:00:00 AM', '7/9/1997 12:00:00 AM', 1, 62.52, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10588, N'QUICK', 2, '7/3/1997 12:00:00 AM', '7/31/1997 12:00:00 AM', '7/10/1997 12:00:00 AM', 3, 194.67, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10589, N'GREAL', 8, '7/4/1997 12:00:00 AM', '8/1/1997 12:00:00 AM', '7/14/1997 12:00:00 AM', 2, 4.42, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10590, N'MEREP', 4, '7/7/1997 12:00:00 AM', '8/4/1997 12:00:00 AM', '7/14/1997 12:00:00 AM', 3, 44.77, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10591, N'VAFFE', 1, '7/7/1997 12:00:00 AM', '7/21/1997 12:00:00 AM', '7/16/1997 12:00:00 AM', 1, 55.92, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10592, N'LEHMS', 3, '7/8/1997 12:00:00 AM', '8/5/1997 12:00:00 AM', '7/16/1997 12:00:00 AM', 1, 32.1, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10593, N'LEHMS', 7, '7/9/1997 12:00:00 AM', '8/6/1997 12:00:00 AM', '8/13/1997 12:00:00 AM', 2, 174.2, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10594, N'OLDWO', 3, '7/9/1997 12:00:00 AM', '8/6/1997 12:00:00 AM', '7/16/1997 12:00:00 AM', 2, 5.24, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10595, N'ERNSH', 2, '7/10/1997 12:00:00 AM', '8/7/1997 12:00:00 AM', '7/14/1997 12:00:00 AM', 1, 96.78, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10596, N'WHITC', 8, '7/11/1997 12:00:00 AM', '8/8/1997 12:00:00 AM', '8/12/1997 12:00:00 AM', 1, 16.34, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10597, N'PICCO', 7, '7/11/1997 12:00:00 AM', '8/8/1997 12:00:00 AM', '7/18/1997 12:00:00 AM', 3, 35.12, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10598, N'RATTC', 1, '7/14/1997 12:00:00 AM', '8/11/1997 12:00:00 AM', '7/18/1997 12:00:00 AM', 3, 44.42, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10599, N'BSBEV', 6, '7/15/1997 12:00:00 AM', '8/26/1997 12:00:00 AM', '7/21/1997 12:00:00 AM', 3, 29.98, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10600, N'HUNGC', 4, '7/16/1997 12:00:00 AM', '8/13/1997 12:00:00 AM', '7/21/1997 12:00:00 AM', 1, 45.13, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10601, N'HILAA', 7, '7/16/1997 12:00:00 AM', '8/27/1997 12:00:00 AM', '7/22/1997 12:00:00 AM', 1, 58.3, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10602, N'VAFFE', 8, '7/17/1997 12:00:00 AM', '8/14/1997 12:00:00 AM', '7/22/1997 12:00:00 AM', 2, 2.92, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10603, N'SAVEA', 8, '7/18/1997 12:00:00 AM', '8/15/1997 12:00:00 AM', '8/8/1997 12:00:00 AM', 2, 48.77, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10604, N'FURIB', 1, '7/18/1997 12:00:00 AM', '8/15/1997 12:00:00 AM', '7/29/1997 12:00:00 AM', 1, 7.46, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10605, N'MEREP', 1, '7/21/1997 12:00:00 AM', '8/18/1997 12:00:00 AM', '7/29/1997 12:00:00 AM', 2, 379.13, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10606, N'TRADH', 4, '7/22/1997 12:00:00 AM', '8/19/1997 12:00:00 AM', '7/31/1997 12:00:00 AM', 3, 79.4, N'Tradi?ao Hipermercados', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10607, N'SAVEA', 5, '7/22/1997 12:00:00 AM', '8/19/1997 12:00:00 AM', '7/25/1997 12:00:00 AM', 1, 200.24, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10608, N'TOMSP', 4, '7/23/1997 12:00:00 AM', '8/20/1997 12:00:00 AM', '8/1/1997 12:00:00 AM', 2, 27.79, N'Toms Spezialit?ten', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10609, N'DUMON', 7, '7/24/1997 12:00:00 AM', '8/21/1997 12:00:00 AM', '7/30/1997 12:00:00 AM', 2, 1.85, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10610, N'LAMAI', 8, '7/25/1997 12:00:00 AM', '8/22/1997 12:00:00 AM', '8/6/1997 12:00:00 AM', 1, 26.78, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10611, N'WOLZA', 6, '7/25/1997 12:00:00 AM', '8/22/1997 12:00:00 AM', '8/1/1997 12:00:00 AM', 2, 80.65, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10612, N'SAVEA', 1, '7/28/1997 12:00:00 AM', '8/25/1997 12:00:00 AM', '8/1/1997 12:00:00 AM', 2, 544.08, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10613, N'HILAA', 4, '7/29/1997 12:00:00 AM', '8/26/1997 12:00:00 AM', '8/1/1997 12:00:00 AM', 2, 8.11, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10614, N'BLAUS', 8, '7/29/1997 12:00:00 AM', '8/26/1997 12:00:00 AM', '8/1/1997 12:00:00 AM', 3, 1.93, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10615, N'WILMK', 2, '7/30/1997 12:00:00 AM', '8/27/1997 12:00:00 AM', '8/6/1997 12:00:00 AM', 3, 0.75, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10616, N'GREAL', 1, '7/31/1997 12:00:00 AM', '8/28/1997 12:00:00 AM', '8/5/1997 12:00:00 AM', 2, 116.53, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10617, N'GREAL', 4, '7/31/1997 12:00:00 AM', '8/28/1997 12:00:00 AM', '8/4/1997 12:00:00 AM', 2, 18.53, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10618, N'MEREP', 1, '8/1/1997 12:00:00 AM', '9/12/1997 12:00:00 AM', '8/8/1997 12:00:00 AM', 1, 154.68, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10619, N'MEREP', 3, '8/4/1997 12:00:00 AM', '9/1/1997 12:00:00 AM', '8/7/1997 12:00:00 AM', 3, 91.05, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10620, N'LAUGB', 2, '8/5/1997 12:00:00 AM', '9/2/1997 12:00:00 AM', '8/14/1997 12:00:00 AM', 3, 0.94, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10621, N'ISLAT', 4, '8/5/1997 12:00:00 AM', '9/2/1997 12:00:00 AM', '8/11/1997 12:00:00 AM', 2, 23.73, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10622, N'RICAR', 4, '8/6/1997 12:00:00 AM', '9/3/1997 12:00:00 AM', '8/11/1997 12:00:00 AM', 3, 50.97, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10623, N'FRANK', 8, '8/7/1997 12:00:00 AM', '9/4/1997 12:00:00 AM', '8/12/1997 12:00:00 AM', 2, 97.18, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10624, N'THECR', 4, '8/7/1997 12:00:00 AM', '9/4/1997 12:00:00 AM', '8/19/1997 12:00:00 AM', 2, 94.8, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10625, N'ANATR', 3, '8/8/1997 12:00:00 AM', '9/5/1997 12:00:00 AM', '8/14/1997 12:00:00 AM', 1, 43.9, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci?n 2222', N'M?xico D.F.', NULL, N'05021', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10626, N'BERGS', 1, '8/11/1997 12:00:00 AM', '9/8/1997 12:00:00 AM', '8/20/1997 12:00:00 AM', 2, 138.69, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10627, N'SAVEA', 8, '8/11/1997 12:00:00 AM', '9/22/1997 12:00:00 AM', '8/21/1997 12:00:00 AM', 3, 107.46, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10628, N'BLONP', 4, '8/12/1997 12:00:00 AM', '9/9/1997 12:00:00 AM', '8/20/1997 12:00:00 AM', 3, 30.36, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10629, N'GODOS', 4, '8/12/1997 12:00:00 AM', '9/9/1997 12:00:00 AM', '8/20/1997 12:00:00 AM', 3, 85.46, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10630, N'KOENE', 1, '8/13/1997 12:00:00 AM', '9/10/1997 12:00:00 AM', '8/19/1997 12:00:00 AM', 2, 32.35, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10631, N'LAMAI', 8, '8/14/1997 12:00:00 AM', '9/11/1997 12:00:00 AM', '8/15/1997 12:00:00 AM', 1, 0.87, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10632, N'WANDK', 8, '8/14/1997 12:00:00 AM', '9/11/1997 12:00:00 AM', '8/19/1997 12:00:00 AM', 1, 41.38, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10633, N'ERNSH', 7, '8/15/1997 12:00:00 AM', '9/12/1997 12:00:00 AM', '8/18/1997 12:00:00 AM', 3, 477.9, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10634, N'FOLIG', 4, '8/15/1997 12:00:00 AM', '9/12/1997 12:00:00 AM', '8/21/1997 12:00:00 AM', 3, 487.38, N'Folies gourmandes', N'184, chauss?e de Tournai', N'Lille', NULL, N'59000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10635, N'MAGAA', 8, '8/18/1997 12:00:00 AM', '9/15/1997 12:00:00 AM', '8/21/1997 12:00:00 AM', 3, 47.46, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10636, N'WARTH', 4, '8/19/1997 12:00:00 AM', '9/16/1997 12:00:00 AM', '8/26/1997 12:00:00 AM', 1, 1.15, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10637, N'QUEEN', 6, '8/19/1997 12:00:00 AM', '9/16/1997 12:00:00 AM', '8/26/1997 12:00:00 AM', 1, 201.29, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10638, N'LINOD', 3, '8/20/1997 12:00:00 AM', '9/17/1997 12:00:00 AM', '9/1/1997 12:00:00 AM', 1, 158.44, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10639, N'SANTG', 7, '8/20/1997 12:00:00 AM', '9/17/1997 12:00:00 AM', '8/27/1997 12:00:00 AM', 3, 38.64, N'Sant? Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10640, N'WANDK', 4, '8/21/1997 12:00:00 AM', '9/18/1997 12:00:00 AM', '8/28/1997 12:00:00 AM', 1, 23.55, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10641, N'HILAA', 4, '8/22/1997 12:00:00 AM', '9/19/1997 12:00:00 AM', '8/26/1997 12:00:00 AM', 2, 179.61, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10642, N'SIMOB', 7, '8/22/1997 12:00:00 AM', '9/19/1997 12:00:00 AM', '9/5/1997 12:00:00 AM', 3, 41.89, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10643, N'ALFKI', 6, '8/25/1997 12:00:00 AM', '9/22/1997 12:00:00 AM', '9/2/1997 12:00:00 AM', 1, 29.46, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10644, N'WELLI', 3, '8/25/1997 12:00:00 AM', '9/22/1997 12:00:00 AM', '9/1/1997 12:00:00 AM', 2, 0.14, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10645, N'HANAR', 4, '8/26/1997 12:00:00 AM', '9/23/1997 12:00:00 AM', '9/2/1997 12:00:00 AM', 1, 12.41, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10646, N'HUNGO', 9, '8/27/1997 12:00:00 AM', '10/8/1997 12:00:00 AM', '9/3/1997 12:00:00 AM', 3, 142.33, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10647, N'QUEDE', 4, '8/27/1997 12:00:00 AM', '9/10/1997 12:00:00 AM', '9/3/1997 12:00:00 AM', 2, 45.54, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10648, N'RICAR', 5, '8/28/1997 12:00:00 AM', '10/9/1997 12:00:00 AM', '9/9/1997 12:00:00 AM', 2, 14.25, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10649, N'MAISD', 5, '8/28/1997 12:00:00 AM', '9/25/1997 12:00:00 AM', '8/29/1997 12:00:00 AM', 3, 6.2, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10650, N'FAMIA', 5, '8/29/1997 12:00:00 AM', '9/26/1997 12:00:00 AM', '9/3/1997 12:00:00 AM', 3, 176.81, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10651, N'WANDK', 8, '9/1/1997 12:00:00 AM', '9/29/1997 12:00:00 AM', '9/11/1997 12:00:00 AM', 2, 20.6, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10652, N'GOURL', 4, '9/1/1997 12:00:00 AM', '9/29/1997 12:00:00 AM', '9/8/1997 12:00:00 AM', 2, 7.14, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10653, N'FRANK', 1, '9/2/1997 12:00:00 AM', '9/30/1997 12:00:00 AM', '9/19/1997 12:00:00 AM', 1, 93.25, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10654, N'BERGS', 5, '9/2/1997 12:00:00 AM', '9/30/1997 12:00:00 AM', '9/11/1997 12:00:00 AM', 1, 55.26, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10655, N'REGGC', 1, '9/3/1997 12:00:00 AM', '10/1/1997 12:00:00 AM', '9/11/1997 12:00:00 AM', 2, 4.41, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10656, N'GREAL', 6, '9/4/1997 12:00:00 AM', '10/2/1997 12:00:00 AM', '9/10/1997 12:00:00 AM', 1, 57.15, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10657, N'SAVEA', 2, '9/4/1997 12:00:00 AM', '10/2/1997 12:00:00 AM', '9/15/1997 12:00:00 AM', 2, 352.69, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10658, N'QUICK', 4, '9/5/1997 12:00:00 AM', '10/3/1997 12:00:00 AM', '9/8/1997 12:00:00 AM', 1, 364.15, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10659, N'QUEEN', 7, '9/5/1997 12:00:00 AM', '10/3/1997 12:00:00 AM', '9/10/1997 12:00:00 AM', 2, 105.81, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10660, N'HUNGC', 8, '9/8/1997 12:00:00 AM', '10/6/1997 12:00:00 AM', '10/15/1997 12:00:00 AM', 1, 111.29, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10661, N'HUNGO', 7, '9/9/1997 12:00:00 AM', '10/7/1997 12:00:00 AM', '9/15/1997 12:00:00 AM', 3, 17.55, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10662, N'LONEP', 3, '9/9/1997 12:00:00 AM', '10/7/1997 12:00:00 AM', '9/18/1997 12:00:00 AM', 2, 1.28, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10663, N'BONAP', 2, '9/10/1997 12:00:00 AM', '9/24/1997 12:00:00 AM', '10/3/1997 12:00:00 AM', 2, 113.15, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10664, N'FURIB', 1, '9/10/1997 12:00:00 AM', '10/8/1997 12:00:00 AM', '9/19/1997 12:00:00 AM', 3, 1.27, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10665, N'LONEP', 1, '9/11/1997 12:00:00 AM', '10/9/1997 12:00:00 AM', '9/17/1997 12:00:00 AM', 2, 26.31, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10666, N'RICSU', 7, '9/12/1997 12:00:00 AM', '10/10/1997 12:00:00 AM', '9/22/1997 12:00:00 AM', 2, 232.42, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10667, N'ERNSH', 7, '9/12/1997 12:00:00 AM', '10/10/1997 12:00:00 AM', '9/19/1997 12:00:00 AM', 1, 78.09, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10668, N'WANDK', 1, '9/15/1997 12:00:00 AM', '10/13/1997 12:00:00 AM', '9/23/1997 12:00:00 AM', 2, 47.22, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10669, N'SIMOB', 2, '9/15/1997 12:00:00 AM', '10/13/1997 12:00:00 AM', '9/22/1997 12:00:00 AM', 1, 24.39, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10670, N'FRANK', 4, '9/16/1997 12:00:00 AM', '10/14/1997 12:00:00 AM', '9/18/1997 12:00:00 AM', 1, 203.48, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10671, N'FRANR', 1, '9/17/1997 12:00:00 AM', '10/15/1997 12:00:00 AM', '9/24/1997 12:00:00 AM', 1, 30.34, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10672, N'BERGS', 9, '9/17/1997 12:00:00 AM', '10/1/1997 12:00:00 AM', '9/26/1997 12:00:00 AM', 2, 95.75, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10673, N'WILMK', 2, '9/18/1997 12:00:00 AM', '10/16/1997 12:00:00 AM', '9/19/1997 12:00:00 AM', 1, 22.76, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10674, N'ISLAT', 4, '9/18/1997 12:00:00 AM', '10/16/1997 12:00:00 AM', '9/30/1997 12:00:00 AM', 2, 0.9, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10675, N'FRANK', 5, '9/19/1997 12:00:00 AM', '10/17/1997 12:00:00 AM', '9/23/1997 12:00:00 AM', 2, 31.85, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10676, N'TORTU', 2, '9/22/1997 12:00:00 AM', '10/20/1997 12:00:00 AM', '9/29/1997 12:00:00 AM', 2, 2.01, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10677, N'ANTON', 1, '9/22/1997 12:00:00 AM', '10/20/1997 12:00:00 AM', '9/26/1997 12:00:00 AM', 3, 4.03, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10678, N'SAVEA', 7, '9/23/1997 12:00:00 AM', '10/21/1997 12:00:00 AM', '10/16/1997 12:00:00 AM', 3, 388.98, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10679, N'BLONP', 8, '9/23/1997 12:00:00 AM', '10/21/1997 12:00:00 AM', '9/30/1997 12:00:00 AM', 3, 27.94, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10680, N'OLDWO', 1, '9/24/1997 12:00:00 AM', '10/22/1997 12:00:00 AM', '9/26/1997 12:00:00 AM', 1, 26.61, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10681, N'GREAL', 3, '9/25/1997 12:00:00 AM', '10/23/1997 12:00:00 AM', '9/30/1997 12:00:00 AM', 3, 76.13, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10682, N'ANTON', 3, '9/25/1997 12:00:00 AM', '10/23/1997 12:00:00 AM', '10/1/1997 12:00:00 AM', 2, 36.13, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10683, N'DUMON', 2, '9/26/1997 12:00:00 AM', '10/24/1997 12:00:00 AM', '10/1/1997 12:00:00 AM', 1, 4.4, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10684, N'OTTIK', 3, '9/26/1997 12:00:00 AM', '10/24/1997 12:00:00 AM', '9/30/1997 12:00:00 AM', 1, 145.63, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10685, N'GOURL', 4, '9/29/1997 12:00:00 AM', '10/13/1997 12:00:00 AM', '10/3/1997 12:00:00 AM', 2, 33.75, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10686, N'PICCO', 2, '9/30/1997 12:00:00 AM', '10/28/1997 12:00:00 AM', '10/8/1997 12:00:00 AM', 1, 96.5, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10687, N'HUNGO', 9, '9/30/1997 12:00:00 AM', '10/28/1997 12:00:00 AM', '10/30/1997 12:00:00 AM', 2, 296.43, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10688, N'VAFFE', 4, '10/1/1997 12:00:00 AM', '10/15/1997 12:00:00 AM', '10/7/1997 12:00:00 AM', 2, 299.09, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10689, N'BERGS', 1, '10/1/1997 12:00:00 AM', '10/29/1997 12:00:00 AM', '10/7/1997 12:00:00 AM', 2, 13.42, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10690, N'HANAR', 1, '10/2/1997 12:00:00 AM', '10/30/1997 12:00:00 AM', '10/3/1997 12:00:00 AM', 1, 15.8, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10691, N'QUICK', 2, '10/3/1997 12:00:00 AM', '11/14/1997 12:00:00 AM', '10/22/1997 12:00:00 AM', 2, 810.05, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10692, N'ALFKI', 4, '10/3/1997 12:00:00 AM', '10/31/1997 12:00:00 AM', '10/13/1997 12:00:00 AM', 2, 61.02, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10693, N'WHITC', 3, '10/6/1997 12:00:00 AM', '10/20/1997 12:00:00 AM', '10/10/1997 12:00:00 AM', 3, 139.34, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10694, N'QUICK', 8, '10/6/1997 12:00:00 AM', '11/3/1997 12:00:00 AM', '10/9/1997 12:00:00 AM', 3, 398.36, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10695, N'WILMK', 7, '10/7/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', '10/14/1997 12:00:00 AM', 1, 16.72, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10696, N'WHITC', 8, '10/8/1997 12:00:00 AM', '11/19/1997 12:00:00 AM', '10/14/1997 12:00:00 AM', 3, 102.55, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10697, N'LINOD', 3, '10/8/1997 12:00:00 AM', '11/5/1997 12:00:00 AM', '10/14/1997 12:00:00 AM', 1, 45.52, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10698, N'ERNSH', 4, '10/9/1997 12:00:00 AM', '11/6/1997 12:00:00 AM', '10/17/1997 12:00:00 AM', 1, 272.47, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10699, N'MORGK', 3, '10/9/1997 12:00:00 AM', '11/6/1997 12:00:00 AM', '10/13/1997 12:00:00 AM', 3, 0.58, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10700, N'SAVEA', 3, '10/10/1997 12:00:00 AM', '11/7/1997 12:00:00 AM', '10/16/1997 12:00:00 AM', 1, 65.1, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10701, N'HUNGO', 6, '10/13/1997 12:00:00 AM', '10/27/1997 12:00:00 AM', '10/15/1997 12:00:00 AM', 3, 220.31, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10702, N'ALFKI', 4, '10/13/1997 12:00:00 AM', '11/24/1997 12:00:00 AM', '10/21/1997 12:00:00 AM', 1, 23.94, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10703, N'FOLKO', 6, '10/14/1997 12:00:00 AM', '11/11/1997 12:00:00 AM', '10/20/1997 12:00:00 AM', 2, 152.3, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10704, N'QUEEN', 6, '10/14/1997 12:00:00 AM', '11/11/1997 12:00:00 AM', '11/7/1997 12:00:00 AM', 1, 4.78, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10705, N'HILAA', 9, '10/15/1997 12:00:00 AM', '11/12/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', 2, 3.52, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10706, N'OLDWO', 8, '10/16/1997 12:00:00 AM', '11/13/1997 12:00:00 AM', '10/21/1997 12:00:00 AM', 3, 135.63, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10707, N'AROUT', 4, '10/16/1997 12:00:00 AM', '10/30/1997 12:00:00 AM', '10/23/1997 12:00:00 AM', 3, 21.74, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10708, N'THEBI', 6, '10/17/1997 12:00:00 AM', '11/28/1997 12:00:00 AM', '11/5/1997 12:00:00 AM', 2, 2.96, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10709, N'GOURL', 1, '10/17/1997 12:00:00 AM', '11/14/1997 12:00:00 AM', '11/20/1997 12:00:00 AM', 3, 210.8, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10710, N'FRANS', 1, '10/20/1997 12:00:00 AM', '11/17/1997 12:00:00 AM', '10/23/1997 12:00:00 AM', 1, 4.98, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10711, N'SAVEA', 5, '10/21/1997 12:00:00 AM', '12/2/1997 12:00:00 AM', '10/29/1997 12:00:00 AM', 2, 52.41, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10712, N'HUNGO', 3, '10/21/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', '10/31/1997 12:00:00 AM', 1, 89.93, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10713, N'SAVEA', 1, '10/22/1997 12:00:00 AM', '11/19/1997 12:00:00 AM', '10/24/1997 12:00:00 AM', 1, 167.05, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10714, N'SAVEA', 5, '10/22/1997 12:00:00 AM', '11/19/1997 12:00:00 AM', '10/27/1997 12:00:00 AM', 3, 24.49, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10715, N'BONAP', 3, '10/23/1997 12:00:00 AM', '11/6/1997 12:00:00 AM', '10/29/1997 12:00:00 AM', 1, 63.2, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10716, N'RANCH', 4, '10/24/1997 12:00:00 AM', '11/21/1997 12:00:00 AM', '10/27/1997 12:00:00 AM', 2, 22.57, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10717, N'FRANK', 1, '10/24/1997 12:00:00 AM', '11/21/1997 12:00:00 AM', '10/29/1997 12:00:00 AM', 2, 59.25, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10718, N'KOENE', 1, '10/27/1997 12:00:00 AM', '11/24/1997 12:00:00 AM', '10/29/1997 12:00:00 AM', 3, 170.88, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10719, N'LETSS', 8, '10/27/1997 12:00:00 AM', '11/24/1997 12:00:00 AM', '11/5/1997 12:00:00 AM', 2, 51.44, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10720, N'QUEDE', 8, '10/28/1997 12:00:00 AM', '11/11/1997 12:00:00 AM', '11/5/1997 12:00:00 AM', 2, 9.53, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10721, N'QUICK', 5, '10/29/1997 12:00:00 AM', '11/26/1997 12:00:00 AM', '10/31/1997 12:00:00 AM', 3, 48.92, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10722, N'SAVEA', 8, '10/29/1997 12:00:00 AM', '12/10/1997 12:00:00 AM', '11/4/1997 12:00:00 AM', 1, 74.58, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10723, N'WHITC', 3, '10/30/1997 12:00:00 AM', '11/27/1997 12:00:00 AM', '11/25/1997 12:00:00 AM', 1, 21.72, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10724, N'MEREP', 8, '10/30/1997 12:00:00 AM', '12/11/1997 12:00:00 AM', '11/5/1997 12:00:00 AM', 2, 57.75, N'M?re Paillarde', N'43 rue St. Laurent', N'Montr?al', N'Qu?bec', N'H1J 1C3', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10725, N'FAMIA', 4, '10/31/1997 12:00:00 AM', '11/28/1997 12:00:00 AM', '11/5/1997 12:00:00 AM', 3, 10.83, N'Familia Arquibaldo', N'Rua Or?s, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10726, N'EASTC', 4, '11/3/1997 12:00:00 AM', '11/17/1997 12:00:00 AM', '12/5/1997 12:00:00 AM', 1, 16.56, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10727, N'REGGC', 2, '11/3/1997 12:00:00 AM', '12/1/1997 12:00:00 AM', '12/5/1997 12:00:00 AM', 1, 89.9, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10728, N'QUEEN', 4, '11/4/1997 12:00:00 AM', '12/2/1997 12:00:00 AM', '11/11/1997 12:00:00 AM', 2, 58.33, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10729, N'LINOD', 8, '11/4/1997 12:00:00 AM', '12/16/1997 12:00:00 AM', '11/14/1997 12:00:00 AM', 3, 141.06, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10730, N'BONAP', 5, '11/5/1997 12:00:00 AM', '12/3/1997 12:00:00 AM', '11/14/1997 12:00:00 AM', 1, 20.12, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10731, N'CHOPS', 7, '11/6/1997 12:00:00 AM', '12/4/1997 12:00:00 AM', '11/14/1997 12:00:00 AM', 1, 96.65, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10732, N'BONAP', 3, '11/6/1997 12:00:00 AM', '12/4/1997 12:00:00 AM', '11/7/1997 12:00:00 AM', 1, 16.97, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10733, N'BERGS', 1, '11/7/1997 12:00:00 AM', '12/5/1997 12:00:00 AM', '11/10/1997 12:00:00 AM', 3, 110.11, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10734, N'GOURL', 2, '11/7/1997 12:00:00 AM', '12/5/1997 12:00:00 AM', '11/12/1997 12:00:00 AM', 3, 1.63, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10735, N'LETSS', 6, '11/10/1997 12:00:00 AM', '12/8/1997 12:00:00 AM', '11/21/1997 12:00:00 AM', 2, 45.97, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10736, N'HUNGO', 9, '11/11/1997 12:00:00 AM', '12/9/1997 12:00:00 AM', '11/21/1997 12:00:00 AM', 2, 44.1, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10737, N'VINET', 2, '11/11/1997 12:00:00 AM', '12/9/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', 2, 7.79, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10738, N'SPECD', 2, '11/12/1997 12:00:00 AM', '12/10/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', 1, 2.91, N'Sp?cialit?s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10739, N'VINET', 3, '11/12/1997 12:00:00 AM', '12/10/1997 12:00:00 AM', '11/17/1997 12:00:00 AM', 3, 11.08, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10740, N'WHITC', 4, '11/13/1997 12:00:00 AM', '12/11/1997 12:00:00 AM', '11/25/1997 12:00:00 AM', 2, 81.88, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10741, N'AROUT', 4, '11/14/1997 12:00:00 AM', '11/28/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', 3, 10.96, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10742, N'BOTTM', 3, '11/14/1997 12:00:00 AM', '12/12/1997 12:00:00 AM', '11/18/1997 12:00:00 AM', 3, 243.73, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10743, N'AROUT', 1, '11/17/1997 12:00:00 AM', '12/15/1997 12:00:00 AM', '11/21/1997 12:00:00 AM', 2, 23.72, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10744, N'VAFFE', 6, '11/17/1997 12:00:00 AM', '12/15/1997 12:00:00 AM', '11/24/1997 12:00:00 AM', 1, 69.19, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10745, N'QUICK', 9, '11/18/1997 12:00:00 AM', '12/16/1997 12:00:00 AM', '11/27/1997 12:00:00 AM', 1, 3.52, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10746, N'CHOPS', 1, '11/19/1997 12:00:00 AM', '12/17/1997 12:00:00 AM', '11/21/1997 12:00:00 AM', 3, 31.43, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10747, N'PICCO', 6, '11/19/1997 12:00:00 AM', '12/17/1997 12:00:00 AM', '11/26/1997 12:00:00 AM', 1, 117.33, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10748, N'SAVEA', 3, '11/20/1997 12:00:00 AM', '12/18/1997 12:00:00 AM', '11/28/1997 12:00:00 AM', 1, 232.55, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10749, N'ISLAT', 4, '11/20/1997 12:00:00 AM', '12/18/1997 12:00:00 AM', '12/19/1997 12:00:00 AM', 2, 61.53, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10750, N'WARTH', 9, '11/21/1997 12:00:00 AM', '12/19/1997 12:00:00 AM', '11/24/1997 12:00:00 AM', 1, 79.3, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10751, N'RICSU', 3, '11/24/1997 12:00:00 AM', '12/22/1997 12:00:00 AM', '12/3/1997 12:00:00 AM', 3, 130.79, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10752, N'NORTS', 2, '11/24/1997 12:00:00 AM', '12/22/1997 12:00:00 AM', '11/28/1997 12:00:00 AM', 3, 1.39, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10753, N'FRANS', 3, '11/25/1997 12:00:00 AM', '12/23/1997 12:00:00 AM', '11/27/1997 12:00:00 AM', 1, 7.7, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10754, N'MAGAA', 6, '11/25/1997 12:00:00 AM', '12/23/1997 12:00:00 AM', '11/27/1997 12:00:00 AM', 3, 2.38, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10755, N'BONAP', 4, '11/26/1997 12:00:00 AM', '12/24/1997 12:00:00 AM', '11/28/1997 12:00:00 AM', 2, 16.71, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10756, N'SPLIR', 8, '11/27/1997 12:00:00 AM', '12/25/1997 12:00:00 AM', '12/2/1997 12:00:00 AM', 2, 73.21, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10757, N'SAVEA', 6, '11/27/1997 12:00:00 AM', '12/25/1997 12:00:00 AM', '12/15/1997 12:00:00 AM', 1, 8.19, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10758, N'RICSU', 3, '11/28/1997 12:00:00 AM', '12/26/1997 12:00:00 AM', '12/4/1997 12:00:00 AM', 3, 138.17, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10759, N'ANATR', 3, '11/28/1997 12:00:00 AM', '12/26/1997 12:00:00 AM', '12/12/1997 12:00:00 AM', 3, 11.99, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci?n 2222', N'M?xico D.F.', NULL, N'05021', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10760, N'MAISD', 4, '12/1/1997 12:00:00 AM', '12/29/1997 12:00:00 AM', '12/10/1997 12:00:00 AM', 1, 155.64, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10761, N'RATTC', 5, '12/2/1997 12:00:00 AM', '12/30/1997 12:00:00 AM', '12/8/1997 12:00:00 AM', 2, 18.66, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10762, N'FOLKO', 3, '12/2/1997 12:00:00 AM', '12/30/1997 12:00:00 AM', '12/9/1997 12:00:00 AM', 1, 328.74, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10763, N'FOLIG', 3, '12/3/1997 12:00:00 AM', '12/31/1997 12:00:00 AM', '12/8/1997 12:00:00 AM', 3, 37.35, N'Folies gourmandes', N'184, chauss?e de Tournai', N'Lille', NULL, N'59000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10764, N'ERNSH', 6, '12/3/1997 12:00:00 AM', '12/31/1997 12:00:00 AM', '12/8/1997 12:00:00 AM', 3, 145.45, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10765, N'QUICK', 3, '12/4/1997 12:00:00 AM', '1/1/1998 12:00:00 AM', '12/9/1997 12:00:00 AM', 3, 42.74, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10766, N'OTTIK', 4, '12/5/1997 12:00:00 AM', '1/2/1998 12:00:00 AM', '12/9/1997 12:00:00 AM', 1, 157.55, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10767, N'SUPRD', 4, '12/5/1997 12:00:00 AM', '1/2/1998 12:00:00 AM', '12/15/1997 12:00:00 AM', 3, 1.59, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10768, N'AROUT', 3, '12/8/1997 12:00:00 AM', '1/5/1998 12:00:00 AM', '12/15/1997 12:00:00 AM', 2, 146.32, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10769, N'VAFFE', 3, '12/8/1997 12:00:00 AM', '1/5/1998 12:00:00 AM', '12/12/1997 12:00:00 AM', 1, 65.06, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10770, N'HANAR', 8, '12/9/1997 12:00:00 AM', '1/6/1998 12:00:00 AM', '12/17/1997 12:00:00 AM', 3, 5.32, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10771, N'ERNSH', 9, '12/10/1997 12:00:00 AM', '1/7/1998 12:00:00 AM', '1/2/1998 12:00:00 AM', 2, 11.19, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10772, N'LEHMS', 3, '12/10/1997 12:00:00 AM', '1/7/1998 12:00:00 AM', '12/19/1997 12:00:00 AM', 2, 91.28, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10773, N'ERNSH', 1, '12/11/1997 12:00:00 AM', '1/8/1998 12:00:00 AM', '12/16/1997 12:00:00 AM', 3, 96.43, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10774, N'FOLKO', 4, '12/11/1997 12:00:00 AM', '12/25/1997 12:00:00 AM', '12/12/1997 12:00:00 AM', 1, 48.2, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10775, N'THECR', 7, '12/12/1997 12:00:00 AM', '1/9/1998 12:00:00 AM', '12/26/1997 12:00:00 AM', 1, 20.25, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10776, N'ERNSH', 1, '12/15/1997 12:00:00 AM', '1/12/1998 12:00:00 AM', '12/18/1997 12:00:00 AM', 3, 351.53, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10777, N'GOURL', 7, '12/15/1997 12:00:00 AM', '12/29/1997 12:00:00 AM', '1/21/1998 12:00:00 AM', 2, 3.01, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10778, N'BERGS', 3, '12/16/1997 12:00:00 AM', '1/13/1998 12:00:00 AM', '12/24/1997 12:00:00 AM', 1, 6.79, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10779, N'MORGK', 3, '12/16/1997 12:00:00 AM', '1/13/1998 12:00:00 AM', '1/14/1998 12:00:00 AM', 2, 58.13, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10780, N'LILAS', 2, '12/16/1997 12:00:00 AM', '12/30/1997 12:00:00 AM', '12/25/1997 12:00:00 AM', 1, 42.13, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10781, N'WARTH', 2, '12/17/1997 12:00:00 AM', '1/14/1998 12:00:00 AM', '12/19/1997 12:00:00 AM', 3, 73.16, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10782, N'CACTU', 9, '12/17/1997 12:00:00 AM', '1/14/1998 12:00:00 AM', '12/22/1997 12:00:00 AM', 3, 1.1, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10783, N'HANAR', 4, '12/18/1997 12:00:00 AM', '1/15/1998 12:00:00 AM', '12/19/1997 12:00:00 AM', 2, 124.98, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10784, N'MAGAA', 4, '12/18/1997 12:00:00 AM', '1/15/1998 12:00:00 AM', '12/22/1997 12:00:00 AM', 3, 70.09, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10785, N'GROSR', 1, '12/18/1997 12:00:00 AM', '1/15/1998 12:00:00 AM', '12/24/1997 12:00:00 AM', 3, 1.51, N'GROSELLA-Restaurante', N'5? Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10786, N'QUEEN', 8, '12/19/1997 12:00:00 AM', '1/16/1998 12:00:00 AM', '12/23/1997 12:00:00 AM', 1, 110.87, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10787, N'LAMAI', 2, '12/19/1997 12:00:00 AM', '1/2/1998 12:00:00 AM', '12/26/1997 12:00:00 AM', 1, 249.93, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10788, N'QUICK', 1, '12/22/1997 12:00:00 AM', '1/19/1998 12:00:00 AM', '1/19/1998 12:00:00 AM', 2, 42.7, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10789, N'FOLIG', 1, '12/22/1997 12:00:00 AM', '1/19/1998 12:00:00 AM', '12/31/1997 12:00:00 AM', 2, 100.6, N'Folies gourmandes', N'184, chauss?e de Tournai', N'Lille', NULL, N'59000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10790, N'GOURL', 6, '12/22/1997 12:00:00 AM', '1/19/1998 12:00:00 AM', '12/26/1997 12:00:00 AM', 1, 28.23, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10791, N'FRANK', 6, '12/23/1997 12:00:00 AM', '1/20/1998 12:00:00 AM', '1/1/1998 12:00:00 AM', 2, 16.85, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10792, N'WOLZA', 1, '12/23/1997 12:00:00 AM', '1/20/1998 12:00:00 AM', '12/31/1997 12:00:00 AM', 3, 23.79, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10793, N'AROUT', 3, '12/24/1997 12:00:00 AM', '1/21/1998 12:00:00 AM', '1/8/1998 12:00:00 AM', 3, 4.52, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10794, N'QUEDE', 6, '12/24/1997 12:00:00 AM', '1/21/1998 12:00:00 AM', '1/2/1998 12:00:00 AM', 1, 21.49, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10795, N'ERNSH', 8, '12/24/1997 12:00:00 AM', '1/21/1998 12:00:00 AM', '1/20/1998 12:00:00 AM', 2, 126.66, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10796, N'HILAA', 3, '12/25/1997 12:00:00 AM', '1/22/1998 12:00:00 AM', '1/14/1998 12:00:00 AM', 1, 26.52, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10797, N'DRACD', 7, '12/25/1997 12:00:00 AM', '1/22/1998 12:00:00 AM', '1/5/1998 12:00:00 AM', 2, 33.35, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10798, N'ISLAT', 2, '12/26/1997 12:00:00 AM', '1/23/1998 12:00:00 AM', '1/5/1998 12:00:00 AM', 1, 2.33, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10799, N'KOENE', 9, '12/26/1997 12:00:00 AM', '2/6/1998 12:00:00 AM', '1/5/1998 12:00:00 AM', 3, 30.76, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10800, N'SEVES', 1, '12/26/1997 12:00:00 AM', '1/23/1998 12:00:00 AM', '1/5/1998 12:00:00 AM', 3, 137.44, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10801, N'BOLID', 4, '12/29/1997 12:00:00 AM', '1/26/1998 12:00:00 AM', '12/31/1997 12:00:00 AM', 2, 97.09, N'B?lido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10802, N'SIMOB', 4, '12/29/1997 12:00:00 AM', '1/26/1998 12:00:00 AM', '1/2/1998 12:00:00 AM', 2, 257.26, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10803, N'WELLI', 4, '12/30/1997 12:00:00 AM', '1/27/1998 12:00:00 AM', '1/6/1998 12:00:00 AM', 1, 55.23, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10804, N'SEVES', 6, '12/30/1997 12:00:00 AM', '1/27/1998 12:00:00 AM', '1/7/1998 12:00:00 AM', 2, 27.33, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10805, N'THEBI', 2, '12/30/1997 12:00:00 AM', '1/27/1998 12:00:00 AM', '1/9/1998 12:00:00 AM', 3, 237.34, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10806, N'VICTE', 3, '12/31/1997 12:00:00 AM', '1/28/1998 12:00:00 AM', '1/5/1998 12:00:00 AM', 2, 22.11, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10807, N'FRANS', 4, '12/31/1997 12:00:00 AM', '1/28/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', 1, 1.36, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10808, N'OLDWO', 2, '1/1/1998 12:00:00 AM', '1/29/1998 12:00:00 AM', '1/9/1998 12:00:00 AM', 3, 45.53, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10809, N'WELLI', 7, '1/1/1998 12:00:00 AM', '1/29/1998 12:00:00 AM', '1/7/1998 12:00:00 AM', 1, 4.87, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10810, N'LAUGB', 2, '1/1/1998 12:00:00 AM', '1/29/1998 12:00:00 AM', '1/7/1998 12:00:00 AM', 3, 4.33, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10811, N'LINOD', 8, '1/2/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', '1/8/1998 12:00:00 AM', 1, 31.22, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10812, N'REGGC', 5, '1/2/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', '1/12/1998 12:00:00 AM', 1, 59.78, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10813, N'RICAR', 1, '1/5/1998 12:00:00 AM', '2/2/1998 12:00:00 AM', '1/9/1998 12:00:00 AM', 1, 47.38, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10814, N'VICTE', 3, '1/5/1998 12:00:00 AM', '2/2/1998 12:00:00 AM', '1/14/1998 12:00:00 AM', 3, 130.94, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10815, N'SAVEA', 2, '1/5/1998 12:00:00 AM', '2/2/1998 12:00:00 AM', '1/14/1998 12:00:00 AM', 3, 14.62, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10816, N'GREAL', 4, '1/6/1998 12:00:00 AM', '2/3/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', 2, 719.78, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10817, N'KOENE', 3, '1/6/1998 12:00:00 AM', '1/20/1998 12:00:00 AM', '1/13/1998 12:00:00 AM', 2, 306.07, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10818, N'MAGAA', 7, '1/7/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', '1/12/1998 12:00:00 AM', 3, 65.48, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10819, N'CACTU', 2, '1/7/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', '1/16/1998 12:00:00 AM', 3, 19.76, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10820, N'RATTC', 3, '1/7/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', '1/13/1998 12:00:00 AM', 2, 37.52, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10821, N'SPLIR', 1, '1/8/1998 12:00:00 AM', '2/5/1998 12:00:00 AM', '1/15/1998 12:00:00 AM', 1, 36.68, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10822, N'TRAIH', 6, '1/8/1998 12:00:00 AM', '2/5/1998 12:00:00 AM', '1/16/1998 12:00:00 AM', 3, 7, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10823, N'LILAS', 5, '1/9/1998 12:00:00 AM', '2/6/1998 12:00:00 AM', '1/13/1998 12:00:00 AM', 2, 163.97, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10824, N'FOLKO', 8, '1/9/1998 12:00:00 AM', '2/6/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', 1, 1.23, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10825, N'DRACD', 1, '1/9/1998 12:00:00 AM', '2/6/1998 12:00:00 AM', '1/14/1998 12:00:00 AM', 1, 79.25, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10826, N'BLONP', 6, '1/12/1998 12:00:00 AM', '2/9/1998 12:00:00 AM', '2/6/1998 12:00:00 AM', 1, 7.09, N'Blondel p?re et fils', N'24, place Kl?ber', N'Strasbourg', NULL, N'67000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10827, N'BONAP', 1, '1/12/1998 12:00:00 AM', '1/26/1998 12:00:00 AM', '2/6/1998 12:00:00 AM', 2, 63.54, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10828, N'RANCH', 9, '1/13/1998 12:00:00 AM', '1/27/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', 1, 90.85, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10829, N'ISLAT', 9, '1/13/1998 12:00:00 AM', '2/10/1998 12:00:00 AM', '1/23/1998 12:00:00 AM', 1, 154.72, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10830, N'TRADH', 4, '1/13/1998 12:00:00 AM', '2/24/1998 12:00:00 AM', '1/21/1998 12:00:00 AM', 2, 81.83, N'Tradi?ao Hipermercados', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10831, N'SANTG', 3, '1/14/1998 12:00:00 AM', '2/11/1998 12:00:00 AM', '1/23/1998 12:00:00 AM', 2, 72.19, N'Sant? Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10832, N'LAMAI', 2, '1/14/1998 12:00:00 AM', '2/11/1998 12:00:00 AM', '1/19/1998 12:00:00 AM', 2, 43.26, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10833, N'OTTIK', 6, '1/15/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', '1/23/1998 12:00:00 AM', 2, 71.49, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10834, N'TRADH', 1, '1/15/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', '1/19/1998 12:00:00 AM', 3, 29.78, N'Tradi?ao Hipermercados', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10835, N'ALFKI', 1, '1/15/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', '1/21/1998 12:00:00 AM', 3, 69.53, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10836, N'ERNSH', 7, '1/16/1998 12:00:00 AM', '2/13/1998 12:00:00 AM', '1/21/1998 12:00:00 AM', 1, 411.88, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10837, N'BERGS', 9, '1/16/1998 12:00:00 AM', '2/13/1998 12:00:00 AM', '1/23/1998 12:00:00 AM', 3, 13.32, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10838, N'LINOD', 3, '1/19/1998 12:00:00 AM', '2/16/1998 12:00:00 AM', '1/23/1998 12:00:00 AM', 3, 59.28, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10839, N'TRADH', 3, '1/19/1998 12:00:00 AM', '2/16/1998 12:00:00 AM', '1/22/1998 12:00:00 AM', 3, 35.43, N'Tradi?ao Hipermercados', N'Av. In?s de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10840, N'LINOD', 4, '1/19/1998 12:00:00 AM', '3/2/1998 12:00:00 AM', '2/16/1998 12:00:00 AM', 2, 2.71, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10841, N'SUPRD', 5, '1/20/1998 12:00:00 AM', '2/17/1998 12:00:00 AM', '1/29/1998 12:00:00 AM', 2, 424.3, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10842, N'TORTU', 1, '1/20/1998 12:00:00 AM', '2/17/1998 12:00:00 AM', '1/29/1998 12:00:00 AM', 3, 54.42, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10843, N'VICTE', 4, '1/21/1998 12:00:00 AM', '2/18/1998 12:00:00 AM', '1/26/1998 12:00:00 AM', 2, 9.26, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10844, N'PICCO', 8, '1/21/1998 12:00:00 AM', '2/18/1998 12:00:00 AM', '1/26/1998 12:00:00 AM', 2, 25.22, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10845, N'QUICK', 8, '1/21/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', 1, 212.98, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10846, N'SUPRD', 2, '1/22/1998 12:00:00 AM', '3/5/1998 12:00:00 AM', '1/23/1998 12:00:00 AM', 3, 56.46, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10847, N'SAVEA', 4, '1/22/1998 12:00:00 AM', '2/5/1998 12:00:00 AM', '2/10/1998 12:00:00 AM', 3, 487.57, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10848, N'CONSH', 7, '1/23/1998 12:00:00 AM', '2/20/1998 12:00:00 AM', '1/29/1998 12:00:00 AM', 2, 38.24, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', NULL, N'WX1 6LT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10849, N'KOENE', 9, '1/23/1998 12:00:00 AM', '2/20/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', 2, 0.56, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10850, N'VICTE', 1, '1/23/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', 1, 49.19, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10851, N'RICAR', 5, '1/26/1998 12:00:00 AM', '2/23/1998 12:00:00 AM', '2/2/1998 12:00:00 AM', 1, 160.55, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10852, N'RATTC', 8, '1/26/1998 12:00:00 AM', '2/9/1998 12:00:00 AM', '1/30/1998 12:00:00 AM', 1, 174.05, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10853, N'BLAUS', 9, '1/27/1998 12:00:00 AM', '2/24/1998 12:00:00 AM', '2/3/1998 12:00:00 AM', 2, 53.83, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10854, N'ERNSH', 3, '1/27/1998 12:00:00 AM', '2/24/1998 12:00:00 AM', '2/5/1998 12:00:00 AM', 2, 100.22, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10855, N'OLDWO', 3, '1/27/1998 12:00:00 AM', '2/24/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', 1, 170.97, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10856, N'ANTON', 3, '1/28/1998 12:00:00 AM', '2/25/1998 12:00:00 AM', '2/10/1998 12:00:00 AM', 2, 58.43, N'Antonio Moreno Taquer?a', N'Mataderos  2312', N'M?xico D.F.', NULL, N'05023', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10857, N'BERGS', 8, '1/28/1998 12:00:00 AM', '2/25/1998 12:00:00 AM', '2/6/1998 12:00:00 AM', 2, 188.85, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10858, N'LACOR', 2, '1/29/1998 12:00:00 AM', '2/26/1998 12:00:00 AM', '2/3/1998 12:00:00 AM', 1, 52.51, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10859, N'FRANK', 1, '1/29/1998 12:00:00 AM', '2/26/1998 12:00:00 AM', '2/2/1998 12:00:00 AM', 2, 76.1, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10860, N'FRANR', 3, '1/29/1998 12:00:00 AM', '2/26/1998 12:00:00 AM', '2/4/1998 12:00:00 AM', 3, 19.26, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10861, N'WHITC', 4, '1/30/1998 12:00:00 AM', '2/27/1998 12:00:00 AM', '2/17/1998 12:00:00 AM', 2, 14.93, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10862, N'LEHMS', 8, '1/30/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', '2/2/1998 12:00:00 AM', 2, 53.23, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10863, N'HILAA', 4, '2/2/1998 12:00:00 AM', '3/2/1998 12:00:00 AM', '2/17/1998 12:00:00 AM', 2, 30.26, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10864, N'AROUT', 4, '2/2/1998 12:00:00 AM', '3/2/1998 12:00:00 AM', '2/9/1998 12:00:00 AM', 2, 3.04, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10865, N'QUICK', 2, '2/2/1998 12:00:00 AM', '2/16/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', 1, 348.14, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10866, N'BERGS', 5, '2/3/1998 12:00:00 AM', '3/3/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', 1, 109.11, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10867, N'LONEP', 6, '2/3/1998 12:00:00 AM', '3/17/1998 12:00:00 AM', '2/11/1998 12:00:00 AM', 1, 1.93, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10868, N'QUEEN', 7, '2/4/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', '2/23/1998 12:00:00 AM', 2, 191.27, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10869, N'SEVES', 5, '2/4/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', '2/9/1998 12:00:00 AM', 1, 143.28, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10870, N'WOLZA', 5, '2/4/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', '2/13/1998 12:00:00 AM', 3, 12.04, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10871, N'BONAP', 9, '2/5/1998 12:00:00 AM', '3/5/1998 12:00:00 AM', '2/10/1998 12:00:00 AM', 2, 112.27, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10872, N'GODOS', 5, '2/5/1998 12:00:00 AM', '3/5/1998 12:00:00 AM', '2/9/1998 12:00:00 AM', 2, 175.32, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10873, N'WILMK', 4, '2/6/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', '2/9/1998 12:00:00 AM', 1, 0.82, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10874, N'GODOS', 5, '2/6/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', '2/11/1998 12:00:00 AM', 2, 19.58, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10875, N'BERGS', 4, '2/6/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', '3/3/1998 12:00:00 AM', 2, 32.37, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10876, N'BONAP', 7, '2/9/1998 12:00:00 AM', '3/9/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', 3, 60.42, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10877, N'RICAR', 1, '2/9/1998 12:00:00 AM', '3/9/1998 12:00:00 AM', '2/19/1998 12:00:00 AM', 1, 38.06, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10878, N'QUICK', 4, '2/10/1998 12:00:00 AM', '3/10/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', 1, 46.69, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10879, N'WILMK', 3, '2/10/1998 12:00:00 AM', '3/10/1998 12:00:00 AM', '2/12/1998 12:00:00 AM', 3, 8.5, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10880, N'FOLKO', 7, '2/10/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', '2/18/1998 12:00:00 AM', 1, 88.01, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10881, N'CACTU', 4, '2/11/1998 12:00:00 AM', '3/11/1998 12:00:00 AM', '2/18/1998 12:00:00 AM', 1, 2.84, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10882, N'SAVEA', 4, '2/11/1998 12:00:00 AM', '3/11/1998 12:00:00 AM', '2/20/1998 12:00:00 AM', 3, 23.1, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10883, N'LONEP', 8, '2/12/1998 12:00:00 AM', '3/12/1998 12:00:00 AM', '2/20/1998 12:00:00 AM', 3, 0.53, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10884, N'LETSS', 4, '2/12/1998 12:00:00 AM', '3/12/1998 12:00:00 AM', '2/13/1998 12:00:00 AM', 2, 90.97, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10885, N'SUPRD', 6, '2/12/1998 12:00:00 AM', '3/12/1998 12:00:00 AM', '2/18/1998 12:00:00 AM', 3, 5.64, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10886, N'HANAR', 1, '2/13/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', '3/2/1998 12:00:00 AM', 1, 4.99, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10887, N'GALED', 8, '2/13/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', '2/16/1998 12:00:00 AM', 3, 1.25, N'Galer?a del gastron?mo', N'Rambla de Catalu?a, 23', N'Barcelona', NULL, N'8022', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10888, N'GODOS', 1, '2/16/1998 12:00:00 AM', '3/16/1998 12:00:00 AM', '2/23/1998 12:00:00 AM', 2, 51.87, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10889, N'RATTC', 9, '2/16/1998 12:00:00 AM', '3/16/1998 12:00:00 AM', '2/23/1998 12:00:00 AM', 3, 280.61, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10890, N'DUMON', 7, '2/16/1998 12:00:00 AM', '3/16/1998 12:00:00 AM', '2/18/1998 12:00:00 AM', 1, 32.76, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10891, N'LEHMS', 7, '2/17/1998 12:00:00 AM', '3/17/1998 12:00:00 AM', '2/19/1998 12:00:00 AM', 2, 20.37, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10892, N'MAISD', 4, '2/17/1998 12:00:00 AM', '3/17/1998 12:00:00 AM', '2/19/1998 12:00:00 AM', 2, 120.27, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10893, N'KOENE', 9, '2/18/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', '2/20/1998 12:00:00 AM', 2, 77.78, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10894, N'SAVEA', 1, '2/18/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', '2/20/1998 12:00:00 AM', 1, 116.13, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10895, N'ERNSH', 3, '2/18/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', '2/23/1998 12:00:00 AM', 1, 162.75, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10896, N'MAISD', 7, '2/19/1998 12:00:00 AM', '3/19/1998 12:00:00 AM', '2/27/1998 12:00:00 AM', 3, 32.45, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10897, N'HUNGO', 3, '2/19/1998 12:00:00 AM', '3/19/1998 12:00:00 AM', '2/25/1998 12:00:00 AM', 2, 603.54, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10898, N'OCEAN', 4, '2/20/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', 2, 1.27, N'Oc?ano Atl?ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10899, N'LILAS', 5, '2/20/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', '2/26/1998 12:00:00 AM', 3, 1.21, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10900, N'WELLI', 1, '2/20/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', 2, 1.66, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10901, N'HILAA', 4, '2/23/1998 12:00:00 AM', '3/23/1998 12:00:00 AM', '2/26/1998 12:00:00 AM', 1, 62.09, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10902, N'FOLKO', 1, '2/23/1998 12:00:00 AM', '3/23/1998 12:00:00 AM', '3/3/1998 12:00:00 AM', 1, 44.15, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10903, N'HANAR', 3, '2/24/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', 3, 36.71, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10904, N'WHITC', 3, '2/24/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', '2/27/1998 12:00:00 AM', 3, 162.95, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10905, N'WELLI', 9, '2/24/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', 2, 13.72, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10906, N'WOLZA', 4, '2/25/1998 12:00:00 AM', '3/11/1998 12:00:00 AM', '3/3/1998 12:00:00 AM', 3, 26.29, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10907, N'SPECD', 6, '2/25/1998 12:00:00 AM', '3/25/1998 12:00:00 AM', '2/27/1998 12:00:00 AM', 3, 9.19, N'Sp?cialit?s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10908, N'REGGC', 4, '2/26/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/6/1998 12:00:00 AM', 2, 32.96, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10909, N'SANTG', 1, '2/26/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/10/1998 12:00:00 AM', 2, 53.05, N'Sant? Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10910, N'WILMK', 1, '2/26/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', 3, 38.11, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10911, N'GODOS', 3, '2/26/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/5/1998 12:00:00 AM', 1, 38.19, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10912, N'HUNGO', 2, '2/26/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 2, 580.91, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10913, N'QUEEN', 4, '2/26/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', 1, 33.05, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10914, N'QUEEN', 6, '2/27/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', '3/2/1998 12:00:00 AM', 1, 21.19, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10915, N'TORTU', 2, '2/27/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', '3/2/1998 12:00:00 AM', 2, 3.51, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10916, N'RANCH', 1, '2/27/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', '3/9/1998 12:00:00 AM', 2, 63.77, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10917, N'ROMEY', 4, '3/2/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', '3/11/1998 12:00:00 AM', 2, 8.29, N'Romero y tomillo', N'Gran V?a, 1', N'Madrid', NULL, N'28001', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10918, N'BOTTM', 3, '3/2/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', '3/11/1998 12:00:00 AM', 3, 48.83, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10919, N'LINOD', 2, '3/2/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', '3/4/1998 12:00:00 AM', 2, 19.8, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10920, N'AROUT', 4, '3/3/1998 12:00:00 AM', '3/31/1998 12:00:00 AM', '3/9/1998 12:00:00 AM', 2, 29.61, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10921, N'VAFFE', 1, '3/3/1998 12:00:00 AM', '4/14/1998 12:00:00 AM', '3/9/1998 12:00:00 AM', 1, 176.48, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10922, N'HANAR', 5, '3/3/1998 12:00:00 AM', '3/31/1998 12:00:00 AM', '3/5/1998 12:00:00 AM', 3, 62.74, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10923, N'LAMAI', 7, '3/3/1998 12:00:00 AM', '4/14/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', 3, 68.26, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10924, N'BERGS', 3, '3/4/1998 12:00:00 AM', '4/1/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', 2, 151.52, N'Berglunds snabbk?p', N'Berguvsv?gen  8', N'Lule?', NULL, N'S-958 22', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10925, N'HANAR', 3, '3/4/1998 12:00:00 AM', '4/1/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', 1, 2.27, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10926, N'ANATR', 4, '3/4/1998 12:00:00 AM', '4/1/1998 12:00:00 AM', '3/11/1998 12:00:00 AM', 3, 39.92, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constituci?n 2222', N'M?xico D.F.', NULL, N'05021', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10927, N'LACOR', 4, '3/5/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', 1, 19.79, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10928, N'GALED', 1, '3/5/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 1, 1.36, N'Galer?a del gastron?mo', N'Rambla de Catalu?a, 23', N'Barcelona', NULL, N'8022', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10929, N'FRANK', 6, '3/5/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', '3/12/1998 12:00:00 AM', 1, 33.93, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10930, N'SUPRD', 4, '3/6/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 3, 15.55, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10931, N'RICSU', 4, '3/6/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', '3/19/1998 12:00:00 AM', 2, 13.6, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10932, N'BONAP', 8, '3/6/1998 12:00:00 AM', '4/3/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', 1, 134.64, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10933, N'ISLAT', 6, '3/6/1998 12:00:00 AM', '4/3/1998 12:00:00 AM', '3/16/1998 12:00:00 AM', 3, 54.15, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10934, N'LEHMS', 3, '3/9/1998 12:00:00 AM', '4/6/1998 12:00:00 AM', '3/12/1998 12:00:00 AM', 3, 32.01, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10935, N'WELLI', 4, '3/9/1998 12:00:00 AM', '4/6/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 3, 47.59, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10936, N'GREAL', 3, '3/9/1998 12:00:00 AM', '4/6/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 2, 33.68, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10937, N'CACTU', 7, '3/10/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', 3, 31.51, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10938, N'QUICK', 3, '3/10/1998 12:00:00 AM', '4/7/1998 12:00:00 AM', '3/16/1998 12:00:00 AM', 2, 31.89, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10939, N'MAGAA', 2, '3/10/1998 12:00:00 AM', '4/7/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', 2, 76.33, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10940, N'BONAP', 8, '3/11/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', '3/23/1998 12:00:00 AM', 3, 19.77, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10941, N'SAVEA', 7, '3/11/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', 2, 400.81, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10942, N'REGGC', 9, '3/11/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 3, 17.95, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10943, N'BSBEV', 4, '3/11/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', '3/19/1998 12:00:00 AM', 2, 2.17, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10944, N'BOTTM', 6, '3/12/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', '3/13/1998 12:00:00 AM', 3, 52.92, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10945, N'MORGK', 4, '3/12/1998 12:00:00 AM', '4/9/1998 12:00:00 AM', '3/18/1998 12:00:00 AM', 1, 10.22, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10946, N'VAFFE', 1, '3/12/1998 12:00:00 AM', '4/9/1998 12:00:00 AM', '3/19/1998 12:00:00 AM', 2, 27.2, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10947, N'BSBEV', 3, '3/13/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', '3/16/1998 12:00:00 AM', 2, 3.26, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10948, N'GODOS', 3, '3/13/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', '3/19/1998 12:00:00 AM', 3, 23.39, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10949, N'BOTTM', 2, '3/13/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', '3/17/1998 12:00:00 AM', 3, 74.44, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10950, N'MAGAA', 1, '3/16/1998 12:00:00 AM', '4/13/1998 12:00:00 AM', '3/23/1998 12:00:00 AM', 2, 2.5, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10951, N'RICSU', 9, '3/16/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', '4/7/1998 12:00:00 AM', 2, 30.85, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10952, N'ALFKI', 1, '3/16/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', 1, 40.42, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10953, N'AROUT', 9, '3/16/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', '3/25/1998 12:00:00 AM', 2, 23.72, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10954, N'LINOD', 5, '3/17/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', 1, 27.91, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10955, N'FOLKO', 8, '3/17/1998 12:00:00 AM', '4/14/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', 2, 3.26, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10956, N'BLAUS', 6, '3/17/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', '3/20/1998 12:00:00 AM', 2, 44.65, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10957, N'HILAA', 8, '3/18/1998 12:00:00 AM', '4/15/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', 3, 105.36, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10958, N'OCEAN', 7, '3/18/1998 12:00:00 AM', '4/15/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', 2, 49.56, N'Oc?ano Atl?ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10959, N'GOURL', 6, '3/18/1998 12:00:00 AM', '4/29/1998 12:00:00 AM', '3/23/1998 12:00:00 AM', 2, 4.98, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10960, N'HILAA', 3, '3/19/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', 1, 2.08, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10961, N'QUEEN', 8, '3/19/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', 1, 104.47, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10962, N'QUICK', 8, '3/19/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', '3/23/1998 12:00:00 AM', 2, 275.79, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10963, N'FURIB', 9, '3/19/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', 3, 2.7, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10964, N'SPECD', 3, '3/20/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', '3/24/1998 12:00:00 AM', 2, 87.38, N'Sp?cialit?s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10965, N'OLDWO', 6, '3/20/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', 3, 144.38, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10966, N'CHOPS', 4, '3/20/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', 1, 27.19, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10967, N'TOMSP', 2, '3/23/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', 2, 62.22, N'Toms Spezialit?ten', N'Luisenstr. 48', N'M?nster', NULL, N'44087', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10968, N'ERNSH', 1, '3/23/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', '4/1/1998 12:00:00 AM', 3, 74.6, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10969, N'COMMI', 1, '3/23/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', '3/30/1998 12:00:00 AM', 2, 0.21, N'Com?rcio Mineiro', N'Av. dos Lus?adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10970, N'BOLID', 9, '3/24/1998 12:00:00 AM', '4/7/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', 1, 16.16, N'B?lido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10971, N'FRANR', 2, '3/24/1998 12:00:00 AM', '4/21/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', 2, 121.82, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10972, N'LACOR', 4, '3/24/1998 12:00:00 AM', '4/21/1998 12:00:00 AM', '3/26/1998 12:00:00 AM', 2, 0.02, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10973, N'LACOR', 6, '3/24/1998 12:00:00 AM', '4/21/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', 2, 15.17, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10974, N'SPLIR', 3, '3/25/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', '4/3/1998 12:00:00 AM', 3, 12.96, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10975, N'BOTTM', 1, '3/25/1998 12:00:00 AM', '4/22/1998 12:00:00 AM', '3/27/1998 12:00:00 AM', 3, 32.27, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10976, N'HILAA', 1, '3/25/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', '4/3/1998 12:00:00 AM', 1, 37.97, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10977, N'FOLKO', 8, '3/26/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 3, 208.5, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10978, N'MAISD', 9, '3/26/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', 2, 32.82, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10979, N'ERNSH', 8, '3/26/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', '3/31/1998 12:00:00 AM', 2, 353.07, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10980, N'FOLKO', 4, '3/27/1998 12:00:00 AM', '5/8/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', 1, 1.26, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10981, N'HANAR', 1, '3/27/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', 2, 193.37, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10982, N'BOTTM', 2, '3/27/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', 1, 14.01, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10983, N'SAVEA', 2, '3/27/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', '4/6/1998 12:00:00 AM', 2, 657.54, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10984, N'SAVEA', 1, '3/30/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', '4/3/1998 12:00:00 AM', 3, 211.22, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10985, N'HUNGO', 2, '3/30/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', 1, 91.51, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10986, N'OCEAN', 8, '3/30/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', '4/21/1998 12:00:00 AM', 2, 217.86, N'Oc?ano Atl?ntico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10987, N'EASTC', 8, '3/31/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', '4/6/1998 12:00:00 AM', 1, 185.48, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10988, N'RATTC', 3, '3/31/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 2, 61.14, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10989, N'QUEDE', 2, '3/31/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', '4/2/1998 12:00:00 AM', 1, 34.76, N'Que Del?cia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10990, N'ERNSH', 2, '4/1/1998 12:00:00 AM', '5/13/1998 12:00:00 AM', '4/7/1998 12:00:00 AM', 3, 117.61, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10991, N'QUICK', 1, '4/1/1998 12:00:00 AM', '4/29/1998 12:00:00 AM', '4/7/1998 12:00:00 AM', 1, 38.51, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10992, N'THEBI', 1, '4/1/1998 12:00:00 AM', '4/29/1998 12:00:00 AM', '4/3/1998 12:00:00 AM', 3, 4.27, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10993, N'FOLKO', 7, '4/1/1998 12:00:00 AM', '4/29/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 3, 8.81, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10994, N'VAFFE', 2, '4/2/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', '4/9/1998 12:00:00 AM', 3, 65.53, N'Vaffeljernet', N'Smagsloget 45', N'?rhus', NULL, N'8200', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10995, N'PERIC', 1, '4/2/1998 12:00:00 AM', '4/30/1998 12:00:00 AM', '4/6/1998 12:00:00 AM', 3, 46, N'Pericles Comidas cl?sicas', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10996, N'QUICK', 4, '4/2/1998 12:00:00 AM', '4/30/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 2, 1.12, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10997, N'LILAS', 8, '4/3/1998 12:00:00 AM', '5/15/1998 12:00:00 AM', '4/13/1998 12:00:00 AM', 2, 73.91, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10998, N'WOLZA', 8, '4/3/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', 2, 20.31, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (10999, N'OTTIK', 6, '4/3/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 2, 96.35, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11000, N'RATTC', 2, '4/6/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', '4/14/1998 12:00:00 AM', 3, 55.12, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11001, N'FOLKO', 2, '4/6/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', '4/14/1998 12:00:00 AM', 2, 197.3, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11002, N'SAVEA', 4, '4/6/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', 1, 141.16, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11003, N'THECR', 3, '4/6/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', '4/8/1998 12:00:00 AM', 3, 14.91, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11004, N'MAISD', 3, '4/7/1998 12:00:00 AM', '5/5/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', 1, 44.84, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11005, N'WILMK', 2, '4/7/1998 12:00:00 AM', '5/5/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 1, 0.75, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11006, N'GREAL', 3, '4/7/1998 12:00:00 AM', '5/5/1998 12:00:00 AM', '4/15/1998 12:00:00 AM', 2, 25.19, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11007, N'PRINI', 8, '4/8/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', '4/13/1998 12:00:00 AM', 2, 202.24, N'Princesa Isabel Vinhos', N'Estrada da sa?de n. 58', N'Lisboa', NULL, N'1756', N'Portugal')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11008, N'ERNSH', 7, '4/8/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', NULL, 3, 79.46, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11009, N'GODOS', 2, '4/8/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 1, 59.11, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11010, N'REGGC', 2, '4/9/1998 12:00:00 AM', '5/7/1998 12:00:00 AM', '4/21/1998 12:00:00 AM', 2, 28.71, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11011, N'ALFKI', 3, '4/9/1998 12:00:00 AM', '5/7/1998 12:00:00 AM', '4/13/1998 12:00:00 AM', 1, 1.21, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11012, N'FRANK', 1, '4/9/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', '4/17/1998 12:00:00 AM', 3, 242.95, N'Frankenversand', N'Berliner Platz 43', N'M?nchen', NULL, N'80805', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11013, N'ROMEY', 2, '4/9/1998 12:00:00 AM', '5/7/1998 12:00:00 AM', '4/10/1998 12:00:00 AM', 1, 32.99, N'Romero y tomillo', N'Gran V?a, 1', N'Madrid', NULL, N'28001', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11014, N'LINOD', 2, '4/10/1998 12:00:00 AM', '5/8/1998 12:00:00 AM', '4/15/1998 12:00:00 AM', 3, 23.6, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11015, N'SANTG', 2, '4/10/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', 2, 4.62, N'Sant? Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11016, N'AROUT', 9, '4/10/1998 12:00:00 AM', '5/8/1998 12:00:00 AM', '4/13/1998 12:00:00 AM', 2, 33.8, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11017, N'ERNSH', 9, '4/13/1998 12:00:00 AM', '5/11/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', 2, 754.26, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11018, N'LONEP', 4, '4/13/1998 12:00:00 AM', '5/11/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', 2, 11.65, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11019, N'RANCH', 6, '4/13/1998 12:00:00 AM', '5/11/1998 12:00:00 AM', NULL, 3, 3.17, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11020, N'OTTIK', 2, '4/14/1998 12:00:00 AM', '5/12/1998 12:00:00 AM', '4/16/1998 12:00:00 AM', 2, 43.3, N'Ottilies K?seladen', N'Mehrheimerstr. 369', N'K?ln', NULL, N'50739', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11021, N'QUICK', 3, '4/14/1998 12:00:00 AM', '5/12/1998 12:00:00 AM', '4/21/1998 12:00:00 AM', 1, 297.18, N'QUICK-Stop', N'Taucherstra?e 10', N'Cunewalde', NULL, N'01307', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11022, N'HANAR', 9, '4/14/1998 12:00:00 AM', '5/12/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', 2, 6.27, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11023, N'BSBEV', 1, '4/14/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', 2, 123.83, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11024, N'EASTC', 4, '4/15/1998 12:00:00 AM', '5/13/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', 1, 74.36, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11025, N'WARTH', 6, '4/15/1998 12:00:00 AM', '5/13/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', 3, 29.17, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11026, N'FRANS', 4, '4/15/1998 12:00:00 AM', '5/13/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', 1, 47.09, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11027, N'BOTTM', 1, '4/16/1998 12:00:00 AM', '5/14/1998 12:00:00 AM', '4/20/1998 12:00:00 AM', 1, 52.52, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11028, N'KOENE', 2, '4/16/1998 12:00:00 AM', '5/14/1998 12:00:00 AM', '4/22/1998 12:00:00 AM', 1, 29.59, N'K?niglich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11029, N'CHOPS', 4, '4/16/1998 12:00:00 AM', '5/14/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', 1, 47.84, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11030, N'SAVEA', 7, '4/17/1998 12:00:00 AM', '5/15/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', 2, 830.75, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11031, N'SAVEA', 6, '4/17/1998 12:00:00 AM', '5/15/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', 2, 227.22, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11032, N'WHITC', 2, '4/17/1998 12:00:00 AM', '5/15/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', 3, 606.19, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11033, N'RICSU', 7, '4/17/1998 12:00:00 AM', '5/15/1998 12:00:00 AM', '4/23/1998 12:00:00 AM', 3, 84.74, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11034, N'OLDWO', 8, '4/20/1998 12:00:00 AM', '6/1/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', 1, 40.32, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11035, N'SUPRD', 2, '4/20/1998 12:00:00 AM', '5/18/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', 2, 0.17, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11036, N'DRACD', 8, '4/20/1998 12:00:00 AM', '5/18/1998 12:00:00 AM', '4/22/1998 12:00:00 AM', 3, 149.47, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11037, N'GODOS', 7, '4/21/1998 12:00:00 AM', '5/19/1998 12:00:00 AM', '4/27/1998 12:00:00 AM', 1, 3.2, N'Godos Cocina T?pica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11038, N'SUPRD', 1, '4/21/1998 12:00:00 AM', '5/19/1998 12:00:00 AM', '4/30/1998 12:00:00 AM', 2, 29.59, N'Supr?mes d?lices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11039, N'LINOD', 1, '4/21/1998 12:00:00 AM', '5/19/1998 12:00:00 AM', NULL, 2, 65, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11040, N'GREAL', 4, '4/22/1998 12:00:00 AM', '5/20/1998 12:00:00 AM', NULL, 3, 18.84, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11041, N'CHOPS', 3, '4/22/1998 12:00:00 AM', '5/20/1998 12:00:00 AM', '4/28/1998 12:00:00 AM', 2, 48.22, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11042, N'COMMI', 2, '4/22/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', 1, 29.99, N'Com?rcio Mineiro', N'Av. dos Lus?adas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11043, N'SPECD', 5, '4/22/1998 12:00:00 AM', '5/20/1998 12:00:00 AM', '4/29/1998 12:00:00 AM', 2, 8.8, N'Sp?cialit?s du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11044, N'WOLZA', 4, '4/23/1998 12:00:00 AM', '5/21/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', 1, 8.72, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11045, N'BOTTM', 6, '4/23/1998 12:00:00 AM', '5/21/1998 12:00:00 AM', NULL, 2, 70.58, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11046, N'WANDK', 8, '4/23/1998 12:00:00 AM', '5/21/1998 12:00:00 AM', '4/24/1998 12:00:00 AM', 2, 71.64, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11047, N'EASTC', 7, '4/24/1998 12:00:00 AM', '5/22/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', 3, 46.62, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11048, N'BOTTM', 7, '4/24/1998 12:00:00 AM', '5/22/1998 12:00:00 AM', '4/30/1998 12:00:00 AM', 3, 24.12, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11049, N'GOURL', 3, '4/24/1998 12:00:00 AM', '5/22/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', 1, 8.34, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11050, N'FOLKO', 8, '4/27/1998 12:00:00 AM', '5/25/1998 12:00:00 AM', '5/5/1998 12:00:00 AM', 2, 59.41, N'Folk och f? HB', N'?kergatan 24', N'Br?cke', NULL, N'S-844 67', N'Sweden')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11051, N'LAMAI', 7, '4/27/1998 12:00:00 AM', '5/25/1998 12:00:00 AM', NULL, 3, 2.79, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11052, N'HANAR', 3, '4/27/1998 12:00:00 AM', '5/25/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', 1, 67.26, N'Hanari Carnes', N'Rua do Pa?o, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11053, N'PICCO', 2, '4/27/1998 12:00:00 AM', '5/25/1998 12:00:00 AM', '4/29/1998 12:00:00 AM', 2, 53.05, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11054, N'CACTU', 8, '4/28/1998 12:00:00 AM', '5/26/1998 12:00:00 AM', NULL, 1, 0.33, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11055, N'HILAA', 7, '4/28/1998 12:00:00 AM', '5/26/1998 12:00:00 AM', '5/5/1998 12:00:00 AM', 2, 120.92, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Crist?bal', N'T?chira', N'5022', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11056, N'EASTC', 8, '4/28/1998 12:00:00 AM', '5/12/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', 2, 278.96, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11057, N'NORTS', 3, '4/29/1998 12:00:00 AM', '5/27/1998 12:00:00 AM', '5/1/1998 12:00:00 AM', 3, 4.13, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11058, N'BLAUS', 9, '4/29/1998 12:00:00 AM', '5/27/1998 12:00:00 AM', NULL, 3, 31.14, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11059, N'RICAR', 2, '4/29/1998 12:00:00 AM', '6/10/1998 12:00:00 AM', NULL, 2, 85.8, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11060, N'FRANS', 2, '4/30/1998 12:00:00 AM', '5/28/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', 2, 10.98, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11061, N'GREAL', 4, '4/30/1998 12:00:00 AM', '6/11/1998 12:00:00 AM', NULL, 3, 14.01, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11062, N'REGGC', 4, '4/30/1998 12:00:00 AM', '5/28/1998 12:00:00 AM', NULL, 2, 29.93, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11063, N'HUNGO', 3, '4/30/1998 12:00:00 AM', '5/28/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', 2, 81.73, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11064, N'SAVEA', 1, '5/1/1998 12:00:00 AM', '5/29/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', 1, 30.09, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11065, N'LILAS', 8, '5/1/1998 12:00:00 AM', '5/29/1998 12:00:00 AM', NULL, 1, 12.91, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11066, N'WHITC', 7, '5/1/1998 12:00:00 AM', '5/29/1998 12:00:00 AM', '5/4/1998 12:00:00 AM', 2, 44.72, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11067, N'DRACD', 1, '5/4/1998 12:00:00 AM', '5/18/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', 2, 7.98, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11068, N'QUEEN', 8, '5/4/1998 12:00:00 AM', '6/1/1998 12:00:00 AM', NULL, 2, 81.75, N'Queen Cozinha', N'Alameda dos Can?rios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11069, N'TORTU', 1, '5/4/1998 12:00:00 AM', '6/1/1998 12:00:00 AM', '5/6/1998 12:00:00 AM', 2, 15.67, N'Tortuga Restaurante', N'Avda. Azteca 123', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11070, N'LEHMS', 2, '5/5/1998 12:00:00 AM', '6/2/1998 12:00:00 AM', NULL, 1, 136, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11071, N'LILAS', 1, '5/5/1998 12:00:00 AM', '6/2/1998 12:00:00 AM', NULL, 1, 0.93, N'LILA-Supermercado', N'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11072, N'ERNSH', 4, '5/5/1998 12:00:00 AM', '6/2/1998 12:00:00 AM', NULL, 2, 258.64, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11073, N'PERIC', 2, '5/5/1998 12:00:00 AM', '6/2/1998 12:00:00 AM', NULL, 2, 24.95, N'Pericles Comidas cl?sicas', N'Calle Dr. Jorge Cash 321', N'M?xico D.F.', NULL, N'05033', N'Mexico')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11074, N'SIMOB', 7, '5/6/1998 12:00:00 AM', '6/3/1998 12:00:00 AM', NULL, 2, 18.44, N'Simons bistro', N'Vinb?ltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11075, N'RICSU', 8, '5/6/1998 12:00:00 AM', '6/3/1998 12:00:00 AM', NULL, 2, 6.19, N'Richter Supermarkt', N'Starenweg 5', N'Gen?ve', NULL, N'1204', N'Switzerland')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11076, N'BONAP', 4, '5/6/1998 12:00:00 AM', '6/3/1998 12:00:00 AM', NULL, 2, 38.28, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11077, N'RATTC', 1, '5/6/1998 12:00:00 AM', '6/3/1998 12:00:00 AM', NULL, 2, 8.53, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA')

SET IDENTITY_INSERT Orders OFF

--------------------------------------------------------

--[Order Details]

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10248, 11, 14, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10248, 42, 9.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10248, 72, 34.8, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10249, 14, 18.6, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10249, 51, 42.4, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10250, 41, 7.7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10250, 51, 42.4, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10250, 65, 16.8, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10251, 22, 16.8, 6, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10251, 57, 15.6, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10251, 65, 16.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10252, 20, 64.8, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10252, 33, 2, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10252, 60, 27.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10253, 31, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10253, 39, 14.4, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10253, 49, 16, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10254, 24, 3.6, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10254, 55, 19.2, 21, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10254, 74, 8, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10255, 2, 15.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10255, 16, 13.9, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10255, 36, 15.2, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10255, 59, 44, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10256, 53, 26.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10256, 77, 10.4, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10257, 27, 35.1, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10257, 39, 14.4, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10257, 77, 10.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10258, 2, 15.2, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10258, 5, 17, 65, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10258, 32, 25.6, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10259, 21, 8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10259, 37, 20.8, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10260, 41, 7.7, 16, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10260, 57, 15.6, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10260, 62, 39.4, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10260, 70, 12, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10261, 21, 8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10261, 35, 14.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10262, 5, 17, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10262, 7, 24, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10262, 56, 30.4, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10263, 16, 13.9, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10263, 24, 3.6, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10263, 30, 20.7, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10263, 74, 8, 36, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10264, 2, 15.2, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10264, 41, 7.7, 25, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10265, 17, 31.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10265, 70, 12, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10266, 12, 30.4, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10267, 40, 14.7, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10267, 59, 44, 70, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10267, 76, 14.4, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10268, 29, 99, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10268, 72, 27.8, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10269, 33, 2, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10269, 72, 27.8, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10270, 36, 15.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10270, 43, 36.8, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10271, 33, 2, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10272, 20, 64.8, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10272, 31, 10, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10272, 72, 27.8, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10273, 10, 24.8, 24, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10273, 31, 10, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10273, 33, 2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10273, 40, 14.7, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10273, 76, 14.4, 33, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10274, 71, 17.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10274, 72, 27.8, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10275, 24, 3.6, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10275, 59, 44, 6, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10276, 10, 24.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10276, 13, 4.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10277, 28, 36.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10277, 62, 39.4, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10278, 44, 15.5, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10278, 59, 44, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10278, 63, 35.1, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10278, 73, 12, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10279, 17, 31.2, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10280, 24, 3.6, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10280, 55, 19.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10280, 75, 6.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10281, 19, 7.3, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10281, 24, 3.6, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10281, 35, 14.4, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10282, 30, 20.7, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10282, 57, 15.6, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10283, 15, 12.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10283, 19, 7.3, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10283, 60, 27.2, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10283, 72, 27.8, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10284, 27, 35.1, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10284, 44, 15.5, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10284, 60, 27.2, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10284, 67, 11.2, 5, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10285, 1, 14.4, 45, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10285, 40, 14.7, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10285, 53, 26.2, 36, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10286, 35, 14.4, 100, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10286, 62, 39.4, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10287, 16, 13.9, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10287, 34, 11.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10287, 46, 9.6, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10288, 54, 5.9, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10288, 68, 10, 3, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10289, 3, 8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10289, 64, 26.6, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10290, 5, 17, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10290, 29, 99, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10290, 49, 16, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10290, 77, 10.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10291, 13, 4.8, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10291, 44, 15.5, 24, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10291, 51, 42.4, 2, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10292, 20, 64.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10293, 18, 50, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10293, 24, 3.6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10293, 63, 35.1, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10293, 75, 6.2, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10294, 1, 14.4, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10294, 17, 31.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10294, 43, 36.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10294, 60, 27.2, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10294, 75, 6.2, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10295, 56, 30.4, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10296, 11, 16.8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10296, 16, 13.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10296, 69, 28.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10297, 39, 14.4, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10297, 72, 27.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10298, 2, 15.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10298, 36, 15.2, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10298, 59, 44, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10298, 62, 39.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10299, 19, 7.3, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10299, 70, 12, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10300, 66, 13.6, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10300, 68, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10301, 40, 14.7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10301, 56, 30.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10302, 17, 31.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10302, 28, 36.4, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10302, 43, 36.8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10303, 40, 14.7, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10303, 65, 16.8, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10303, 68, 10, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10304, 49, 16, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10304, 59, 44, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10304, 71, 17.2, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10305, 18, 50, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10305, 29, 99, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10305, 39, 14.4, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10306, 30, 20.7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10306, 53, 26.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10306, 54, 5.9, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10307, 62, 39.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10307, 68, 10, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10308, 69, 28.8, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10308, 70, 12, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10309, 4, 17.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10309, 6, 20, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10309, 42, 11.2, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10309, 43, 36.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10309, 71, 17.2, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10310, 16, 13.9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10310, 62, 39.4, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10311, 42, 11.2, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10311, 69, 28.8, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10312, 28, 36.4, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10312, 43, 36.8, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10312, 53, 26.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10312, 75, 6.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10313, 36, 15.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10314, 32, 25.6, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10314, 58, 10.6, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10314, 62, 39.4, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10315, 34, 11.2, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10315, 70, 12, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10316, 41, 7.7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10316, 62, 39.4, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10317, 1, 14.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10318, 41, 7.7, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10318, 76, 14.4, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10319, 17, 31.2, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10319, 28, 36.4, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10319, 76, 14.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10320, 71, 17.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10321, 35, 14.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10322, 52, 5.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10323, 15, 12.4, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10323, 25, 11.2, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10323, 39, 14.4, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10324, 16, 13.9, 21, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10324, 35, 14.4, 70, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10324, 46, 9.6, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10324, 59, 44, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10324, 63, 35.1, 80, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10325, 6, 20, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10325, 13, 4.8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10325, 14, 18.6, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10325, 31, 10, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10325, 72, 27.8, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10326, 4, 17.6, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10326, 57, 15.6, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10326, 75, 6.2, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10327, 2, 15.2, 25, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10327, 11, 16.8, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10327, 30, 20.7, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10327, 58, 10.6, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10328, 59, 44, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10328, 65, 16.8, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10328, 68, 10, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10329, 19, 7.3, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10329, 30, 20.7, 8, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10329, 38, 210.8, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10329, 56, 30.4, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10330, 26, 24.9, 50, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10330, 72, 27.8, 25, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10331, 54, 5.9, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10332, 18, 50, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10332, 42, 11.2, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10332, 47, 7.6, 16, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10333, 14, 18.6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10333, 21, 8, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10333, 71, 17.2, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10334, 52, 5.6, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10334, 68, 10, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10335, 2, 15.2, 7, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10335, 31, 10, 25, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10335, 32, 25.6, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10335, 51, 42.4, 48, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10336, 4, 17.6, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10337, 23, 7.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10337, 26, 24.9, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10337, 36, 15.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10337, 37, 20.8, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10337, 72, 27.8, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10338, 17, 31.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10338, 30, 20.7, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10339, 4, 17.6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10339, 17, 31.2, 70, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10339, 62, 39.4, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10340, 18, 50, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10340, 41, 7.7, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10340, 43, 36.8, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10341, 33, 2, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10341, 59, 44, 9, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10342, 2, 15.2, 24, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10342, 31, 10, 56, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10342, 36, 15.2, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10342, 55, 19.2, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10343, 64, 26.6, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10343, 68, 10, 4, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10343, 76, 14.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10344, 4, 17.6, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10344, 8, 32, 70, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10345, 8, 32, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10345, 19, 7.3, 80, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10345, 42, 11.2, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10346, 17, 31.2, 36, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10346, 56, 30.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10347, 25, 11.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10347, 39, 14.4, 50, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10347, 40, 14.7, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10347, 75, 6.2, 6, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10348, 1, 14.4, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10348, 23, 7.2, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10349, 54, 5.9, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10350, 50, 13, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10350, 69, 28.8, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10351, 38, 210.8, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10351, 41, 7.7, 13, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10351, 44, 15.5, 77, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10351, 65, 16.8, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10352, 24, 3.6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10352, 54, 5.9, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10353, 11, 16.8, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10353, 38, 210.8, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10354, 1, 14.4, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10354, 29, 99, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10355, 24, 3.6, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10355, 57, 15.6, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10356, 31, 10, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10356, 55, 19.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10356, 69, 28.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10357, 10, 24.8, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10357, 26, 24.9, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10357, 60, 27.2, 8, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10358, 24, 3.6, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10358, 34, 11.2, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10358, 36, 15.2, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10359, 16, 13.9, 56, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10359, 31, 10, 70, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10359, 60, 27.2, 80, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10360, 28, 36.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10360, 29, 99, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10360, 38, 210.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10360, 49, 16, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10360, 54, 5.9, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10361, 39, 14.4, 54, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10361, 60, 27.2, 55, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10362, 25, 11.2, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10362, 51, 42.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10362, 54, 5.9, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10363, 31, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10363, 75, 6.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10363, 76, 14.4, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10364, 69, 28.8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10364, 71, 17.2, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10365, 11, 16.8, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10366, 65, 16.8, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10366, 77, 10.4, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10367, 34, 11.2, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10367, 54, 5.9, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10367, 65, 16.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10367, 77, 10.4, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10368, 21, 8, 5, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10368, 28, 36.4, 13, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10368, 57, 15.6, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10368, 64, 26.6, 35, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10369, 29, 99, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10369, 56, 30.4, 18, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10370, 1, 14.4, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10370, 64, 26.6, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10370, 74, 8, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10371, 36, 15.2, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10372, 20, 64.8, 12, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10372, 38, 210.8, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10372, 60, 27.2, 70, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10372, 72, 27.8, 42, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10373, 58, 10.6, 80, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10373, 71, 17.2, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10374, 31, 10, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10374, 58, 10.6, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10375, 14, 18.6, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10375, 54, 5.9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10376, 31, 10, 42, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10377, 28, 36.4, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10377, 39, 14.4, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10378, 71, 17.2, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10379, 41, 7.7, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10379, 63, 35.1, 16, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10379, 65, 16.8, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10380, 30, 20.7, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10380, 53, 26.2, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10380, 60, 27.2, 6, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10380, 70, 12, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10381, 74, 8, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10382, 5, 17, 32, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10382, 18, 50, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10382, 29, 99, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10382, 33, 2, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10382, 74, 8, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10383, 13, 4.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10383, 50, 13, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10383, 56, 30.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10384, 20, 64.8, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10384, 60, 27.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10385, 7, 24, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10385, 60, 27.2, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10385, 68, 10, 8, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10386, 24, 3.6, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10386, 34, 11.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10387, 24, 3.6, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10387, 28, 36.4, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10387, 59, 44, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10387, 71, 17.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10388, 45, 7.6, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10388, 52, 5.6, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10388, 53, 26.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10389, 10, 24.8, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10389, 55, 19.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10389, 62, 39.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10389, 70, 12, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10390, 31, 10, 60, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10390, 35, 14.4, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10390, 46, 9.6, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10390, 72, 27.8, 24, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10391, 13, 4.8, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10392, 69, 28.8, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10393, 2, 15.2, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10393, 14, 18.6, 42, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10393, 25, 11.2, 7, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10393, 26, 24.9, 70, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10393, 31, 10, 32, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10394, 13, 4.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10394, 62, 39.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10395, 46, 9.6, 28, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10395, 53, 26.2, 70, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10395, 69, 28.8, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10396, 23, 7.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10396, 71, 17.2, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10396, 72, 27.8, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10397, 21, 8, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10397, 51, 42.4, 18, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10398, 35, 14.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10398, 55, 19.2, 120, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10399, 68, 10, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10399, 71, 17.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10399, 76, 14.4, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10399, 77, 10.4, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10400, 29, 99, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10400, 35, 14.4, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10400, 49, 16, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10401, 30, 20.7, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10401, 56, 30.4, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10401, 65, 16.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10401, 71, 17.2, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10402, 23, 7.2, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10402, 63, 35.1, 65, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10403, 16, 13.9, 21, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10403, 48, 10.2, 70, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10404, 26, 24.9, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10404, 42, 11.2, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10404, 49, 16, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10405, 3, 8, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10406, 1, 14.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10406, 21, 8, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10406, 28, 36.4, 42, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10406, 36, 15.2, 5, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10406, 40, 14.7, 2, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10407, 11, 16.8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10407, 69, 28.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10407, 71, 17.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10408, 37, 20.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10408, 54, 5.9, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10408, 62, 39.4, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10409, 14, 18.6, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10409, 21, 8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10410, 33, 2, 49, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10410, 59, 44, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10411, 41, 7.7, 25, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10411, 44, 15.5, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10411, 59, 44, 9, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10412, 14, 18.6, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10413, 1, 14.4, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10413, 62, 39.4, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10413, 76, 14.4, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10414, 19, 7.3, 18, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10414, 33, 2, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10415, 17, 31.2, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10415, 33, 2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10416, 19, 7.3, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10416, 53, 26.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10416, 57, 15.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10417, 38, 210.8, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10417, 46, 9.6, 2, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10417, 68, 10, 36, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10417, 77, 10.4, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10418, 2, 15.2, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10418, 47, 7.6, 55, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10418, 61, 22.8, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10418, 74, 8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10419, 60, 27.2, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10419, 69, 28.8, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10420, 9, 77.6, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10420, 13, 4.8, 2, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10420, 70, 12, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10420, 73, 12, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10421, 19, 7.3, 4, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10421, 26, 24.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10421, 53, 26.2, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10421, 77, 10.4, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10422, 26, 24.9, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10423, 31, 10, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10423, 59, 44, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10424, 35, 14.4, 60, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10424, 38, 210.8, 49, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10424, 68, 10, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10425, 55, 19.2, 10, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10425, 76, 14.4, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10426, 56, 30.4, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10426, 64, 26.6, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10427, 14, 18.6, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10428, 46, 9.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10429, 50, 13, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10429, 63, 35.1, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10430, 17, 31.2, 45, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10430, 21, 8, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10430, 56, 30.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10430, 59, 44, 70, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10431, 17, 31.2, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10431, 40, 14.7, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10431, 47, 7.6, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10432, 26, 24.9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10432, 54, 5.9, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10433, 56, 30.4, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10434, 11, 16.8, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10434, 76, 14.4, 18, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10435, 2, 15.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10435, 22, 16.8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10435, 72, 27.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10436, 46, 9.6, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10436, 56, 30.4, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10436, 64, 26.6, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10436, 75, 6.2, 24, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10437, 53, 26.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10438, 19, 7.3, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10438, 34, 11.2, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10438, 57, 15.6, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10439, 12, 30.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10439, 16, 13.9, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10439, 64, 26.6, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10439, 74, 8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10440, 2, 15.2, 45, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10440, 16, 13.9, 49, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10440, 29, 99, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10440, 61, 22.8, 90, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10441, 27, 35.1, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10442, 11, 16.8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10442, 54, 5.9, 80, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10442, 66, 13.6, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10443, 11, 16.8, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10443, 28, 36.4, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10444, 17, 31.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10444, 26, 24.9, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10444, 35, 14.4, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10444, 41, 7.7, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10445, 39, 14.4, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10445, 54, 5.9, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10446, 19, 7.3, 12, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10446, 24, 3.6, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10446, 31, 10, 3, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10446, 52, 5.6, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10447, 19, 7.3, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10447, 65, 16.8, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10447, 71, 17.2, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10448, 26, 24.9, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10448, 40, 14.7, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10449, 10, 24.8, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10449, 52, 5.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10449, 62, 39.4, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10450, 10, 24.8, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10450, 54, 5.9, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10451, 55, 19.2, 120, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10451, 64, 26.6, 35, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10451, 65, 16.8, 28, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10451, 77, 10.4, 55, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10452, 28, 36.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10452, 44, 15.5, 100, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10453, 48, 10.2, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10453, 70, 12, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10454, 16, 13.9, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10454, 33, 2, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10454, 46, 9.6, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10455, 39, 14.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10455, 53, 26.2, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10455, 61, 22.8, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10455, 71, 17.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10456, 21, 8, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10456, 49, 16, 21, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10457, 59, 44, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10458, 26, 24.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10458, 28, 36.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10458, 43, 36.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10458, 56, 30.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10458, 71, 17.2, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10459, 7, 24, 16, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10459, 46, 9.6, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10459, 72, 27.8, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10460, 68, 10, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10460, 75, 6.2, 4, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10461, 21, 8, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10461, 30, 20.7, 28, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10461, 55, 19.2, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10462, 13, 4.8, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10462, 23, 7.2, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10463, 19, 7.3, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10463, 42, 11.2, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10464, 4, 17.6, 16, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10464, 43, 36.8, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10464, 56, 30.4, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10464, 60, 27.2, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10465, 24, 3.6, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10465, 29, 99, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10465, 40, 14.7, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10465, 45, 7.6, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10465, 50, 13, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10466, 11, 16.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10466, 46, 9.6, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10467, 24, 3.6, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10467, 25, 11.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10468, 30, 20.7, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10468, 43, 36.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10469, 2, 15.2, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10469, 16, 13.9, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10469, 44, 15.5, 2, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10470, 18, 50, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10470, 23, 7.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10470, 64, 26.6, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10471, 7, 24, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10471, 56, 30.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10472, 24, 3.6, 80, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10472, 51, 42.4, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10473, 33, 2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10473, 71, 17.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10474, 14, 18.6, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10474, 28, 36.4, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10474, 40, 14.7, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10474, 75, 6.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10475, 31, 10, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10475, 66, 13.6, 60, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10475, 76, 14.4, 42, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10476, 55, 19.2, 2, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10476, 70, 12, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10477, 1, 14.4, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10477, 21, 8, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10477, 39, 14.4, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10478, 10, 24.8, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10479, 38, 210.8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10479, 53, 26.2, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10479, 59, 44, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10479, 64, 26.6, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10480, 47, 7.6, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10480, 59, 44, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10481, 49, 16, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10481, 60, 27.2, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10482, 40, 14.7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10483, 34, 11.2, 35, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10483, 77, 10.4, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10484, 21, 8, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10484, 40, 14.7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10484, 51, 42.4, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10485, 2, 15.2, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10485, 3, 8, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10485, 55, 19.2, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10485, 70, 12, 60, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10486, 11, 16.8, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10486, 51, 42.4, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10486, 74, 8, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10487, 19, 7.3, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10487, 26, 24.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10487, 54, 5.9, 24, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10488, 59, 44, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10488, 73, 12, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10489, 11, 16.8, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10489, 16, 13.9, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10490, 59, 44, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10490, 68, 10, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10490, 75, 6.2, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10491, 44, 15.5, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10491, 77, 10.4, 7, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10492, 25, 11.2, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10492, 42, 11.2, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10493, 65, 16.8, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10493, 66, 13.6, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10493, 69, 28.8, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10494, 56, 30.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10495, 23, 7.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10495, 41, 7.7, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10495, 77, 10.4, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10496, 31, 10, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10497, 56, 30.4, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10497, 72, 27.8, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10497, 77, 10.4, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10498, 24, 4.5, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10498, 40, 18.4, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10498, 42, 14, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10499, 28, 45.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10499, 49, 20, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10500, 15, 15.5, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10500, 28, 45.6, 8, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10501, 54, 7.45, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10502, 45, 9.5, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10502, 53, 32.8, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10502, 67, 14, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10503, 14, 23.25, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10503, 65, 21.05, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10504, 2, 19, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10504, 21, 10, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10504, 53, 32.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10504, 61, 28.5, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10505, 62, 49.3, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10506, 25, 14, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10506, 70, 15, 14, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10507, 43, 46, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10507, 48, 12.75, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10508, 13, 6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10508, 39, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10509, 28, 45.6, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10510, 29, 123.79, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10510, 75, 7.75, 36, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10511, 4, 22, 50, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10511, 7, 30, 50, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10511, 8, 40, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10512, 24, 4.5, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10512, 46, 12, 9, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10512, 47, 9.5, 6, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10512, 60, 34, 12, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10513, 21, 10, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10513, 32, 32, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10513, 61, 28.5, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10514, 20, 81, 39, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10514, 28, 45.6, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10514, 56, 38, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10514, 65, 21.05, 39, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10514, 75, 7.75, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10515, 9, 97, 16, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10515, 16, 17.45, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10515, 27, 43.9, 120, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10515, 33, 2.5, 16, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10515, 60, 34, 84, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10516, 18, 62.5, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10516, 41, 9.65, 80, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10516, 42, 14, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10517, 52, 7, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10517, 59, 55, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10517, 70, 15, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10518, 24, 4.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10518, 38, 263.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10518, 44, 19.45, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10519, 10, 31, 16, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10519, 56, 38, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10519, 60, 34, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10520, 24, 4.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10520, 53, 32.8, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10521, 35, 18, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10521, 41, 9.65, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10521, 68, 12.5, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10522, 1, 18, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10522, 8, 40, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10522, 30, 25.89, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10522, 40, 18.4, 25, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10523, 17, 39, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10523, 20, 81, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10523, 37, 26, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10523, 41, 9.65, 6, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10524, 10, 31, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10524, 30, 25.89, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10524, 43, 46, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10524, 54, 7.45, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10525, 36, 19, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10525, 40, 18.4, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10526, 1, 18, 8, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10526, 13, 6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10526, 56, 38, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10527, 4, 22, 50, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10527, 36, 19, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10528, 11, 21, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10528, 33, 2.5, 8, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10528, 72, 34.8, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10529, 55, 24, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10529, 68, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10529, 69, 36, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10530, 17, 39, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10530, 43, 46, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10530, 61, 28.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10530, 76, 18, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10531, 59, 55, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10532, 30, 25.89, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10532, 66, 17, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10533, 4, 22, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10533, 72, 34.8, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10533, 73, 15, 24, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10534, 30, 25.89, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10534, 40, 18.4, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10534, 54, 7.45, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10535, 11, 21, 50, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10535, 40, 18.4, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10535, 57, 19.5, 5, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10535, 59, 55, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10536, 12, 38, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10536, 31, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10536, 33, 2.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10536, 60, 34, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10537, 31, 12.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10537, 51, 53, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10537, 58, 13.25, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10537, 72, 34.8, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10537, 73, 15, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10538, 70, 15, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10538, 72, 34.8, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10539, 13, 6, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10539, 21, 10, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10539, 33, 2.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10539, 49, 20, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10540, 3, 10, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10540, 26, 31.23, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10540, 38, 263.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10540, 68, 12.5, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10541, 24, 4.5, 35, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10541, 38, 263.5, 4, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10541, 65, 21.05, 36, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10541, 71, 21.5, 9, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10542, 11, 21, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10542, 54, 7.45, 24, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10543, 12, 38, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10543, 23, 9, 70, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10544, 28, 45.6, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10544, 67, 14, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10545, 11, 21, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10546, 7, 30, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10546, 35, 18, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10546, 62, 49.3, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10547, 32, 32, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10547, 36, 19, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10548, 34, 14, 10, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10548, 41, 9.65, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10549, 31, 12.5, 55, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10549, 45, 9.5, 100, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10549, 51, 53, 48, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10550, 17, 39, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10550, 19, 9.2, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10550, 21, 10, 6, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10550, 61, 28.5, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10551, 16, 17.45, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10551, 35, 18, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10551, 44, 19.45, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10552, 69, 36, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10552, 75, 7.75, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10553, 11, 21, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10553, 16, 17.45, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10553, 22, 21, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10553, 31, 12.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10553, 35, 18, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10554, 16, 17.45, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10554, 23, 9, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10554, 62, 49.3, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10554, 77, 13, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10555, 14, 23.25, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10555, 19, 9.2, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10555, 24, 4.5, 18, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10555, 51, 53, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10555, 56, 38, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10556, 72, 34.8, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10557, 64, 33.25, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10557, 75, 7.75, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10558, 47, 9.5, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10558, 51, 53, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10558, 52, 7, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10558, 53, 32.8, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10558, 73, 15, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10559, 41, 9.65, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10559, 55, 24, 18, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10560, 30, 25.89, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10560, 62, 49.3, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10561, 44, 19.45, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10561, 51, 53, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10562, 33, 2.5, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10562, 62, 49.3, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10563, 36, 19, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10563, 52, 7, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10564, 17, 39, 16, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10564, 31, 12.5, 6, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10564, 55, 24, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10565, 24, 4.5, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10565, 64, 33.25, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10566, 11, 21, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10566, 18, 62.5, 18, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10566, 76, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10567, 31, 12.5, 60, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10567, 51, 53, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10567, 59, 55, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10568, 10, 31, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10569, 31, 12.5, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10569, 76, 18, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10570, 11, 21, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10570, 56, 38, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10571, 14, 23.25, 11, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10571, 42, 14, 28, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10572, 16, 17.45, 12, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10572, 32, 32, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10572, 40, 18.4, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10572, 75, 7.75, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10573, 17, 39, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10573, 34, 14, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10573, 53, 32.8, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10574, 33, 2.5, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10574, 40, 18.4, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10574, 62, 49.3, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10574, 64, 33.25, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10575, 59, 55, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10575, 63, 43.9, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10575, 72, 34.8, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10575, 76, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10576, 1, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10576, 31, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10576, 44, 19.45, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10577, 39, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10577, 75, 7.75, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10577, 77, 13, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10578, 35, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10578, 57, 19.5, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10579, 15, 15.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10579, 75, 7.75, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10580, 14, 23.25, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10580, 41, 9.65, 9, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10580, 65, 21.05, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10581, 75, 7.75, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10582, 57, 19.5, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10582, 76, 18, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10583, 29, 123.79, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10583, 60, 34, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10583, 69, 36, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10584, 31, 12.5, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10585, 47, 9.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10586, 52, 7, 4, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10587, 26, 31.23, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10587, 35, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10587, 77, 13, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10588, 18, 62.5, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10588, 42, 14, 100, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10589, 35, 18, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10590, 1, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10590, 77, 13, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10591, 3, 10, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10591, 7, 30, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10591, 54, 7.45, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10592, 15, 15.5, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10592, 26, 31.23, 5, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10593, 20, 81, 21, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10593, 69, 36, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10593, 76, 18, 4, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10594, 52, 7, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10594, 58, 13.25, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10595, 35, 18, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10595, 61, 28.5, 120, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10595, 69, 36, 65, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10596, 56, 38, 5, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10596, 63, 43.9, 24, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10596, 75, 7.75, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10597, 24, 4.5, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10597, 57, 19.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10597, 65, 21.05, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10598, 27, 43.9, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10598, 71, 21.5, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10599, 62, 49.3, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10600, 54, 7.45, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10600, 73, 15, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10601, 13, 6, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10601, 59, 55, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10602, 77, 13, 5, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10603, 22, 21, 48, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10603, 49, 20, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10604, 48, 12.75, 6, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10604, 76, 18, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10605, 16, 17.45, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10605, 59, 55, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10605, 60, 34, 70, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10605, 71, 21.5, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10606, 4, 22, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10606, 55, 24, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10606, 62, 49.3, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10607, 7, 30, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10607, 17, 39, 100, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10607, 33, 2.5, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10607, 40, 18.4, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10607, 72, 34.8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10608, 56, 38, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10609, 1, 18, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10609, 10, 31, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10609, 21, 10, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10610, 36, 19, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10611, 1, 18, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10611, 2, 19, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10611, 60, 34, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10612, 10, 31, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10612, 36, 19, 55, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10612, 49, 20, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10612, 60, 34, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10612, 76, 18, 80, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10613, 13, 6, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10613, 75, 7.75, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10614, 11, 21, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10614, 21, 10, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10614, 39, 18, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10615, 55, 24, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10616, 38, 263.5, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10616, 56, 38, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10616, 70, 15, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10616, 71, 21.5, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10617, 59, 55, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10618, 6, 25, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10618, 56, 38, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10618, 68, 12.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10619, 21, 10, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10619, 22, 21, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10620, 24, 4.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10620, 52, 7, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10621, 19, 9.2, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10621, 23, 9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10621, 70, 15, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10621, 71, 21.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10622, 2, 19, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10622, 68, 12.5, 18, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10623, 14, 23.25, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10623, 19, 9.2, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10623, 21, 10, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10623, 24, 4.5, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10623, 35, 18, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10624, 28, 45.6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10624, 29, 123.79, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10624, 44, 19.45, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10625, 14, 23.25, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10625, 42, 14, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10625, 60, 34, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10626, 53, 32.8, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10626, 60, 34, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10626, 71, 21.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10627, 62, 49.3, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10627, 73, 15, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10628, 1, 18, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10629, 29, 123.79, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10629, 64, 33.25, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10630, 55, 24, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10630, 76, 18, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10631, 75, 7.75, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10632, 2, 19, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10632, 33, 2.5, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10633, 12, 38, 36, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10633, 13, 6, 13, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10633, 26, 31.23, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10633, 62, 49.3, 80, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10634, 7, 30, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10634, 18, 62.5, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10634, 51, 53, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10634, 75, 7.75, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10635, 4, 22, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10635, 5, 21.35, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10635, 22, 21, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10636, 4, 22, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10636, 58, 13.25, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10637, 11, 21, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10637, 50, 16.25, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10637, 56, 38, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10638, 45, 9.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10638, 65, 21.05, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10638, 72, 34.8, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10639, 18, 62.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10640, 69, 36, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10640, 70, 15, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10641, 2, 19, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10641, 40, 18.4, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10642, 21, 10, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10642, 61, 28.5, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10643, 28, 45.6, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10643, 39, 18, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10643, 46, 12, 2, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10644, 18, 62.5, 4, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10644, 43, 46, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10644, 46, 12, 21, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10645, 18, 62.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10645, 36, 19, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10646, 1, 18, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10646, 10, 31, 18, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10646, 71, 21.5, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10646, 77, 13, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10647, 19, 9.2, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10647, 39, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10648, 22, 21, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10648, 24, 4.5, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10649, 28, 45.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10649, 72, 34.8, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10650, 30, 25.89, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10650, 53, 32.8, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10650, 54, 7.45, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10651, 19, 9.2, 12, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10651, 22, 21, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10652, 30, 25.89, 2, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10652, 42, 14, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10653, 16, 17.45, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10653, 60, 34, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10654, 4, 22, 12, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10654, 39, 18, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10654, 54, 7.45, 6, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10655, 41, 9.65, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10656, 14, 23.25, 3, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10656, 44, 19.45, 28, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10656, 47, 9.5, 6, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10657, 15, 15.5, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10657, 41, 9.65, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10657, 46, 12, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10657, 47, 9.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10657, 56, 38, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10657, 60, 34, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10658, 21, 10, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10658, 40, 18.4, 70, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10658, 60, 34, 55, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10658, 77, 13, 70, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10659, 31, 12.5, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10659, 40, 18.4, 24, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10659, 70, 15, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10660, 20, 81, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10661, 39, 18, 3, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10661, 58, 13.25, 49, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10662, 68, 12.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10663, 40, 18.4, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10663, 42, 14, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10663, 51, 53, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10664, 10, 31, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10664, 56, 38, 12, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10664, 65, 21.05, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10665, 51, 53, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10665, 59, 55, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10665, 76, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10666, 29, 123.79, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10666, 65, 21.05, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10667, 69, 36, 45, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10667, 71, 21.5, 14, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10668, 31, 12.5, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10668, 55, 24, 4, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10668, 64, 33.25, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10669, 36, 19, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10670, 23, 9, 32, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10670, 46, 12, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10670, 67, 14, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10670, 73, 15, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10670, 75, 7.75, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10671, 16, 17.45, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10671, 62, 49.3, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10671, 65, 21.05, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10672, 38, 263.5, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10672, 71, 21.5, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10673, 16, 17.45, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10673, 42, 14, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10673, 43, 46, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10674, 23, 9, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10675, 14, 23.25, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10675, 53, 32.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10675, 58, 13.25, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10676, 10, 31, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10676, 19, 9.2, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10676, 44, 19.45, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10677, 26, 31.23, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10677, 33, 2.5, 8, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10678, 12, 38, 100, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10678, 33, 2.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10678, 41, 9.65, 120, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10678, 54, 7.45, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10679, 59, 55, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10680, 16, 17.45, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10680, 31, 12.5, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10680, 42, 14, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10681, 19, 9.2, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10681, 21, 10, 12, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10681, 64, 33.25, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10682, 33, 2.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10682, 66, 17, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10682, 75, 7.75, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10683, 52, 7, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10684, 40, 18.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10684, 47, 9.5, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10684, 60, 34, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10685, 10, 31, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10685, 41, 9.65, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10685, 47, 9.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10686, 17, 39, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10686, 26, 31.23, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10687, 9, 97, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10687, 29, 123.79, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10687, 36, 19, 6, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10688, 10, 31, 18, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10688, 28, 45.6, 60, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10688, 34, 14, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10689, 1, 18, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10690, 56, 38, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10690, 77, 13, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10691, 1, 18, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10691, 29, 123.79, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10691, 43, 46, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10691, 44, 19.45, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10691, 62, 49.3, 48, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10692, 63, 43.9, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10693, 9, 97, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10693, 54, 7.45, 60, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10693, 69, 36, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10693, 73, 15, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10694, 7, 30, 90, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10694, 59, 55, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10694, 70, 15, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10695, 8, 40, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10695, 12, 38, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10695, 24, 4.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10696, 17, 39, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10696, 46, 12, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10697, 19, 9.2, 7, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10697, 35, 18, 9, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10697, 58, 13.25, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10697, 70, 15, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10698, 11, 21, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10698, 17, 39, 8, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10698, 29, 123.79, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10698, 65, 21.05, 65, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10698, 70, 15, 8, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10699, 47, 9.5, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10700, 1, 18, 5, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10700, 34, 14, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10700, 68, 12.5, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10700, 71, 21.5, 60, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10701, 59, 55, 42, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10701, 71, 21.5, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10701, 76, 18, 35, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10702, 3, 10, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10702, 76, 18, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10703, 2, 19, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10703, 59, 55, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10703, 73, 15, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10704, 4, 22, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10704, 24, 4.5, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10704, 48, 12.75, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10705, 31, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10705, 32, 32, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10706, 16, 17.45, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10706, 43, 46, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10706, 59, 55, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10707, 55, 24, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10707, 57, 19.5, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10707, 70, 15, 28, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10708, 5, 21.35, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10708, 36, 19, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10709, 8, 40, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10709, 51, 53, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10709, 60, 34, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10710, 19, 9.2, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10710, 47, 9.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10711, 19, 9.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10711, 41, 9.65, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10711, 53, 32.8, 120, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10712, 53, 32.8, 3, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10712, 56, 38, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10713, 10, 31, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10713, 26, 31.23, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10713, 45, 9.5, 110, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10713, 46, 12, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10714, 2, 19, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10714, 17, 39, 27, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10714, 47, 9.5, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10714, 56, 38, 18, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10714, 58, 13.25, 12, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10715, 10, 31, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10715, 71, 21.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10716, 21, 10, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10716, 51, 53, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10716, 61, 28.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10717, 21, 10, 32, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10717, 54, 7.45, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10717, 69, 36, 25, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10718, 12, 38, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10718, 16, 17.45, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10718, 36, 19, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10718, 62, 49.3, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10719, 18, 62.5, 12, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10719, 30, 25.89, 3, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10719, 54, 7.45, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10720, 35, 18, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10720, 71, 21.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10721, 44, 19.45, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10722, 2, 19, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10722, 31, 12.5, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10722, 68, 12.5, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10722, 75, 7.75, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10723, 26, 31.23, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10724, 10, 31, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10724, 61, 28.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10725, 41, 9.65, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10725, 52, 7, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10725, 55, 24, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10726, 4, 22, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10726, 11, 21, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10727, 17, 39, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10727, 56, 38, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10727, 59, 55, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10728, 30, 25.89, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10728, 40, 18.4, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10728, 55, 24, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10728, 60, 34, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10729, 1, 18, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10729, 21, 10, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10729, 50, 16.25, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10730, 16, 17.45, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10730, 31, 12.5, 3, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10730, 65, 21.05, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10731, 21, 10, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10731, 51, 53, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10732, 76, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10733, 14, 23.25, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10733, 28, 45.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10733, 52, 7, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10734, 6, 25, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10734, 30, 25.89, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10734, 76, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10735, 61, 28.5, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10735, 77, 13, 2, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10736, 65, 21.05, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10736, 75, 7.75, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10737, 13, 6, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10737, 41, 9.65, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10738, 16, 17.45, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10739, 36, 19, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10739, 52, 7, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10740, 28, 45.6, 5, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10740, 35, 18, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10740, 45, 9.5, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10740, 56, 38, 14, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10741, 2, 19, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10742, 3, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10742, 60, 34, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10742, 72, 34.8, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10743, 46, 12, 28, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10744, 40, 18.4, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10745, 18, 62.5, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10745, 44, 19.45, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10745, 59, 55, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10745, 72, 34.8, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10746, 13, 6, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10746, 42, 14, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10746, 62, 49.3, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10746, 69, 36, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10747, 31, 12.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10747, 41, 9.65, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10747, 63, 43.9, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10747, 69, 36, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10748, 23, 9, 44, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10748, 40, 18.4, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10748, 56, 38, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10749, 56, 38, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10749, 59, 55, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10749, 76, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10750, 14, 23.25, 5, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10750, 45, 9.5, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10750, 59, 55, 25, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10751, 26, 31.23, 12, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10751, 30, 25.89, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10751, 50, 16.25, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10751, 73, 15, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10752, 1, 18, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10752, 69, 36, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10753, 45, 9.5, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10753, 74, 10, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10754, 40, 18.4, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10755, 47, 9.5, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10755, 56, 38, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10755, 57, 19.5, 14, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10755, 69, 36, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10756, 18, 62.5, 21, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10756, 36, 19, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10756, 68, 12.5, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10756, 69, 36, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10757, 34, 14, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10757, 59, 55, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10757, 62, 49.3, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10757, 64, 33.25, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10758, 26, 31.23, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10758, 52, 7, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10758, 70, 15, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10759, 32, 32, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10760, 25, 14, 12, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10760, 27, 43.9, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10760, 43, 46, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10761, 25, 14, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10761, 75, 7.75, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10762, 39, 18, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10762, 47, 9.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10762, 51, 53, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10762, 56, 38, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10763, 21, 10, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10763, 22, 21, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10763, 24, 4.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10764, 3, 10, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10764, 39, 18, 130, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10765, 65, 21.05, 80, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10766, 2, 19, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10766, 7, 30, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10766, 68, 12.5, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10767, 42, 14, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10768, 22, 21, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10768, 31, 12.5, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10768, 60, 34, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10768, 71, 21.5, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10769, 41, 9.65, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10769, 52, 7, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10769, 61, 28.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10769, 62, 49.3, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10770, 11, 21, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10771, 71, 21.5, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10772, 29, 123.79, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10772, 59, 55, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10773, 17, 39, 33, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10773, 31, 12.5, 70, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10773, 75, 7.75, 7, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10774, 31, 12.5, 2, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10774, 66, 17, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10775, 10, 31, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10775, 67, 14, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10776, 31, 12.5, 16, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10776, 42, 14, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10776, 45, 9.5, 27, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10776, 51, 53, 120, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10777, 42, 14, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10778, 41, 9.65, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10779, 16, 17.45, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10779, 62, 49.3, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10780, 70, 15, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10780, 77, 13, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10781, 54, 7.45, 3, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10781, 56, 38, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10781, 74, 10, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10782, 31, 12.5, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10783, 31, 12.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10783, 38, 263.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10784, 36, 19, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10784, 39, 18, 2, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10784, 72, 34.8, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10785, 10, 31, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10785, 75, 7.75, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10786, 8, 40, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10786, 30, 25.89, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10786, 75, 7.75, 42, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10787, 2, 19, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10787, 29, 123.79, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10788, 19, 9.2, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10788, 75, 7.75, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10789, 18, 62.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10789, 35, 18, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10789, 63, 43.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10789, 68, 12.5, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10790, 7, 30, 3, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10790, 56, 38, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10791, 29, 123.79, 14, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10791, 41, 9.65, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10792, 2, 19, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10792, 54, 7.45, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10792, 68, 12.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10793, 41, 9.65, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10793, 52, 7, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10794, 14, 23.25, 15, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10794, 54, 7.45, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10795, 16, 17.45, 65, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10795, 17, 39, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10796, 26, 31.23, 21, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10796, 44, 19.45, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10796, 64, 33.25, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10796, 69, 36, 24, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10797, 11, 21, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10798, 62, 49.3, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10798, 72, 34.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10799, 13, 6, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10799, 24, 4.5, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10799, 59, 55, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10800, 11, 21, 50, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10800, 51, 53, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10800, 54, 7.45, 7, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10801, 17, 39, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10801, 29, 123.79, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10802, 30, 25.89, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10802, 51, 53, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10802, 55, 24, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10802, 62, 49.3, 5, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10803, 19, 9.2, 24, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10803, 25, 14, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10803, 59, 55, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10804, 10, 31, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10804, 28, 45.6, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10804, 49, 20, 4, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10805, 34, 14, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10805, 38, 263.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10806, 2, 19, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10806, 65, 21.05, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10806, 74, 10, 15, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10807, 40, 18.4, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10808, 56, 38, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10808, 76, 18, 50, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10809, 52, 7, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10810, 13, 6, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10810, 25, 14, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10810, 70, 15, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10811, 19, 9.2, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10811, 23, 9, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10811, 40, 18.4, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10812, 31, 12.5, 16, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10812, 72, 34.8, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10812, 77, 13, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10813, 2, 19, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10813, 46, 12, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10814, 41, 9.65, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10814, 43, 46, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10814, 48, 12.75, 8, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10814, 61, 28.5, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10815, 33, 2.5, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10816, 38, 263.5, 30, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10816, 62, 49.3, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10817, 26, 31.23, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10817, 38, 263.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10817, 40, 18.4, 60, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10817, 62, 49.3, 25, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10818, 32, 32, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10818, 41, 9.65, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10819, 43, 46, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10819, 75, 7.75, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10820, 56, 38, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10821, 35, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10821, 51, 53, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10822, 62, 49.3, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10822, 70, 15, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10823, 11, 21, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10823, 57, 19.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10823, 59, 55, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10823, 77, 13, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10824, 41, 9.65, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10824, 70, 15, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10825, 26, 31.23, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10825, 53, 32.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10826, 31, 12.5, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10826, 57, 19.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10827, 10, 31, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10827, 39, 18, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10828, 20, 81, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10828, 38, 263.5, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10829, 2, 19, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10829, 8, 40, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10829, 13, 6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10829, 60, 34, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10830, 6, 25, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10830, 39, 18, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10830, 60, 34, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10830, 68, 12.5, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10831, 19, 9.2, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10831, 35, 18, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10831, 38, 263.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10831, 43, 46, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10832, 13, 6, 3, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10832, 25, 14, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10832, 44, 19.45, 16, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10832, 64, 33.25, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10833, 7, 30, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10833, 31, 12.5, 9, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10833, 53, 32.8, 9, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10834, 29, 123.79, 8, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10834, 30, 25.89, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10835, 59, 55, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10835, 77, 13, 2, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10836, 22, 21, 52, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10836, 35, 18, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10836, 57, 19.5, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10836, 60, 34, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10836, 64, 33.25, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10837, 13, 6, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10837, 40, 18.4, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10837, 47, 9.5, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10837, 76, 18, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10838, 1, 18, 4, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10838, 18, 62.5, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10838, 36, 19, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10839, 58, 13.25, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10839, 72, 34.8, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10840, 25, 14, 6, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10840, 39, 18, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10841, 10, 31, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10841, 56, 38, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10841, 59, 55, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10841, 77, 13, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10842, 11, 21, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10842, 43, 46, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10842, 68, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10842, 70, 15, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10843, 51, 53, 4, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10844, 22, 21, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10845, 23, 9, 70, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10845, 35, 18, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10845, 42, 14, 42, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10845, 58, 13.25, 60, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10845, 64, 33.25, 48, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10846, 4, 22, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10846, 70, 15, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10846, 74, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10847, 1, 18, 80, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10847, 19, 9.2, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10847, 37, 26, 60, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10847, 45, 9.5, 36, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10847, 60, 34, 45, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10847, 71, 21.5, 55, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10848, 5, 21.35, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10848, 9, 97, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10849, 3, 10, 49, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10849, 26, 31.23, 18, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10850, 25, 14, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10850, 33, 2.5, 4, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10850, 70, 15, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10851, 2, 19, 5, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10851, 25, 14, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10851, 57, 19.5, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10851, 59, 55, 42, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10852, 2, 19, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10852, 17, 39, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10852, 62, 49.3, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10853, 18, 62.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10854, 10, 31, 100, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10854, 13, 6, 65, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10855, 16, 17.45, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10855, 31, 12.5, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10855, 56, 38, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10855, 65, 21.05, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10856, 2, 19, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10856, 42, 14, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10857, 3, 10, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10857, 26, 31.23, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10857, 29, 123.79, 10, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10858, 7, 30, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10858, 27, 43.9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10858, 70, 15, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10859, 24, 4.5, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10859, 54, 7.45, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10859, 64, 33.25, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10860, 51, 53, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10860, 76, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10861, 17, 39, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10861, 18, 62.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10861, 21, 10, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10861, 33, 2.5, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10861, 62, 49.3, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10862, 11, 21, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10862, 52, 7, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10863, 1, 18, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10863, 58, 13.25, 12, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10864, 35, 18, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10864, 67, 14, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10865, 38, 263.5, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10865, 39, 18, 80, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10866, 2, 19, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10866, 24, 4.5, 6, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10866, 30, 25.89, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10867, 53, 32.8, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10868, 26, 31.23, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10868, 35, 18, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10868, 49, 20, 42, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10869, 1, 18, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10869, 11, 21, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10869, 23, 9, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10869, 68, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10870, 35, 18, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10870, 51, 53, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10871, 6, 25, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10871, 16, 17.45, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10871, 17, 39, 16, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10872, 55, 24, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10872, 62, 49.3, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10872, 64, 33.25, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10872, 65, 21.05, 21, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10873, 21, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10873, 28, 45.6, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10874, 10, 31, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10875, 19, 9.2, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10875, 47, 9.5, 21, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10875, 49, 20, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10876, 46, 12, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10876, 64, 33.25, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10877, 16, 17.45, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10877, 18, 62.5, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10878, 20, 81, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10879, 40, 18.4, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10879, 65, 21.05, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10879, 76, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10880, 23, 9, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10880, 61, 28.5, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10880, 70, 15, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10881, 73, 15, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10882, 42, 14, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10882, 49, 20, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10882, 54, 7.45, 32, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10883, 24, 4.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10884, 21, 10, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10884, 56, 38, 21, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10884, 65, 21.05, 12, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10885, 2, 19, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10885, 24, 4.5, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10885, 70, 15, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10885, 77, 13, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10886, 10, 31, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10886, 31, 12.5, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10886, 77, 13, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10887, 25, 14, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10888, 2, 19, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10888, 68, 12.5, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10889, 11, 21, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10889, 38, 263.5, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10890, 17, 39, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10890, 34, 14, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10890, 41, 9.65, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10891, 30, 25.89, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10892, 59, 55, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10893, 8, 40, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10893, 24, 4.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10893, 29, 123.79, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10893, 30, 25.89, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10893, 36, 19, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10894, 13, 6, 28, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10894, 69, 36, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10894, 75, 7.75, 120, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10895, 24, 4.5, 110, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10895, 39, 18, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10895, 40, 18.4, 91, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10895, 60, 34, 100, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10896, 45, 9.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10896, 56, 38, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10897, 29, 123.79, 80, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10897, 30, 25.89, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10898, 13, 6, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10899, 39, 18, 8, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10900, 70, 15, 3, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10901, 41, 9.65, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10901, 71, 21.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10902, 55, 24, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10902, 62, 49.3, 6, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10903, 13, 6, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10903, 65, 21.05, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10903, 68, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10904, 58, 13.25, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10904, 62, 49.3, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10905, 1, 18, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10906, 61, 28.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10907, 75, 7.75, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10908, 7, 30, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10908, 52, 7, 14, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10909, 7, 30, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10909, 16, 17.45, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10909, 41, 9.65, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10910, 19, 9.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10910, 49, 20, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10910, 61, 28.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10911, 1, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10911, 17, 39, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10911, 67, 14, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10912, 11, 21, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10912, 29, 123.79, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10913, 4, 22, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10913, 33, 2.5, 40, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10913, 58, 13.25, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10914, 71, 21.5, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10915, 17, 39, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10915, 33, 2.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10915, 54, 7.45, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10916, 16, 17.45, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10916, 32, 32, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10916, 57, 19.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10917, 30, 25.89, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10917, 60, 34, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10918, 1, 18, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10918, 60, 34, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10919, 16, 17.45, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10919, 25, 14, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10919, 40, 18.4, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10920, 50, 16.25, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10921, 35, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10921, 63, 43.9, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10922, 17, 39, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10922, 24, 4.5, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10923, 42, 14, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10923, 43, 46, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10923, 67, 14, 24, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10924, 10, 31, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10924, 28, 45.6, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10924, 75, 7.75, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10925, 36, 19, 25, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10925, 52, 7, 12, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10926, 11, 21, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10926, 13, 6, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10926, 19, 9.2, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10926, 72, 34.8, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10927, 20, 81, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10927, 52, 7, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10927, 76, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10928, 47, 9.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10928, 76, 18, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10929, 21, 10, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10929, 75, 7.75, 49, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10929, 77, 13, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10930, 21, 10, 36, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10930, 27, 43.9, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10930, 55, 24, 25, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10930, 58, 13.25, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10931, 13, 6, 42, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10931, 57, 19.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10932, 16, 17.45, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10932, 62, 49.3, 14, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10932, 72, 34.8, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10932, 75, 7.75, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10933, 53, 32.8, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10933, 61, 28.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10934, 6, 25, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10935, 1, 18, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10935, 18, 62.5, 4, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10935, 23, 9, 8, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10936, 36, 19, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10937, 28, 45.6, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10937, 34, 14, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10938, 13, 6, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10938, 43, 46, 24, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10938, 60, 34, 49, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10938, 71, 21.5, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10939, 2, 19, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10939, 67, 14, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10940, 7, 30, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10940, 13, 6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10941, 31, 12.5, 44, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10941, 62, 49.3, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10941, 68, 12.5, 80, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10941, 72, 34.8, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10942, 49, 20, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10943, 13, 6, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10943, 22, 21, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10943, 46, 12, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10944, 11, 21, 5, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10944, 44, 19.45, 18, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10944, 56, 38, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10945, 13, 6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10945, 31, 12.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10946, 10, 31, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10946, 24, 4.5, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10946, 77, 13, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10947, 59, 55, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10948, 50, 16.25, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10948, 51, 53, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10948, 55, 24, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10949, 6, 25, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10949, 10, 31, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10949, 17, 39, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10949, 62, 49.3, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10950, 4, 22, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10951, 33, 2.5, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10951, 41, 9.65, 6, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10951, 75, 7.75, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10952, 6, 25, 16, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10952, 28, 45.6, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10953, 20, 81, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10953, 31, 12.5, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10954, 16, 17.45, 28, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10954, 31, 12.5, 25, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10954, 45, 9.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10954, 60, 34, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10955, 75, 7.75, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10956, 21, 10, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10956, 47, 9.5, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10956, 51, 53, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10957, 30, 25.89, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10957, 35, 18, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10957, 64, 33.25, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10958, 5, 21.35, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10958, 7, 30, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10958, 72, 34.8, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10959, 75, 7.75, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10960, 24, 4.5, 10, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10960, 41, 9.65, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10961, 52, 7, 6, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10961, 76, 18, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10962, 7, 30, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10962, 13, 6, 77, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10962, 53, 32.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10962, 69, 36, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10962, 76, 18, 44, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10963, 60, 34, 2, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10964, 18, 62.5, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10964, 38, 263.5, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10964, 69, 36, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10965, 51, 53, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10966, 37, 26, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10966, 56, 38, 12, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10966, 62, 49.3, 12, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10967, 19, 9.2, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10967, 49, 20, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10968, 12, 38, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10968, 24, 4.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10968, 64, 33.25, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10969, 46, 12, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10970, 52, 7, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10971, 29, 123.79, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10972, 17, 39, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10972, 33, 2.5, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10973, 26, 31.23, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10973, 41, 9.65, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10973, 75, 7.75, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10974, 63, 43.9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10975, 8, 40, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10975, 75, 7.75, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10976, 28, 45.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10977, 39, 18, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10977, 47, 9.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10977, 51, 53, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10977, 63, 43.9, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10978, 8, 40, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10978, 21, 10, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10978, 40, 18.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10978, 44, 19.45, 6, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10979, 7, 30, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10979, 12, 38, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10979, 24, 4.5, 80, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10979, 27, 43.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10979, 31, 12.5, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10979, 63, 43.9, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10980, 75, 7.75, 40, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10981, 38, 263.5, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10982, 7, 30, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10982, 43, 46, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10983, 13, 6, 84, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10983, 57, 19.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10984, 16, 17.45, 55, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10984, 24, 4.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10984, 36, 19, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10985, 16, 17.45, 36, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10985, 18, 62.5, 8, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10985, 32, 32, 35, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10986, 11, 21, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10986, 20, 81, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10986, 76, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10986, 77, 13, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10987, 7, 30, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10987, 43, 46, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10987, 72, 34.8, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10988, 7, 30, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10988, 62, 49.3, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10989, 6, 25, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10989, 11, 21, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10989, 41, 9.65, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10990, 21, 10, 65, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10990, 34, 14, 60, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10990, 55, 24, 65, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10990, 61, 28.5, 66, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10991, 2, 19, 50, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10991, 70, 15, 20, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10991, 76, 18, 90, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10992, 72, 34.8, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10993, 29, 123.79, 50, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10993, 41, 9.65, 35, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10994, 59, 55, 18, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10995, 51, 53, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10995, 60, 34, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10996, 42, 14, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10997, 32, 32, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10997, 46, 12, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10997, 52, 7, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10998, 24, 4.5, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10998, 61, 28.5, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10998, 74, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10998, 75, 7.75, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10999, 41, 9.65, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10999, 51, 53, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10999, 77, 13, 21, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11000, 4, 22, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11000, 24, 4.5, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11000, 77, 13, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11001, 7, 30, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11001, 22, 21, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11001, 46, 12, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11001, 55, 24, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11002, 13, 6, 56, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11002, 35, 18, 15, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11002, 42, 14, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11002, 55, 24, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11003, 1, 18, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11003, 40, 18.4, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11003, 52, 7, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11004, 26, 31.23, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11004, 76, 18, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11005, 1, 18, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11005, 59, 55, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11006, 1, 18, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11006, 29, 123.79, 2, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11007, 8, 40, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11007, 29, 123.79, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11007, 42, 14, 14, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11008, 28, 45.6, 70, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11008, 34, 14, 90, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11008, 71, 21.5, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11009, 24, 4.5, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11009, 36, 19, 18, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11009, 60, 34, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11010, 7, 30, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11010, 24, 4.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11011, 58, 13.25, 40, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11011, 71, 21.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11012, 19, 9.2, 50, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11012, 60, 34, 36, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11012, 71, 21.5, 60, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11013, 23, 9, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11013, 42, 14, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11013, 45, 9.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11013, 68, 12.5, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11014, 41, 9.65, 28, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11015, 30, 25.89, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11015, 77, 13, 18, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11016, 31, 12.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11016, 36, 19, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11017, 3, 10, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11017, 59, 55, 110, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11017, 70, 15, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11018, 12, 38, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11018, 18, 62.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11018, 56, 38, 5, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11019, 46, 12, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11019, 49, 20, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11020, 10, 31, 24, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11021, 2, 19, 11, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11021, 20, 81, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11021, 26, 31.23, 63, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11021, 51, 53, 44, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11021, 72, 34.8, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11022, 19, 9.2, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11022, 69, 36, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11023, 7, 30, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11023, 43, 46, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11024, 26, 31.23, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11024, 33, 2.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11024, 65, 21.05, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11024, 71, 21.5, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11025, 1, 18, 10, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11025, 13, 6, 20, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11026, 18, 62.5, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11026, 51, 53, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11027, 24, 4.5, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11027, 62, 49.3, 21, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11028, 55, 24, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11028, 59, 55, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11029, 56, 38, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11029, 63, 43.9, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11030, 2, 19, 100, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11030, 5, 21.35, 70, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11030, 29, 123.79, 60, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11030, 59, 55, 100, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11031, 1, 18, 45, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11031, 13, 6, 80, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11031, 24, 4.5, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11031, 64, 33.25, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11031, 71, 21.5, 16, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11032, 36, 19, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11032, 38, 263.5, 25, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11032, 59, 55, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11033, 53, 32.8, 70, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11033, 69, 36, 36, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11034, 21, 10, 15, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11034, 44, 19.45, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11034, 61, 28.5, 6, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11035, 1, 18, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11035, 35, 18, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11035, 42, 14, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11035, 54, 7.45, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11036, 13, 6, 7, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11036, 59, 55, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11037, 70, 15, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11038, 40, 18.4, 5, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11038, 52, 7, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11038, 71, 21.5, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11039, 28, 45.6, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11039, 35, 18, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11039, 49, 20, 60, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11039, 57, 19.5, 28, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11040, 21, 10, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11041, 2, 19, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11041, 63, 43.9, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11042, 44, 19.45, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11042, 61, 28.5, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11043, 11, 21, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11044, 62, 49.3, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11045, 33, 2.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11045, 51, 53, 24, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11046, 12, 38, 20, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11046, 32, 32, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11046, 35, 18, 18, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11047, 1, 18, 25, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11047, 5, 21.35, 30, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11048, 68, 12.5, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11049, 2, 19, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11049, 12, 38, 4, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11050, 76, 18, 50, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11051, 24, 4.5, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11052, 43, 46, 30, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11052, 61, 28.5, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11053, 18, 62.5, 35, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11053, 32, 32, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11053, 64, 33.25, 25, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11054, 33, 2.5, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11054, 67, 14, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11055, 24, 4.5, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11055, 25, 14, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11055, 51, 53, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11055, 57, 19.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11056, 7, 30, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11056, 55, 24, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11056, 60, 34, 50, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11057, 70, 15, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11058, 21, 10, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11058, 60, 34, 21, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11058, 61, 28.5, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11059, 13, 6, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11059, 17, 39, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11059, 60, 34, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11060, 60, 34, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11060, 77, 13, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11061, 60, 34, 15, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11062, 53, 32.8, 10, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11062, 70, 15, 12, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11063, 34, 14, 30, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11063, 40, 18.4, 40, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11063, 41, 9.65, 30, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11064, 17, 39, 77, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11064, 41, 9.65, 12, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11064, 53, 32.8, 25, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11064, 55, 24, 4, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11064, 68, 12.5, 55, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11065, 30, 25.89, 4, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11065, 54, 7.45, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11066, 16, 17.45, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11066, 19, 9.2, 42, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11066, 34, 14, 35, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11067, 41, 9.65, 9, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11068, 28, 45.6, 8, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11068, 43, 46, 36, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11068, 77, 13, 28, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11069, 39, 18, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11070, 1, 18, 40, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11070, 2, 19, 20, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11070, 16, 17.45, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11070, 31, 12.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11071, 7, 30, 15, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11071, 13, 6, 10, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11072, 2, 19, 8, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11072, 41, 9.65, 40, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11072, 50, 16.25, 22, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11072, 64, 33.25, 130, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11073, 11, 21, 10, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11073, 24, 4.5, 20, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11074, 16, 17.45, 14, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11075, 2, 19, 10, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11075, 46, 12, 30, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11075, 76, 18, 2, 0.15)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11076, 6, 25, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11076, 14, 23.25, 20, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11076, 19, 9.2, 10, 0.25)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 2, 19, 24, 0.2)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 3, 10, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 4, 22, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 6, 25, 1, 0.02)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 7, 30, 1, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 8, 40, 2, 0.1)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 10, 31, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 12, 38, 2, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 13, 6, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 14, 23.25, 1, 0.03)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 16, 17.45, 2, 0.03)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 20, 81, 1, 0.04)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 23, 9, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 32, 32, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 39, 18, 2, 0.05)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 41, 9.65, 3, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 46, 12, 3, 0.02)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 52, 7, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 55, 24, 2, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 60, 34, 2, 0.06)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 64, 33.25, 2, 0.03)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 66, 17, 1, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 73, 15, 2, 0.01)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 75, 7.75, 4, 0)

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 77, 13, 2, 0)

