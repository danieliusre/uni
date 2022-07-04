import socket

HEADER = 64
PORT = 8080
FORMAT = 'utf-8'
DISCONNECT_MSG = "!DISCONNECT"
SERVER = "192.168.1.202"
ADDRESS = (SERVER, PORT)

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(ADDRESS)
connected = True

ServerWaitingForInput = False
ServerWaitingMsg = "ServerIsWaiting"

def send(msg):
    message = msg.encode(FORMAT) #encodina i bytes object kad galetumem siust per socketa
    msg_length = len(message)
    send_length = str(msg_length).encode(FORMAT)
    send_length += b' ' * (HEADER - len(send_length))
    client.send(send_length)
    client.send(message)

while connected:
    msgFromServer = ''
    msgFromServer = client.recv(HEADER).decode(FORMAT)
    if ServerWaitingMsg in msgFromServer:
        ServerWaitingForInput = True
    else:
        print(msgFromServer)
    #print("----------------------------")
    #print(ServerWaitingForInput)
    if ServerWaitingForInput:
        ServerWaitingForInput = False
        msg = input()
        if msg == DISCONNECT_MSG:
            connected = False
            send(DISCONNECT_MSG)
            break
        send(msg)
        
    
