import smtplib
import ssl
import pandas as pd
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Replace with your Outlook email credentials and SMTP server details
sender_email = "your_email@outlook.com"
receiver_email = "recipient_email@outlook.com"
password = "your_password"
smtp_server = "smtp.office365.com"
port = 587

# Function to create an HTML table from a list of dictionaries
def create_html_table(data, column_names, color_mapping):
    """
    Creates an HTML table from a list of dictionaries, coloring cells based on a mapping.

    Args:
        data: A list of dictionaries, where each dictionary represents a row.
        column_names: A list of column names.
        color_mapping: A dictionary mapping column names to functions that determine cell colors.

    Returns:
        The HTML code for the table.
    """

    html = "<table><thead><tr>"
    for column in column_names:
        html += f"<th>{column}</th>"
    html += "</tr></thead><tbody>"

    for row in data:
        html += "<tr>"
        for column in column_names:
            cell_value = row[column]
            color = color_mapping.get(column, lambda value: None)(cell_value)
            style = f"background-color: {color};" if color else ""
            html += f"<td style='{style}'>{cell_value}</td>"
        html += "</tr>"

    html += "</tbody></table>"
    return html

# Sample data
data = [
    {"job_name": "Job 1", "status": "Running", "start_time": "2023-10-01 10:00:00"},
    {"job_name": "Job 2", "status": "Failed", "start_time": "2023-10-02 12:00:00"},
    {"job_name": "Job 3", "status": "Completed", "start_time": "2023-10-03 14:00:00"},
]

# Column names
column_names = ["job_name", "status", "start_time"]

# Color mapping functions
def color_status(status):
    if status == "Running":
        return "green"
    elif status == "Failed":
        return "red"
    else:
        return "orange"

color_mapping = {"status": color_status}

# Create the HTML table
html_table = create_html_table(data, column_names, color_mapping)

# Create the email message
message = MIMEMultipart()
message["From"] = sender_email
message["To"] = receiver_email
message["Subject"] = "Job Status Report"

# Attach the HTML content to the message
body = MIMEText(html_table, "html")
message.attach(body)

# Send the email
context = ssl.create_default_context()
with smtplib.SMTP(smtp_server, port) as server:
    server.starttls(context=context)
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())

print("Email sent successfully!")


############################################################

import smtplib
import ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# ... (your existing email credentials and SMTP server details)

def create_html_table(data, column_names, color_mapping):
    # ... (your existing table creation function)

def send_email(subject, tables):
    """
    Sends an email with multiple HTML tables in the body.

    Args:
        subject: The subject of the email.
        tables: A list of tuples, where each tuple contains the table title and HTML content.
    """

    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject

    body = MIMEText("", "html")
    for title, html in tables:
        body.add_header("Content-type", "text/html")
        body.add_header("Content-Disposition", "inline")
        body.set_payload(f"<h2>{title}</h2>{html}")

    message.attach(body)

    # ... (your existing SMTP connection and sending logic)

# Sample data and tables
data1 = ...  # First table data
data2 = ...  # Second table data

tables = [
    ("Job Status", create_html_table(data1, column_names1, color_mapping1)),
    ("Other Data", create_html_table(data2, column_names2, color_mapping2)),
]

subject = "Job Status Report"

send_email(subject, tables)

#####################################################################################

#OPENAI
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Sample data: list of dictionaries
data = [
    {'Job': 'Job 1', 'Status': 'Pass', 'Records': 100},
    {'Job': 'Job 2', 'Status': 'Fail', 'Records': 50},
    {'Job': 'Job 3', 'Status': 'Pending', 'Records': 0},
]

# Create the HTML table with colored cells based on job status
def create_html_table(data):
    html = """
    <html>
    <body>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Job</th>
            <th>Status</th>
            <th>Records</th>
        </tr>
    """
    
    for row in data:
        status_color = 'green' if row['Status'] == 'Pass' else 'red' if row['Status'] == 'Fail' else 'orange'
        html += f"""
        <tr>
            <td>{row['Job']}</td>
            <td style="background-color:{status_color}">{row['Status']}</td>
            <td>{row['Records']}</td>
        </tr>
        """
    
    html += """
    </table>
    </body>
    </html>
    """
    return html

# Function to send email using smtplib
def send_email(html_content, to_email, subject):
    # Set up your email server and login details
    smtp_server = 'smtp.office365.com'
    smtp_port = 587
    from_email = 'your-email@outlook.com'
    password = 'your-password'

    # Create email message
    msg = MIMEMultipart('alternative')
    msg['From'] = from_email
    msg['To'] = to_email
    msg['Subject'] = subject

    # Attach the HTML content
    html_part = MIMEText(html_content, 'html')
    msg.attach(html_part)

    # Send the email
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()  # Secure the connection
        server.login(from_email, password)
        server.sendmail(from_email, to_email, msg.as_string())

# Main script to generate the report and send email
if __name__ == '__main__':
    html_table = create_html_table(data)
    send_email(html_table, 'recipient-email@example.com', 'Job Status Report')

#############################
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Sample data for multiple tables
job_data = [
    {'Job': 'Job 1', 'Status': 'Pass', 'Records': 100},
    {'Job': 'Job 2', 'Status': 'Fail', 'Records': 50},
    {'Job': 'Job 3', 'Status': 'Pending', 'Records': 0},
]

summary_data = [
    {'Metric': 'Total Jobs', 'Value': 3},
    {'Metric': 'Successful Jobs', 'Value': 1},
    {'Metric': 'Failed Jobs', 'Value': 1},
    {'Metric': 'Pending Jobs', 'Value': 1},
]

# Function to create an HTML table from data
def create_html_table(data, headers):
    html = """
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
    """
    for header in headers:
        html += f"<th>{header}</th>"
    html += "</tr>"
    
    for row in data:
        html += "<tr>"
        for header in headers:
            cell_value = row[header]
            if header == 'Status':  # Color cells based on status
                color = 'green' if cell_value == 'Pass' else 'red' if cell_value == 'Fail' else 'orange'
                html += f'<td style="background-color:{color}">{cell_value}</td>'
            else:
                html += f'<td>{cell_value}</td>'
        html += "</tr>"
    
    html += "</table>"
    return html

# Function to generate the full HTML email body with multiple tables
def create_email_body():
    email_body = """
    <html>
    <body>
    <p>Hello Team,</p>
    <p>Here is the job status report for today:</p>
    
    <h3>Job Status Details:</h3>
    """
    email_body += create_html_table(job_data, ['Job', 'Status', 'Records'])

    email_body += """
    <h3>Summary:</h3>
    """
    email_body += create_html_table(summary_data, ['Metric', 'Value'])
    
    email_body += """
    <p>Best regards,<br>Your Automation System</p>
    </body>
    </html>
    """
    return email_body

# Function to send email using smtplib
def send_email(html_content, to_email, subject):
    # Set up your email server and login details
    smtp_server = 'smtp.office365.com'
    smtp_port = 587
    from_email = 'your-email@outlook.com'
    password = 'your-password'

    # Create email message
    msg = MIMEMultipart('alternative')
    msg['From'] = from_email
    msg['To'] = to_email
    msg['Subject'] = subject

    # Attach the HTML content
    html_part = MIMEText(html_content, 'html')
    msg.attach(html_part)

    # Send the email
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()  # Secure the connection
        server.login(from_email, password)
        server.sendmail(from_email, to_email, msg.as_string())

# Main script to generate the report and send email
if __name__ == '__main__':
    email_body = create_email_body()
    send_email(email_body, 'recipient-email@example.com', 'Daily Job Status Report')

####################################3
# Function to create an HTML table with adjustable column widths
def create_html_table(data, headers, widths=None):
    html = """
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
    """
    # Add headers with optional width
    for i, header in enumerate(headers):
        width_style = f'style="width:{widths[i]};"' if widths else ''
        html += f"<th {width_style}>{header}</th>"
    html += "</tr>"
    
    # Add rows
    for row in data:
        html += "<tr>"
        for i, header in enumerate(headers):
            cell_value = row[header]
            if header == 'Status':  # Color cells based on status
                color = 'green' if cell_value == 'Pass' else 'red' if cell_value == 'Fail' else 'orange'
                html += f'<td style="background-color:{color};">{cell_value}</td>'
            else:
                html += f'<td>{cell_value}</td>'
        html += "</tr>"
    
    html += "</table>"
    return html
#>>>>>>>>>>>>>>>>>>>>>>>>
# Example data
job_data = [
    {'Job': 'Job 1', 'Status': 'Pass', 'Records': 100},
    {'Job': 'Job 2', 'Status': 'Fail', 'Records': 50},
    {'Job': 'Job 3', 'Status': 'Pending', 'Records': 0},
]

# Specify column headers and widths (e.g., 200px for 'Job', 100px for 'Status', and 80px for 'Records')
column_headers = ['Job', 'Status', 'Records']
column_widths = ['200px', '100px', '80px']

# Generate the table with widths
html_table = create_html_table(job_data, column_headers, column_widths)

#########################
import os

def split_file(input_file, output_dir, chunk_size):
    """
    Splits the input_file into multiple smaller files of specified chunk_size.

    :param input_file: Path to the large file to split
    :param output_dir: Directory where the split files will be saved
    :param chunk_size: Size of each chunk in bytes (e.g., 50 * 1024 * 1024 for 50MB)
    """
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    file_size = os.path.getsize(input_file)
    file_name = os.path.basename(input_file)
    
    with open(input_file, 'rb') as f:
        chunk_count = 1
        while True:
            chunk_data = f.read(chunk_size)
            if not chunk_data:
                break
            output_file = os.path.join(output_dir, f'{file_name}.part{chunk_count:03d}')
            with open(output_file, 'wb') as chunk_file:
                chunk_file.write(chunk_data)
            print(f"Created: {output_file}")
            chunk_count += 1

if __name__ == "__main__":
    input_file = "C:/path/to/your/large_file.log"  # Path to your large file
    output_dir = "C:/path/to/output/directory"  # Directory to save the smaller files
    chunk_size = 50 * 1024 * 1024  # Set chunk size to 50MB (50 * 1024 * 1024 bytes)

    split_file(input_file, output_dir, chunk_size)
#####
index="windesktop_process" "fluent"
| eval date=strftime(_time, "%Y-%m-%d")
| stats count by host, date
| eval status=if(count > 0, "Present", "Not Present")
| append [| makeresults 
| eval date=mvrange(0, 30) 
| mvexpand date 
| eval date=strftime(relative_time(now(), "-" . date . "d"), "%Y-%m-%d") 
| eval host=mvappend("host1", "host2", "host3", "host4", "host5", "host6", "host7", "host8", "host9", "host10")
| mvexpand host]
| stats first(status) as status by host, date
| eval status=if(isnull(status), "Not Present", status)
| chart values(status) over date by host

####
function log_rotation(tag, timestamp, record)
    local log_file = "C:\\programfiles\\loki\\logs.txt"
    local max_size = 500 * 1024 * 1024 -- 500 MB in bytes

    -- Get file size
    local file = io.open(log_file, "r")
    if file then
        local current_size = file:seek("end")
        file:close()

        if current_size > max_size then
            -- Close the current file and remove it
            os.remove(log_file)

            -- Create a new log file
            file = io.open(log_file, "w")
            file:close()

            return 1, timestamp, record -- Returning 1 to apply changes
        end
    end

    return 0, timestamp, record -- No rotation needed
end

##
[INPUT]
    Name tail
    Path C:\programfiles\loki\logs.txt
    # Your other settings

[FILTER]
    Name lua
    Match *
    Script C:\path\to\log_rotation.lua
    Call log_rotation

[OUTPUT]
    Name loki
    # Your Loki settings

