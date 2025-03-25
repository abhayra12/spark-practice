# PySpark Examples

This directory contains example scripts demonstrating best practices for working with PySpark 3.3.1.

## Files

- `spark_compatibility_example.py` - Demonstrates how to avoid common serialization issues with PySpark 3.3.1 and Python 3.9

## Running the Examples

From the JupyterLab terminal:

```bash
cd /opt/workspace/projects/examples
python3 spark_compatibility_example.py
```

## Best Practices

1. **Use Python 3.9 or 3.10** with PySpark 3.3.1 for best compatibility
2. Create DataFrames using the simpler API approach with direct data and column names
3. Avoid complex lambda functions in UDFs
4. Register UDFs with proper return types
5. Use DataFrame operations instead of RDD operations when possible
6. Keep serialization limitations in mind when working with functions
7. Use proper error handling for PySpark operations 