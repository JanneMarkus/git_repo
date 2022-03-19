from selenium import webdriver as wd

import chromedriver_binary

wd = wd.Chrome()

wd.implicitly_wait(10)

product = "https://www.bestbuy.ca/en-ca/product/steelseries-arctis-7p-wireless-gaming-headset-for-playstation-5-white/14963775?source=collection&adSlot=2"

wd.get(product)

add_to_cart_button = wd.find_element_by_xpath('//*[@id="test"]/button')

add_to_cart_button.click()

while(True):
    pass

## this is the video I was following https://www.youtube.com/watch?v=0jY4v4NDfcE