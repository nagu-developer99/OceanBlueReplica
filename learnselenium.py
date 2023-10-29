from selenium import webdriver
from selenium.webdriver.common.by import By

def click_button_by_name(driver, button_name):
    """
    Click a button based on its text content using Selenium and XPath.

    Parameters:
    - driver: A Selenium WebDriver instance.
    - button_name: The text content of the button to click.
    """
    try:
        # Locate the button using XPath and text content
        button = driver.find_element(By.XPATH, f"//button[text()='{button_name}']")
        button.click()
    except Exception as e:
        print(f"Error: {e}")
        print(f"Button with name '{button_name}' not found.")

# Example usage:
driver = webdriver.Chrome()  # or any other driver you prefer
driver.get('https://your-website-url.com')  # replace with the actual URL of the page
click_button_by_name(driver, 'Reject Trade')

###################################

from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By

def navigate_and_click(driver, menu_items):
    """
    Navigate through a series of menu items using mouse hover and click the last item.

    Parameters:
    - driver: A Selenium WebDriver instance.
    - menu_items: A list of menu item names to navigate through.
    """
    action = ActionChains(driver)

    # Iterate through all menu items except the last one
    for item in menu_items[:-1]:
        element = driver.find_element(By.XPATH, f"//span[text()='{item}']")
        action.move_to_element(element).perform()

    # Click the last menu item
    last_item = menu_items[-1]
    final_element = driver.find_element(By.XPATH, f"//span[text()='{last_item}']")
    final_element.click()

# Example usage:
driver = webdriver.Chrome()  # or any other driver you prefer
driver.get('https://your-website-url.com')  # replace with the actual URL of the page

menu_path = ['Create Allocation', 'Custom Templates', 'Equity - Manual Settlement']
navigate_and_click(driver, menu_path)

#####################################################

from selenium import webdriver
from selenium.webdriver.common.by import By

def fill_charges_fields(driver, data):
    """
    Fill the Charges/Taxes/Fees fields.

    Parameters:
    - driver: The Selenium WebDriver instance.
    - data: A list of dictionaries containing 'amount' and 'type' for each field.
            Example: [{'amount': '100', 'type': 'Tax'}, {'amount': '200', 'type': 'Fee'}, ...]
    """
    for i, entry in enumerate(data):
        # Locate the Amount input field and enter the data
        amount_input = driver.find_element(By.ID, f"charges-taxes-fees-{i}_amount")
        amount_input.send_keys(entry['amount'])

        # Locate the Type input (combobox) and enter the data
        type_input = driver.find_element(By.NAME, f"charges-taxes-fees-{i}_type_input")
        type_input.send_keys(entry['type'])

# Example usage:
driver = webdriver.Chrome()  # or any other driver you're using
driver.get("YOUR_URL_HERE")  # replace with your URL

data_to_fill = [
    {'amount': '100', 'type': 'Tax'},
    {'amount': '200', 'type': 'Fee'},
    # ... add more data as needed
]

fill_charges_fields(driver, data_to_fill)


###################################################################


from selenium import webdriver
from selenium.webdriver.common.by import By

def fill_commissions_fields(driver, data_list):
    """
    Fill the commissions fields using Selenium.

    Parameters:
    - driver: The Selenium webdriver instance.
    - data_list: A list of dictionaries, each containing the values for the fields of one row. Example:
        [
            {
                "amount": "100",
                "basis": "Some Basis",
                "type": "Some Type",
                "reason": "Some Reason"
            },
            ...
        ]
    """

    for idx, data in enumerate(data_list):
        # Fill the amount
        amount_field = driver.find_element(By.ID, f"commissions-{idx}_amount")
        amount_field.clear()
        amount_field.send_keys(data["amount"])

        # Fill the basis
        basis_combobox_input = driver.find_element(By.XPATH, f"//input[@name='commissions-{idx}_basis_input']")
        basis_combobox_input.clear()
        basis_combobox_input.send_keys(data["basis"])

        # Fill the type
        type_combobox_input = driver.find_element(By.XPATH, f"//input[@name='commissions-{idx}_type_input']")
        type_combobox_input.clear()
        type_combobox_input.send_keys(data["type"])

        # Fill the reason
        reason_combobox_input = driver.find_element(By.XPATH, f"//input[@name='commissions-{idx}_reason_input']")
        reason_combobox_input.clear()
        reason_combobox_input.send_keys(data["reason"])

# Example usage:
driver = webdriver.Chrome()
driver.get("YOUR_URL_HERE")

data_list = [
    {
        "amount": "100",
        "basis": "Basis 1",
        "type": "Type 1",
        "reason": "Reason 1"
    },
    {
        "amount": "200",
        "basis
######################################################
