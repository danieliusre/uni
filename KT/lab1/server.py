import socket
import threading
import random

HEADER = 64
PORT = 8080
SERVER = socket.gethostbyname(socket.gethostname()) #IPv4
ADDRESS = (SERVER, PORT)
FORMAT = 'utf-8'
DISCONNECT_MSG = "!DISCONNECT"

ServerWaitingForInput = False
ServerWaitingMsg = "ServerIsWaiting"

#game
def BlackJack(conn, addr):
    playerIn = True
    dealerIn = True

    deck = [2,3,4,5,6,7,8,9,10,2,3,4,5,6,7,8,9,10,2,3,4,5,6,7,8,9,10,'J','Q','K','A','J','Q','K','A','J','Q','K','A']
    player_hand = []
    dealer_hand = []

    #deal-----------------------------------------------------------------------
    def dealCard(turn):
        card = random.choice(deck)
        turn.append(card)
        deck.remove(card)

    #calculate hand value-------------------------------------------------------
    def total(turn):
        total = 0
        ace = False
        face = ['J','Q','K']
        for card in turn:
            if card in range (1, 11):
                total += card
            elif card in face:
                total += 10
            else:
                ace = True
                total += 11
        if total > 21 and ace == True:
            total -= 10
            ace = False
        return total

    #check for winner-----------------------------------------------------------
    def revealDealerHand():
        if len(dealer_hand) == 2:
            return dealer_hand[0]
        elif len(dealer_hand) > 2:
            return dealer_hand[0], dealer_hand[1]

    #game loop------------------------------------------------------------------
    for _ in range(2):
        dealCard(player_hand)
        dealCard(dealer_hand)

    while playerIn:
        send(f"\nDealer has: {revealDealerHand()} and X", conn)
        send(f"You have {player_hand} for a total of {total(player_hand)}" ,conn)
        if total(player_hand) == 21 and len(player_hand) == 2:
            send("BlackJack! You win!", conn)
            break
        if playerIn:
            send("1: Stay\n2: Hit\n", conn)
            send(ServerWaitingMsg, conn)
            playerChoice = receive(conn, addr)
        try:
            playerChoice = int(playerChoice)
            if int(playerChoice) == 1:
                playerIn = False
            elif int(playerChoice) == 2:
                dealCard(player_hand)
            else:
                send("Bad input, staying", conn)
                playerIn = False
        except:
            send("Bad input, staying", conn)
            playerIn = False
        if total(player_hand) >= 21:
            if total(player_hand) > 21:
                dealerIn = False
            break
    while dealerIn:
        if total(dealer_hand) > 16:
            dealerIn = False
        else:
            dealCard(dealer_hand)
        if total(dealer_hand) >= 21:
            break

    #determite winner-----------------------------------------------------------
    send("\n", conn)
    if total(player_hand) == 21 and len(player_hand) == 2:
        pass
    elif total(player_hand) == 21:
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        if total(dealer_hand) != 21:
            send("\nYou win!", conn)
        else:
            send("\nYou both have 21, it's a draw!", conn)
    elif total(dealer_hand) == 21:
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        send("\nDealer wins!", conn)
    elif total(player_hand) > 21:
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        send("\nYou bust! Dealer wins!", conn)
    elif total(dealer_hand) > 21:
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        send("\nDealer busts! You win!", conn)
    elif 21 - total(dealer_hand) < 21 - total(player_hand):
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        send("\nDealer wins!", conn)
    elif 21 - total(dealer_hand) > 21 - total(player_hand):
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        send("\nYou win!", conn)
    else:
        send(f"\nYou have {player_hand} for a total of {total(player_hand)} and the dealer has {dealer_hand} for a total of {total(dealer_hand)}\n", conn)
        send("\nIts a draw!", conn)

    send("\n", conn)


#server---------------------------------------------------------------------
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(ADDRESS) 

def handle_client(conn, addr):
    print(f"[NEW CONNECTION] {addr} just connected.")
    connected = True
    while connected:
            send("\nPress 1 to play", conn)
            send("\nType !DISCONNECT to disconnect", conn)
            send(ServerWaitingMsg, conn)
            msg = receive(conn, addr)
            if msg == DISCONNECT_MSG:
                connected = False
            elif msg == '1':
                BlackJack(conn, addr)
            else:
                pass
    conn.close()

def receive(conn, addr):
    msg_length = conn.recv(HEADER).decode(FORMAT)
    if msg_length:
        msg_length = int(msg_length)
        msg = conn.recv(msg_length).decode(FORMAT)
        print(f"[{addr}]: {msg}")
        return msg

def start():
    server.listen()
    print(f"SERVER LISTENING on {SERVER}")
    while True:
        conn, addr = server.accept() #prisijungus naujam clientui perduoda jo connectiona ir adresa
        #handle_client(conn, addr)
        thread = threading.Thread(target = handle_client, args = (conn, addr))
        thread.start()
        print(f"[ACTIVE CONNECTIONS] {threading.activeCount() - 1}")

def send(msg, conn):
    message = msg.encode(FORMAT) 
    message = message + b' ' * (HEADER - len(message))
    conn.send(message)

print("SERVER IS STARTING..")

start()
