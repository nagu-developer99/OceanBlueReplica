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


#####################################################

# Sample data
test_data = {
    "Test1": [
        {"Description": "Validating xyz", "Status": "Pass", "Component": "GBOI", "BaseLinePath": r"//v/baseline/text.txt", "ActualPath": r"//v/actual/text.txt"}
    ]
}

# Generate the dynamic part (table rows)
# Generate the dynamic part (table rows)
table_rows = ""
for test_name, validations in test_data.items():
    for i, validation in enumerate(validations):
        if i == 0:
            table_rows += f'<tr><td rowspan="{len(validations)}">{test_name}</td>'
        else:
            table_rows += "<tr>"

        table_rows += f'<td>{validation["Description"]}</td>'
        table_rows += f'<td>{validation["Status"]}</td>'
        table_rows += f'<td>{validation["Component"]}</td>'
        table_rows += f'<td><a href="{validation["BaseLinePath"]}" target="_blank">Click here</a></td>'
        table_rows += f'<td><a href="{validation["ActualPath"]}" target="_blank">Click here</a></td></tr>'


# Combine the dynamic and static parts
html_template = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Validations</title>
    <style>
        th {{
            background-color: blue;
            color: white;
        }}
    </style>
</head>
<body>
    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Status</th>
                <th>Component</th>
                <th>BaseLinePath</th>
                <th>ActualPath</th>
            </tr>
        </thead>
        <tbody>
            {table_rows}
        </tbody>
    </table>
</body>
</html>
"""


html_content = html_template.format(table_rows=table_rows)

# Save to a file
with open("test_report.html", "w") as file:
    file.write(html_content)

# Optionally, you can open the HTML in a browser using Python
import webbrowser
webbrowser.open("test_report.html")

