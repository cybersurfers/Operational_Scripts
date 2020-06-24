#########################
# Author: 404unf		#
# Team: CyberSurfers	#
# Creation: March 2020	#
# Update: June 2020		#
#########################

# This Script is designed for Python3.x
# DEPENDENCIES include Nmap: https://nmap.org/

import os

def main():
	mainMenu()

def mainMenu():
	print("""

********** Pre-Canned Network Scans					************
********** For standardized information gathering	************
********** Edit as needed							************

	""")

########################################	
# Prompt the user choose from this menu#
########################################

	choice = input("""
		1. Ping Sweep
		2. List Scan
		3. Syn Scan
		4. Open Port Scans
		5. Determine Open Services
		6. All TCP Ports
		7. Scan a range of TCP Ports
		8. Scan HTTP and HTTPS
		9. Scan 100 most common ports 
		10. Scan for DNS UDP Ports
		11. Scan for UDP and TCP ports for a single host
		12. Exit
			
		""")

############################################################
# If the user makes a selection, execute the specified task#
############################################################

	if choice == "1":
		pingSweep()
	elif choice == "2":
		listScan()
	elif choice == "3":
		synScan()
	elif choice == "4":
		openPorts()
	elif choice == "5":
		openServices()
	elif choice == "6":
		allTCP()
	elif choice == "7":
		rangeTCP()
	elif choice == "8":
		webScan()
	elif choice == "9":
		mostCommon()
	elif choice == "10":
		dnsUDP()
	elif choice == "11":
		singleHost()
	elif choice == "12":
		exit()
	else:
		print("Please enter a valid selection.")
		mainMenu()

########################
# Pre-canned nmap scans#
########################

def pingSweep():
	os.system('nmap -sn -PE {} {}'.format(whatSubnet(),generateReports()))

def listScan():
	os.system('nmap -sL {} {}'.format(whatSubnet(), generateReports()))

def synScan():
	os.system('nmap -Pn {} {}'.format(whatSubnet(), generateReports()))

def openPorts():
	os.system('nmap --open {} {}'.format(whatSubnet(), generateReports()))

def openServices():
	os.system('nmap -sV {} {}'.format(whatSubnet(), generateReports()))

def allTCP():
	os.system('nmap -p 1-65535 {} {}'.format(whatSubnet(), generateReports()))

def rangeTCP():
	os.system('nmap -p 80-1024 {} {}'.format(whatSubnet(), generateReports()))

def webScan():
	os.system('nmap -p 80,443 {} {}'.format(whatSubnet(), generateReports()))
	
def mostCommon():
	os.system('nmap -F {} {}'.format(whatSubnet(), generateReports()))

def dnsUDP():
	os.system('nmap -sU -p 53 {} {}'.format(whatSubnet(), generateReports()))

def singleHost():
	os.system('nmap -v -Pn -sU -sT -p U:53,111,137,T:21-25,80,139,8080 {} {}'.format(
		whatSubnet(), generateReports()))


#######################
# Repetitive functions#
#######################

def whatSubnet():
	subnet: str = input("""
Please enter an ip or subnet to scan:
		""")
	return subnet


def generateReports():
	rep_choice: str = input("""
Would you like to export output to a file? y/n
		""")
	if rep_choice == "y":
		filename = input("""
Please specify a filename:
			""")
		return "-oA {}".format(filename)
	else:
		return ""
		
#######################
#Initialize the script#
######################
	
main()
	
		
