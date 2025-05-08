# Databricks notebook source

# COMMAND ----------

# DBTITLE 1,write delta table 0
json_path_0 = "/tmp/json_0.json"

json_contents_0 = """
[{'id':'A','artist':{'song':{'id':'A','name':'name 1','country':'country 1'}}}]
[{'id':'B','artist':{'song':{'id':'B','name':'name 2','country':'country 2'}}}]
[{'id':'C','artist':{'song':{'id':'C','name':'name 3','country':'country 3'}}}]
"""

dbutils.fs.put(json_path_0, json_contents_0, overwrite = True)

df_0 = spark.read.json(json_path_0)

delta_path_0 = "/tmp/delta_0"

df_0.write.format("delta").mode("overwrite").option('overWriteSchema', True).save(delta_path_0)

# COMMAND ----------

# DBTITLE 1,write delta table 1
json_path_1 = "/tmp/json_1.json"

json_contents_1 = """
[{'id':'B','artist':{'song':{'id':null,'name':null,'country':null}}}]
[{'id':'D','artist':{'song':{'id':'D','name':'name 4','country':'country 4'}}}]
"""

dbutils.fs.put(json_path_1, json_contents_1, overwrite = True)

df_1 = spark.read.json(json_path_1)

delta_path_1 = "/tmp/delta_1"

df_1.write.format("delta").mode("overwrite").option('overWriteSchema', True).save(delta_path_1)

# COMMAND ----------

# DBTITLE 1,upsert
from delta.tables import *
from pyspark.sql.functions import *

# delta.tables.DeltaTable
dt_0 = DeltaTable.forPath(spark, delta_path_0)

# pyspark.sql.dataframe.DataFrame
df_1 = spark.read.format("delta").load(delta_path_1)

# upsert
dt_0.alias("old_data") \
  .merge(df_1.alias("new_data"), "old_data.id = new_data.id") \
  .whenMatchedUpdate(set = { "artist": when(col("new_data.artist.song.id").isNull(), lit(None)).otherwise(col("new_data.artist")) }) \
  .whenNotMatchedInsert(values = { "id": col("new_data.id"), "artist": col("new_data.artist") }) \
  .execute()

dt_0.toDF().display()