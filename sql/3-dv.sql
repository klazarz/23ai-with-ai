create or replace json relational duality view customers_dv as new_customers@insert@update@delete{_id : id firstname : first_name
lastname : last_name dateofbirth : dob email : email address : address zip : zip orders : new_orders@insert@update@delete[{orderid : id
productid : product_id orderdate : order_date totalvalue : total_value ordershipped : order_shipped}]};



alter system set "_fix_control" = '20648883:OFF';



update customers_dv c
   set
   c.data = json_transform(data,
               append '$.orders' =
      json{
         'ProductID' : 25,
           'OrderDate' : systimestamp,
           'TotalValue' : 206
      }
   )
 where c.data."_id" = 100001;



select *
  from customers_dv c
 where c.data."_id" = 100001;


insert into new_orders (
   customer_id,
   product_id,
   order_date,
   total_value
) values ( 100001,
           3232,
           systimestamp,
           23 );