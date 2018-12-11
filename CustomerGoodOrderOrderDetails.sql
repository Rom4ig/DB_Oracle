set serveroutput on;
create table Customer
(
  id int,
  customer_name nvarchar2(20),
  primary key (id)
);

create table Good
(
  id int,
  good_name nvarchar2(50),
  good_type nvarchar2(20),
  good_coast number(8,2),
  primary key (id)
);

create table "Order"
(
  id int,
  order_date date,
  customer_id int,
  primary key (id),
  foreign key (customer_id) references Customer (id)
);

create table OrderDetail
(
  id int,
  order_id int,
  good_id int,
  quantity int,
  primary key (id),
  foreign key (order_id) references "Order" (id),
  foreign key (good_id) references Good (id)
);

drop table OrderDetail;
drop table "Order";
drop table Good;
drop table Customer;

insert into Customer values (1, 'Áîãäàí');
insert into Customer values (2, 'Èâàí');
insert into Customer values (3, 'Ïàõàí');
insert into Customer values (4, 'Áèğàí');

insert into Good values (1, 'Êîëáàñà "Íåæíàÿ"', 'Åäà', 8.37);
insert into Good values (2, '×èïñû "Ñî âêóñîì ïîáåäû"', 'Åäà', 3.19);
insert into Good values (3, 'Ìûëî', 'ÕîçÒîâàğû', 2.46);
insert into Good values (4, 'Âåğåâêà', 'ÕîçÒîâàğû', 3.71);

insert into "Order" values (1, '01-11-2018', 1);
insert into "Order" values (2, '02-11-2018', 2);
insert into "Order" values (3, '03-11-2018', 3);
insert into "Order" values (4, '04-11-2018', 4);
insert into "Order" values (5, '05-11-2018', 1);

insert into OrderDetail values (1, 1, 1, 2);
insert into OrderDetail values (2, 1, 3, 1);
insert into OrderDetail values (3, 2, 2, 3);
insert into OrderDetail values (4, 2, 4, 1);
insert into OrderDetail values (5, 3, 2, 1);
insert into OrderDetail values (6, 4, 2, 1);
insert into OrderDetail values (7, 5, 2, 1);

select * from OrderDetail;
select * from "Order";
select * from Customer;
select * from Good;


create or replace package cw
is
  procedure get_order_list(cname Customer.customer_name%type);
  function get_order_count(cname Customer.customer_name%type, sdate date, edate date) return number;
end cw;


create or replace package body cw
is 
  procedure get_order_list(cname Customer.customer_name%type)
  is
  o_date "Order".order_date%type;
  c_name Customer.customer_name%type;
  g_name Good.good_name%type;
  g_coast Good.good_coast%type;
  od_quantity OrderDetail.quantity%type;
  
  o_sum number(8,2) := 0;
  o_avg number(8,2);
  
  cursor curs_sum is
  select "Order".order_date, Customer.customer_name, Good.good_name, Good.good_coast, OrderDetail.quantity
  from OrderDetail inner join "Order" on OrderDetail.order_id = "Order".id
                   inner join Good on OrderDetail.good_id = Good.id
                   inner join Customer on "Order".customer_id = Customer.id
  where Customer.customer_name = cname;

  begin
  open curs_sum;
  loop
    fetch curs_sum into o_date, c_name, g_name, g_coast, od_quantity;
    exit when curs_sum%notfound;
    o_sum := o_sum + g_coast * od_quantity;
    dbms_output.put_line(o_date || ' ' || c_name || ' ' || g_name || ' ' || g_coast || ' ' || od_quantity);
  end loop;
  o_avg := o_sum / curs_sum%rowcount;
  dbms_output.put_line('average coast = ' || o_avg);
  close curs_sum;
  exception
    when others then dbms_output.put_line(sqlerrm);
  end get_order_list;
  
  
  function get_order_count(cname Customer.customer_name%type, sdate date, edate date)
  return number
  is 
    rc number(5);
  begin
    select count(*) into rc from "Order" inner join Customer 
    on "Order".customer_id = Customer.id 
    where Customer.customer_name = cname and 
          "Order".order_date >= sdate and 
          "Order".order_date <= edate;
    return rc;
  end get_order_count;
end cw;

begin
  cw.get_order_list('Áîãäàí');
  dbms_output.put_line(cw.get_order_count('Áîãäàí', '01-11-2018', '05-11-2018'));
end;



































