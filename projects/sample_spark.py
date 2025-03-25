"""
Spark Practice Sample Code

This script demonstrates how to connect to Spark and use basic PySpark operations.
"""

from pyspark.sql import SparkSession
from pyspark.sql.functions import avg, max, min, count

# 1. Create a SparkSession
spark = SparkSession.builder \
    .appName("SparkPractice") \
    .master("spark://spark-master:7077") \
    .config("spark.executor.memory", "512m") \
    .getOrCreate()

print(f"Spark version: {spark.version}")

# 2. Create a Simple DataFrame
data = [(1, "John", 25), (2, "Alice", 30), (3, "Bob", 22), (4, "Emma", 28)]
columns = ["id", "name", "age"]
df = spark.createDataFrame(data, columns)

# Show the DataFrame
print("Sample DataFrame:")
df.show()

# 3. Basic DataFrame Operations
print("DataFrame Schema:")
df.printSchema()

print("Selected columns (name, age):")
df.select("name", "age").show()

print("Filtered data (age > 25):")
df.filter(df.age > 25).show()

print("Aggregated statistics:")
df.groupBy().agg(
    avg("age").alias("avg_age"), 
    max("age").alias("max_age"), 
    min("age").alias("min_age"), 
    count("*").alias("count")
).show()

# 4. Working with HDFS (Using PySpark directly)
# Save DataFrame to CSV format
print("Saving DataFrame to HDFS...")
df.write.mode("overwrite").csv("hdfs://hdfs-namenode:9000/user/practice/data/people")

# Read data from HDFS
print("Reading data from HDFS:")
hdfs_df = spark.read.csv("hdfs://hdfs-namenode:9000/user/practice/data/people")
hdfs_df.show()

# 5. Clean Up
print("Stopping SparkSession...")
spark.stop()
print("Done!") 