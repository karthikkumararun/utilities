#!/bin/bash
#
# Script to toggle proxy settings within a corporate network.
# Karthik Arun (karthikarun@outlook.com)
#                Version 1.0 
#               MIT License

#Copyright (c) 2019 Karthik Kumar Arun

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.


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
