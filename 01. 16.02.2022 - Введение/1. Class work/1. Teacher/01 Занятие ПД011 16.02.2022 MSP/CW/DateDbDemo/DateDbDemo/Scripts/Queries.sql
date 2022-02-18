select
    *
from
    Sales;

-- группировка по месяцам, вывести сумму продаж за месяц
select
    Month(Sales.SaleDate) as SaleMonth
    , Sales.Cost * Sales.Amount as Total
    into #temp
from
    Sales;

select
    SaleMonth
    , Sum(Total) as SumTotal
from
    #temp
group by
    SaleMonth;
go