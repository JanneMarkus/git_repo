#! python3

#Try 3
import os
import pyperclip
import pandas as pd

###Tries to find the correctly named CSV and opens it as "file", throws an error and quits if the file is not found.
try:
	file = pd.read_csv(r'C:\\Users\\janne\\downloads\\notes.csv', sep=',', names=['Annotation Type', 'Location', 'Starred?', 'Annotation'])
except:
	print('Error: Could not find "notes.csv" in the Downloads folder')
	print('Please put the notes csv in the downloads folder, and rename it to "notes.csv", then try again')
	quit()

#finds the save.txt file
path = 'kindle_note_exporter\save.txt'
save = open(path, 'r+')

#Ask where to start
print('Please enter the start index or enter "prev" to continue where you left off:')

##Can enter an integer
isInt = None
startIndex = input()
try:
	startIndex = int(startIndex)
	isInt = True
except:
	isInt = False

##Can enter "prev" to start from data stored in save.txt
#if input == prev
if isInt == False:
	startIndex = int(save.read()) + 1
	
##If the number entered for the startIndex is larger than the list of notes return "Please enter a number less than [number of notes]"
if startIndex == len(file) + 1:
	print('There are no new notes that you haven\'t already copied. Be sure to download your newest CSV.')
	quit()
elif startIndex == len(file) or startIndex > len(file) + 1:
	print('Please enter a number between', 0, 'and', len(file) + '.')
	quit()

#Ask where to finish
print('Please enter the end index or enter "end" to select up to the end of the notes:')

##Can enter an integer
isInt = None
endIndex = input()

try:
	endIndex = int(endIndex)
	isInt = True
except:
	isInt = False

##Can enter "end" to select all lines from the start point to the end of the CSV
if isInt == False:
	endIndex = len(file)

#Select the desired info by selecting the lines between selected start and end points.
#Append the selected lines to a list, and join them with double newlines to be formatted correctly for Notion

pasteBin = []
for item in range(startIndex, endIndex):
	pasteBin.append(file.iloc[item]['Annotation'])
NotionReady = '\n\n'.join(pasteBin)

#copy the joined list to the clipboard with pyperclip
pyperclip.copy(NotionReady)

print('Press CTRL + V to paste your notes')

#erase the contents of save.txt
save.close()
os.remove(path)

#save the index of the final note to save.txt to be read as the start point next time.
newfile = open(path, 'w')
newfile.write(str(len(file)))
newfile.close()
