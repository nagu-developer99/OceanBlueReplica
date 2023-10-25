def generate_email_html(body_text, table_data):
    # Create the header for the table using the keys from the first dictionary
    table_header = "<tr>{}</tr>".format("".join([f"<th style='background-color: #4CAF50; color: white;'>{key}</th>" for key in table_data[0].keys()]))

    # Create the rows for the table
    table_rows = []
    for row_data in table_data:
        row = "<tr>{}</tr>".format("".join([f"<td>{row_data[key]}</td>" for key in row_data.keys()]))
        table_rows.append(row)

    # Combine everything into the final HTML
    html_template = """
    <html>
    <body>
        <p>{}</p>
        <table border="1">
            {}
            {}
        </table>
    </body>
    </html>
    """.format(body_text, table_header, "\n".join(table_rows))

    return html_template

# Example usage:
body_text = "This is the first part of the email body."
table_data = [
    {"Name": "John", "Age": 25, "Location": "New York"},
    {"Name": "Jane", "Age": 30, "Location": "Los Angeles"},
    {"Name": "Doe", "Age": 28, "Location": "Chicago"}
]

email_html = generate_email_html(body_text, table_data)
print(email_html)
