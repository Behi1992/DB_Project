-- Part A)
-- 1)
select  SUM(s.UnitPrice*s.Quantity) as [Sum of Sales], CONVERT(int,SUM(s.UnitPrice*ISNULL(p.ProfitRatio,0.1000)*s.Quantity)+SUM(s.UnitPrice*s.Quantity)) as [Sum of Sales with Profit]
from Sale_tb as s
left join SaleProfit_tb as p
on s.Product = p.Product



-- 2)
select COUNT(distinct Customer) as CountOfCustomers
from Sale_tb



-- 3)
select s.Product, SUM(s.UnitPrice*s.Quantity) as [Sum of Sales], CONVERT(int,SUM(s.UnitPrice*ISNULL(p.ProfitRatio,0.1000)*s.Quantity)+SUM(s.UnitPrice*s.Quantity)) as [Sum of Sales with Profit]
from Sale_tb as s
left join SaleProfit_tb as p
on s.Product = p.Product
group by  s.Product
order by s.Product



-- 4)
with new(Customer,OrderID,SumOfQuantity,SumOfSale) as
(
select customer, OrderID,  SUM(Quantity), SUM(unitprice*Quantity) as [Sum of Sales]
from Sale_tb
group by Customer, OrderID
having SUM(unitprice*Quantity) > 1500
)
select Customer, COUNT(OrderID) as CountOfOrders, SUM(SumOfQuantity) as SumOfQuantity, sum(SumOfSale) as SumOfSales from new group by Customer



-- 5)
select CONVERT(int,SUM(s.UnitPrice*ISNULL(p.ProfitRatio,0.1000)*s.Quantity)) as [Profit]
from Sale_tb as s
left join SaleProfit_tb as p
on s.Product = p.Product

select (SUM(s.UnitPrice*ISNULL(p.ProfitRatio,0.1000)*s.Quantity))/SUM(s.UnitPrice*s.Quantity) * 100 as [PercantageOfProfit]
from Sale_tb as s
left join SaleProfit_tb as p
on s.Product = p.Product



-- 6)
select [Date], COUNT(distinct Customer) as CountOfCustormers
from Sale_tb
group by [Date]



-- Part B)
SELECT e.id, e.firstname, e.managerid, m.firstname
FROM Employee_tb e
LEFT JOIN Employee_tb m ON e.managerid = m.id

WITH Employee AS (
  (SELECT id, firstname, managerid, 1 AS level
  FROM Employee_tb
  WHERE id <= 2)
  UNION ALL
  (SELECT this.id, this.firstname, this.managerid, prior.level + 1
  FROM Employee prior
  INNER JOIN Employee_tb this ON this.managerid = prior.id)
)
SELECT e.id, e.firstname, m.ManagerName, e.level
FROM Employee e
left join Manager_tb m
on e.ManagerID = m.ManagerID
ORDER BY e.level
