create external schema spectrum 
from data catalog 
database 'spectrumdb' 
iam_role 'arn:aws:iam::187493414600:role/myRedshiftRole'
create external database if not exists;

create external table spectrum.sales(
    salesid integer,
    listid integer,
    sellerid integer,
    buyerid integer,
    eventid integer,
    dateid smallint,
    qtysold smallint,
    pricepaid decimal(8,2),
    commission decimal(8,2),
    saletime timestamp)
row format delimited
fields terminated by '\t'
stored as textfile
location 's3://awssampledbuswest2/tickit/spectrum/sales/'
table properties ('numRows'='172000');

-- Get the number of rows in the Spectrum sales table
select count(*) from spectrum.sales;

-- Join data from a local table and a Spectrum table to find total sales for top 10 events
select top 10 spectrum.sales.eventid, sum(spectrum.sales.pricepaid) from spectrum.sales, s3_copy.event
where spectrum.sales.eventid = event.eventid
and spectrum.sales.pricepaid > 30
group by spectrum.sales.eventid
order by 2 desc;
