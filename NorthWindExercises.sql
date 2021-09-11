--A
Select OrderID, sum(UnitPrice * Quantity) as [Order Subtotal]
From [Order Details]
Group By OrderID
Order By OrderID

--B
Select *
From Products
Where Discontinued = 0

--C
Select OrderID, CAST(sum((UnitPrice * Quantity * (100.0 - Discount) / 100.0)) AS Decimal(18,2))
	AS [Order Cost After Discount]
From [Order Details]
Group By OrderID
Order By OrderID

--D
Select c.CategoryName,	
	CAST(sum((od.UnitPrice * od.Quantity * (100.0 - od.Discount) / 100.0)) AS Decimal(18,2)) [Sales],
	Sum(od.Quantity) [Items Sold]
From Categories c
	JOIN Products p
	ON c.CategoryID = p.CategoryID
	JOIN [Order Details] od
	ON p.ProductID = od.ProductID
Group By c.CategoryName
Order By c.CategoryName

--E
Select Top 10 *
From Products
Order By UnitPrice DESC

--F
Select Top 1 DATEPART(Quarter, o.OrderDate) as [Quarter], 
	CAST(sum((od.UnitPrice * od.Quantity * (100.0 - od.Discount)) / 100.0) AS Decimal(18,2)) as [Quarterly Sales]
From [Order Details] od
	JOIN Orders o
	ON od.OrderID = o.OrderID
Where Year(OrderDate) = 1997
Group By DATEPART(Quarter, o.OrderDate)
Order By [Quarterly Sales] DESC

--G
Select *
From Products
Where UnitPrice > (Select AVG(UnitPrice)
	From Products)

