# Databricks notebook source
with data0 as (
  select
    col1 as id,
    col2 as account
  from values 
    (1532214, "109388,109388-Michigan"), 
    (646729, "109064-Michigan,109064,134089-Michigan"), 
    (434239, "652164-Michigan,654158-Michigan,156848-Michigan,6541635-Michigan,654615- Michigan,5451651-Michigan")
),
data1 as (
  select distinct 
    id,
    explode(regexp_extract_all(account, "(\\d+)", 1)) as account
  from data0
)
select
  id,
  cast(account as integer) as account
from data1