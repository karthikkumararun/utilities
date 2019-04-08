# Utilities.
## Proxy Toggler shell script. proxyToggler.sh
###### Script to toggle proxy within corporate network.
- Change `<proxy server>` with proxy server address. Example proxy.organization.com.
- Change `<proxy server port>` with proxy server port. Example 9000.

## SSL Validator python script. SSLCertificateUtil.py
###### Script to check certificate validity from a Java Keystore.
-  If the script needs to be run as a job then set up javaPath, keystoreToValidate, certificateAlias, keystorePassword, expiryAlertDays in the script.
-  The script can also be run using user interaction. javaPath, keystoreToValidate, certificateAlias, keystorePassword, expiryAlertDays should not be set in the script.
- Set up sender, recipient email addresses for email notifications in case of certificate expiry notifications.