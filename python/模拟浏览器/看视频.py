#encoding=utf-8
from selenium import webdriver  
import time  
import os
import json

driver = webdriver.Chrome()
time.sleep(10)   #sleep一下，否则有可能报错
driver.get("http://ncgbxltsgc.ouchn.cn/study/login/index.php")

elem_user = driver.find_element_by_xpath('//input[@id="username"]') 
elem_user.send_keys('xxxxxx') 
elem_pwd = driver.find_element_by_xpath('//input[@type="password"]')
elem_pwd.send_keys('yyyyy')

commit = driver.find_element_by_xpath('//button[@id="loginbtn"]')
commit.click()
time.sleep(10)

urls_file = open('urls.json') #打开当前运行目录下的文件
url_array = json.load(urls_file)
for item in url_array:
	driver.get(item)
	while True:
		try:
			time.sleep(20)
			play = driver.find_element_by_xpath('//*[@id="video"]/div/div[2]/div[1]/canvas')
			play.click()
			time.sleep(900)
			driver.refresh()
		except Exception as e:
			print(e)
			break
	
	


#driver.get("http://ncgbxltsgc.ouchn.cn/study/course/view.php?id=32&sectionid=443&mid=2010")

#time.sleep(20)
#play = driver.find_element_by_xpath('//*[@id="video"]/div/div[2]/div[1]/canvas')
#play.click()
#time.sleep(600)
#driver.refresh()
#
#urls_file = open('urls.json')
#url_array = json.load(urls_file)
#for item in url_array:
#	n = 0	
#	while True:
#		try:
#			if n>0:
#				raise RuntimeError("sss")
#			print(item)
#			n=n+1
#		except Exception as e:
#			print("================")
#			break
