#!/bin/bash
#
# Script to toggle proxy settings within a corporate network.
# Karthik Arun (karthikarun@outlook.com)
#                Version 1.0 
#               Apache License
#         Version 2.0, January 2004
#       http://www.apache.org/licenses/


enableProxy=$1;

if [[ -z "$enableProxy" ]]
then
         echo "No Selected. Run with 1 for proxy, 0 for no proxy. Example: source proxyToggler.sh 1 (this will enable proxy)";
         return;
 fi

if [ $enableProxy -eq "1" ]
then
        export http_proxy=<proxy server>:<proxy server port>
        export https_proxy=<proxy server>:<proxy server port>
        export ftp_proxy=<proxy server>:<proxy server port>
        export rsync_proxy=<proxy server>:<proxy server port>
        npm config set proxy <proxy server>:<proxy server port>
        echo "proxy enabled"
elif [ $enableProxy -eq "0" ]
then
        unset http_proxy;
        unset https_proxy;
        unset ftp_proxy;
        unset rsync_proxy;
        npm config delete proxy
        echo "proxy disabled";
else
        echo "Invalid Number Selected. Run with 1 for proxy, 0 for no proxy. Example: source proxyToggler.sh 1 (this will enable proxy)";
fi