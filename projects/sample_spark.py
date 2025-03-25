"""
Simple Spark Test Script
"""

from pyspark.sql import SparkSession

# Create a SparkSession
spark = SparkSession.builder \
    .appName("SimpleTest") \
    .master("local[*]") \
    .getOrCreate()

print(f"Spark version: {spark.version}")
print(f"Python version: {spark.sparkContext.pythonVer}")

# Create a simple DataFrame
data = [(1, "John"), (2, "Alice")]
columns = ["id", "name"]
df = spark.createDataFrame(data, columns)

# Show the DataFrame
print("Simple DataFrame:")
df.show()

# Stop the SparkSession
spark.stop()
print("Done!") 