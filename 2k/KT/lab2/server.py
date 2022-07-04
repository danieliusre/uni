from ftplib import FTP
import sys
import socket
from socket import _GLOBAL_DEFAULT_TIMEOUT


host = "192.168.1.202"
user = "ftp.user"
password = "123"
"""
print("WELCOME TO YOUR FTP SERVER")
print("Press 1 to get a file from current directory")
print("Press 2 to get a file from any other directory")
print("Press 3 to upload a file")
print("Press 0 to disconnect")
"""

with FTP(host) as ftp:
    ftp.login(user = user, passwd = password)
    print(ftp.getwelcome())

    with open('myyy123test.txt', 'wb') as f: #write binary mode
        ftp.retrbinary('RETR ' + "test.txt", f.write, 1024) #retrieve from server

    ftp.quit()
"""

choice = input()
while choice != 0:
        with FTP(host) as ftp:
            ftp.login(user = user, passwd = password)
            print(ftp.getwelcome())
    
            if choice == 1:
                with open('test.txt', 'wb') as f: #write binary mode
                    ftp.retrbinary('RETR ' + "filetest.txt", f.write, 1024) #retrieve from server

            elif choice == 3:
                with open('txt.txt', 'rb') as f: #read binary mode
                    ftp.storbinary('STOR ' + 'upload.txt', f) #store to server

            elif choice == 2:
                ftp.cwd("mydir")
                with open('myspecialfile.txt', 'wb') as f:
                    ftp.retrbinary('RETR ' + 'otherfile.txt', f.write, 1024) #other directory
"""
#ftp.quit()