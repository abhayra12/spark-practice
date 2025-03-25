#!/usr/bin/env python3
"""
PySpark Compatibility Example
============================

This example demonstrates best practices for working with PySpark 3.3.1 
to avoid serialization issues.
"""

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit, udf
from pyspark.sql.types import StringType, IntegerType, StructType, StructField

def main():
    """Main function to demonstrate PySpark usage."""
    # Create a SparkSession with reasonable defaults
    spark = SparkSession.builder \
        .appName("CompatibilityExample") \
        .master("spark://spark-master:7077") \
        .config("spark.executor.memory", "512m") \
        .getOrCreate()
    
    print(f"Spark version: {spark.version}")
    print(f"Python version: {spark.sparkContext.pythonVer}")
    
    # 1. Create a DataFrame using the simpler API approach
    # This avoids serialization issues when creating DataFrames
    data = [("Alice", 34), ("Bob", 45), ("Charlie", 29)]
    df = spark.createDataFrame(data, ["name", "age"])
    
    print("Original DataFrame:")
    df.show()
    
    # 2. Define UDFs properly to avoid serialization issues
    # Keep lambda functions simple or use regular functions
    def add_title(name):
        return f"Dr. {name}"
    
    # Register UDF with proper return type
    add_title_udf = udf(add_title, StringType())
    
    # Apply the UDF to the DataFrame
    df_with_title = df.withColumn("name_with_title", add_title_udf(col("name")))
    
    print("DataFrame with title:")
    df_with_title.show()
    
    # 3. Use DataFrame operations instead of RDD operations when possible
    # DataFrame operations are optimized and less prone to serialization issues
    df_filtered = df.filter(col("age") > 30).orderBy("name")
    
    print("Filtered DataFrame:")
    df_filtered.show()
    
    # 4. Save data example
    # Comment out to avoid creating files during test runs
    # df.write.mode("overwrite").csv("/tmp/spark_example")
    
    # Stop the SparkSession when done
    spark.stop()
    print("Example completed successfully!")

if __name__ == "__main__":
    main() 