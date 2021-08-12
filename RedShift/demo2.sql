create schema if not exists s3_copy;

drop table s3_copy.users;

create table s3_copy.users(
    userid integer not null distkey sortkey,
    username char(8),
    firstname varchar(30),
    lastname varchar(30),
    city varchar(30),
    state char(2),
    email varchar(100),
    phone char(14),
    likesports boolean,
    liketheatre boolean,
    likeconcerts boolean,
    likejazz boolean,
    likeclassical boolean,
    likeopera boolean,
    likerock boolean,
    likevegas boolean,
    likebroadway boolean,
    likemusicals boolean);

create table s3_copy.venue(
    venueid smallint not null distkey sortkey,
    venuename varchar(100),
    venuecity varchar(30),
    venuestate char(2),
    venueseats integer);

create table s3_copy.category(
    catid smallint not null distkey sortkey,
    catgroup varchar(10),
    catname varchar(10),
    catdesc varchar(50));

create table s3_copy.date(
    dateid smallint not null distkey sortkey,
    caldate date not null,
    day character(3) not null,
    week smallint not null,
    month character(5) not null,
    qtr character(5) not null,
    year smallint not null,
    holiday boolean default('N'));

create table s3_copy.event(
    eventid integer not null distkey,
    venueid smallint not null,
    catid smallint not null,
    dateid smallint not null sortkey,
    eventname varchar(200),
    starttime timestamp);

create table s3_copy.listing(
    listid integer not null distkey,
    sellerid integer not null,
    eventid integer not null,
    dateid smallint not null  sortkey,
    numtickets smallint not null,
    priceperticket decimal(8,2),
    totalprice decimal(8,2),
    listtime timestamp);

create table s3_copy.sales(
    salesid integer not null,
    listid integer not null distkey,
    sellerid integer not null,
    buyerid integer not null,
    eventid integer not null,
    dateid smallint not null sortkey,
    qtysold smallint not null,
    pricepaid decimal(8,2),
    commission decimal(8,2),
    saletime timestamp);

copy s3_copy.users from 's3://rettestbucket/tickit/allusers_pipe.txt' 
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole' 
delimiter '|' region 'us-east-1';
                            
copy s3_copy.venue from 's3://awssampledbuseast1/tickit/venue_pipe.txt' 
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole' 
delimiter '|' region 'us-east-1';

copy s3_copy.category from 's3://awssampledbuswest2/tickit/category_pipe.txt' 
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy s3_copy.date from 's3://awssampledbuswest2/tickit/date2008_pipe.txt' 
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy s3_copy.event from 's3://awssampledbuswest2/tickit/allevents_pipe.txt' 
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole' 
delimiter '|' timeformat 'YYYY-MM-DD HH:MI:SS' region 'us-west-2';

copy s3_copy.listing from 's3://awssampledbuswest2/tickit/listings_pipe.txt' 
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy s3_copy.sales from 's3://awssampledbuswest2/tickit/sales_tab.txt'
credentials 'aws_iam_role=arn:aws:iam::187493414600:role/myRedshiftRole'
delimiter '\t' timeformat 'MM/DD/YYYY HH:MI:SS' region 'us-west-2';

select * from s3_copy.users limit 10;

-- Find total sales on a given calendar date.
SELECT sum(qtysold) 
FROM   s3_copy.sales, s3_copy.date 
WHERE  sales.dateid = date.dateid 
AND    caldate = '2008-01-05';

-- Find top 10 buyers by quantity.
SELECT firstname, lastname, total_quantity 
FROM   (SELECT buyerid, sum(qtysold) total_quantity
        FROM  s3_copy.sales
        GROUP BY buyerid
        ORDER BY total_quantity desc limit 10) Q, s3_copy.users
WHERE Q.buyerid = userid
ORDER BY Q.total_quantity desc;

-- Find events in the 99.9 percentile in terms of all time gross sales.
SELECT eventname, total_price 
FROM  (SELECT eventid, total_price, ntile(1000) over(order by total_price desc) as percentile 
       FROM (SELECT eventid, sum(pricepaid) total_price
             FROM   s3_copy.sales
             GROUP BY eventid)) Q, s3_copy.event E
       WHERE Q.eventid = E.eventid
       AND percentile = 1
ORDER BY total_price desc;
