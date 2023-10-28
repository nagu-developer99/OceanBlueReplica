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
