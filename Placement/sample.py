import mysql.connector
from mysql.connector import Error

try:
    # Establish a connection to the database
    connection = mysql.connector.connect(
        host='localhost',
        database='placement',
        user='root',
        password='root'
    )
    
    if connection.is_connected():
        print("Connected to MySQL database")

        # Create a cursor object
        cursor = connection.cursor()

        # Define the query
        query = "SELECT * FROM login where rollno= %s"

        # Execute the query
        cursor.execute(query,(106121030,))

        # Fetch all the rows from the executed query
        records = cursor.fetchall()

        # Print the records
        print("Total number of rows in table: ", cursor.rowcount)
        print("\nPrinting each row")
        for row in records:
            print(row)

except Error as e:
    print("Error while connecting to MySQL", e)

finally:
    # Close the cursor and connection
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
