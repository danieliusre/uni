# This file will be used for recieving files over socket connection.
import os
import socket
import time
import sys
import socket
from socket import _GLOBAL_DEFAULT_TIMEOUT

host = "192.168.1.202"
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
ADDRESS = (host, 21)

# Trying to connect to socket.
try:
    conn = sock.connect((host, 21))
    print("Connected Successfully")
except:
    print("Unable to connect")
    exit(0)

# Send file details.
file_name = "test.txt"
file_size = 5

def ntransfercmd(self, cmd, rest=None):
        size = None
        if self.passiveserver:
            host, port = self.makepasv()
            
            try:
                if rest is not None:
                    self.sendcmd("REST %s" % rest)
                resp = self.sendcmd(cmd)
                # Some servers apparently send a 200 reply to
                # a LIST or STOR command, before the 150 reply
                # (and way before the 226 reply). This seems to
                # be in violation of the protocol (which only allows
                # 1xx or error messages for LIST), so we just discard
                # this response.
                if resp[0] == '2':
                    resp = self.getresp()
                if resp[0] != '1':
                    pass
            except:
                conn.close()
                raise
        else:
            with self.makeport() as sock:
                if rest is not None:
                    self.sendcmd("REST %s" % rest)
                resp = self.sendcmd(cmd)
                # See above.
                if resp[0] == '2':
                    resp = self.getresp()
                if resp[0] != '1':
                    pass
                conn, sockaddr = sock.accept()
                if self.timeout is not _GLOBAL_DEFAULT_TIMEOUT:
                    conn.settimeout(self.timeout)
        if resp[:3] == '150':
            # this is conditional in case we received a 125
            size = type(int(resp))
        return conn, size

def transfercmd(self, cmd, rest=None):
    return self.ntransfercmd(cmd, rest)[0]

def retrbinary(self, conn, callback, blocksize=8192, rest=None):
            conn = socket.create_connection(ADDRESS)
            while 1:
                data = conn.recv(blocksize)
                if not data:
                    break
                callback(data)
            # shutdown ssl layer
            return self.voidresp()


# Opening and reading file.
with open('mytest.txt', 'wb') as f: #write binary mode
    retrbinary('RETR ' + "test.txt", f.write, 1024)

#print("File transfer Complete.Total time: ", end_time - start_time)


# Closing the socket.
sock.close()