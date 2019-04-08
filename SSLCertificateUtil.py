'''
@Description: Python class to validate SSL certificates and send email alerts when expiration is near or if certificates have expired
@Author: Karthik Kumar Arun (karthikkumara@in.ibm.com)
@version: 1.0
@PyVersion: 3.X
               Apache License
         Version 2.0, January 2004
       http://www.apache.org/licenses/
'''

import os
import subprocess
import re
import datetime
import smtplib
from email.mime.text import MIMEText
import socket

''' Set these variables if you intend to run the program as a part of job 
and this will skip user input'''

javaPath = None
keystoreToValidate = None
certificateAlias = None
keystorePassword = None
expiryAlertDays = None
sender = None
recipient = None

emailSubject = "SSL Certificate validation report from "+socket.gethostname()
emailBody = None


# Method to get user input if input is not defined.
def getUserInput():
    javaPath = input("Enter your java keytool path: ")
    keystoreToValidate = input("Enter the path to the keystore: ")
    certificateAlias = input("Enter certificate alias: ")
    keystorePassword = input("Enter keystore password: ")
    expiryAlertDaysString = input(
        "Number of days before which alert should be raised: ")
    expiryAlertDays = int(expiryAlertDaysString)
    return javaPath, keystorePassword, certificateAlias, keystoreToValidate, expiryAlertDays

# Method to send email.
def sendEmail(emailBody):
    msg = MIMEText(emailBody)
    msg['Subject'] = emailSubject
    msg['From'] = sender
    msg['To'] = recipient
    s = smtplib.SMTP('localhost')
    s.sendmail(sender, [recipient], msg.as_string())
    s.quit()

# Method to validate certificate and invoke sendEmail() if certificate has expired or nearing expiry
def validateCertificate(validities):
    sendMail = False
    if validities is not None:
        validity = validities[0]
        splitValidity = re.split(r'until:', validity)
        endDate = splitValidity[1]
        endDate = endDate[: -8]+endDate[-4:]
        today = datetime.datetime.now()
        ssl_date_format = r'%a %b %d %H:%M:%S %Y'
        endDate = datetime.datetime.strptime(endDate.strip(), ssl_date_format)
        numberOfDaysOfValidity = ((endDate-today).days)
        if(numberOfDaysOfValidity <= 0):
            emailBody = (
                "========== Certificate has expired already! ================")
            sendMail = True
        if numberOfDaysOfValidity > expiryAlertDays:
            emailBody = (
                f"========== Certificate is OK. Valid for {numberOfDaysOfValidity} days! ================")
        else:
            emailBody = (
                f"========== Certificate is expiring in {numberOfDaysOfValidity}. Take Action to renew ================")
            sendMail = True
        print(emailBody)
        if (sendMail):
            sendEmail(emailBody)


if(javaPath is None or keystoreToValidate is None or certificateAlias is None or keystorePassword is None or expiryAlertDays is None):
    javaPath, keystorePassword, certificateAlias, keystoreToValidate, expiryAlertDays = getUserInput()

output = subprocess.check_output(
    f'{javaPath} -v -list -alias {certificateAlias} -keystore {keystoreToValidate} -storepass {keystorePassword}')

outputString = output.decode('utf-8')
validities = re.findall(
    r'Valid from:.*$', output.decode('utf-8'), re.MULTILINE)
validateCertificate(validities)
