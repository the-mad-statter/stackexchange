# Databricks notebook source
# MAGIC %pip install loguru

# COMMAND ----------

# MAGIC %restart_python

# COMMAND ----------

from datetime import datetime
from loguru import logger
import shutil

CATALOG = "my_catalog"
SCHEMA = "my_schema"
VOLUME = "my_volume"

FILE_HANDLER_NAME = f"{datetime.now().strftime('%Y-%m-%d__%H_%M_%S')}.log"

# local path with read/write permissions
FILE_HANDLER_PATH_0 = f"/tmp/my_logs/{FILE_HANDLER_NAME}"
# shutil.copy() will not create the directory
FILE_HANDLER_PATH_1 = f"/Volumes/{CATALOG}/{SCHEMA}/{VOLUME}/my_logs/{FILE_HANDLER_NAME}"

logger.add(FILE_HANDLER_PATH_0)
logger.info('An info message')
logger.warning('A warning message')
logger.error('An error message')

# copy local log file to volumes
shutil.copy(FILE_HANDLER_PATH_0, FILE_HANDLER_PATH_1)