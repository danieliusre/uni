#if defined(UNICODE) && !defined(_UNICODE)
    #define _UNICODE
#elif defined(_UNICODE) && !defined(UNICODE)
    #define UNICODE
#endif

#include <iostream>
#include <ctime>
#include <cstdlib>
#include <string>
#include <tchar.h>
#include <ctime>
#include <cstdlib>
#include <windows.h>
#include "radio.h"
#include "menu.h"
#include "files.h"
#include <stdio.h>
#include <unistd.h>
#include "main.h"

/*  Declare Windows procedure  */
LRESULT CALLBACK WindowProcedure (HWND, UINT, WPARAM, LPARAM);
BOOL CALLBACK DialogProc (HWND, UINT, WPARAM, LPARAM);

typedef void (__cdecl *MYPROC)(LPCSTR, HWND);

static COLORREF black = RGB(0,0,0);
static COLORREF grey = RGB(220,220,220);
static COLORREF darkRed = RGB(100,0,0);
static COLORREF darkBlue = RGB(0,0,100);
static COLORREF bkcolor = darkBlue;

int credits = 500;
int Nwin = 0;
int Nloss = 0;
int wager = 0;

int playerHand = 0;
int dealerHand = 0;
int pcards= 0;
int dcards= 0;

HWND wager1;

void init(HWND);
void startGame(HWND);
void hit(HWND);
void stay(HWND);
void determineWinner(int, int, HWND);
int getCard(int);

/*  Make the class name into a global variable  */
TCHAR szClassName[ ] = _T("CodeBlocksWindowsApp");

struct {
    int cred;
    int w;
    int l;
} playerInfo;

int WINAPI WinMain (HINSTANCE hThisInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR lpszArgument,
                     int nCmdShow)
{
    HWND hwnd;               /* This is the handle for our window */
    MSG messages;            /* Here messages to the application are saved */
    WNDCLASSEX wincl;        /* Data structure for the windowclass */

    /* The Window structure */
    wincl.hInstance = hThisInstance;
    wincl.lpszClassName = szClassName;
    wincl.lpfnWndProc = WindowProcedure;      /* This function is called by windows */
    wincl.style = CS_DBLCLKS;                 /* Catch double-clicks */
    wincl.cbSize = sizeof (WNDCLASSEX);

    /* Use default icon and mouse-pointer */
    wincl.hIcon = LoadIcon (NULL, IDI_APPLICATION);
    wincl.hIconSm = LoadIcon (NULL, IDI_APPLICATION);
    wincl.hCursor = LoadCursor (NULL, IDC_ARROW);
    wincl.lpszMenuName = NULL;                 /* No menu */
    wincl.cbClsExtra = 0;                      /* No extra bytes after the window class */
    wincl.cbWndExtra = 0;                      /* structure or the window instance */
    /* Use Windows's default colour as the background of the window */
    wincl.hbrBackground = (HBRUSH) COLOR_BACKGROUND;

    /* Register the window class, and if it fails quit the program */
    if (!RegisterClassEx (&wincl))
        return 0;

    /* The class is registered, let's create the program*/
    hwnd = CreateWindowEx (
           0,                   /* Extended possibilites for variation */
           szClassName,         /* Classname */
           _T("Code::Blocks Template Windows App"),       /* Title Text */
           WS_OVERLAPPEDWINDOW, /* default window */
           CW_USEDEFAULT,       /* Windows decides the position */
           CW_USEDEFAULT,       /* where the window ends up on the screen */
           544,                 /* The programs width */
           375,                 /* and height in pixels */
           HWND_DESKTOP,        /* The window is a child-window to desktop */
           LoadMenu(NULL, MAKEINTRESOURCE(IDR_MYMENU)),                /* No menu */
           hThisInstance,       /* Program Instance handler */
           NULL                 /* No Window Creation data */
           );

    /* Make the window visible on the screen */
    ShowWindow (hwnd, nCmdShow);

    /* Run the message loop. It will run until GetMessage() returns 0 */
    while (GetMessage (&messages, NULL, 0, 0))
    {
        /* Translate virtual-key messages into character messages */
        TranslateMessage(&messages);
        /* Send message to WindowProcedure */
        DispatchMessage(&messages);
    }

    /* The program return-value is 0 - The value that PostQuitMessage() gave */
    return messages.wParam;
}


/*  This function is called by the Windows function DispatchMessage()  */

LRESULT CALLBACK WindowProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    //int length; //edit fieldui
    //LPTSTR buffer;
    LPSTR txt;
    HANDLE file;
    DWORD b_written, b_read;
    CHAR txt2[2048]={0};
    switch (message)                  /* handle the messages */
    {
    case WM_CREATE:
        init(hwnd);
        //TEXT FIELDS FOR THE CARDS
        CreateWindow("BUTTON",
                    TEXT("Dealers' cards:"),
                    WS_VISIBLE | WS_CHILD | BS_GROUPBOX,  // <-- GROUPBOX
                    10,10,250,100,
                    hwnd, (HMENU) GROUP, GetModuleHandle(NULL), NULL);
        CreateWindow("BUTTON",
                    TEXT("Your cards:"),
                    WS_VISIBLE | WS_CHILD | BS_GROUPBOX,  // <-- GROUPBOX
                    10,100,250,100,
                    hwnd, (HMENU) GROUP, GetModuleHandle(NULL), NULL);
        CreateWindow(
            "BUTTON",
            "HIT",
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            10, 220, 100, 50,
            hwnd,
            (HMENU) BUTTON_HIT,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
        CreateWindow(
            "BUTTON",
            "STAY",
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            120, 220, 100, 50,
            hwnd,
            (HMENU) BUTTON_STAY,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
        CreateWindow(
            "BUTTON",
            "DOUBLE",
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            240, 220, 100, 50,
            hwnd,
            (HMENU) BUTTON_DOUBLE,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
        CreateWindow(
            "BUTTON",
            "START GAME",
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            400,180,100,50,
            hwnd,
            (HMENU) BUTTON_START_GAME,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
        break;
    case WM_KEYDOWN:
            //MessageBox(hwnd, "Paspaustas mygtukas", "", MB_OK);
        break;
    case WM_PAINT: //CHANGE BACKGROUND COLOR
    {
        PAINTSTRUCT ps;
        RECT rc;
        HDC hdc = BeginPaint(hwnd, &ps);
        GetClientRect(hwnd, &rc);
        SetDCBrushColor(hdc, bkcolor);
        FillRect(hdc, &rc, (HBRUSH)GetStockObject(DC_BRUSH));
        EndPaint(hwnd, &ps);
        break;
    }
    case WM_ERASEBKGND:
        //return 0 means WM_PAINT handles the background
        return 0;
    case WM_COMMAND:
        switch(LOWORD(wParam)){
            case BUTTON_START_GAME:
                startGame(hwnd);
                break;
            case BUTTON_HIT:
                hit(hwnd);
                break;
            case BUTTON_STAY:
                stay(hwnd);
                break;
            case BUTTON_DOUBLE:
                wager = wager * 2;
                hit(hwnd);
                if(playerHand <= 21)
                    stay(hwnd);
                break;
            case ID_FILE_EXIT:
                DestroyWindow(hwnd);
                break;
            case DLL_BTN:
                {
                HINSTANCE hinstLib = LoadLibrary("C:\\Users\\danie\\Desktop\\winapi\\dll\\dll\\bin\\Debug\\dll.dll"); //PATH TO DLL FILE
                if (hinstLib != NULL){
                    MYPROC SomeFunction = (MYPROC) GetProcAddress(hinstLib, "SomeFunction");
                    if (SomeFunction != NULL){
                        SomeFunction("Blackjack (formerly Black Jack and Vingt-Un) is a casino banking game. The most widely played casino banking game in the world, it uses decks of 52 cards and descends from a global family of casino banking games known as Twenty-One. This family of card games also includes the British game of Pontoon, the European game, Vingt-et-Un and the Russian game Ochko. Blackjack players do not compete against each other. The game is a comparing card game where each player competes against the dealer.", hwnd);
                    }
                    FreeLibrary(hinstLib);
                }
                break;
                }
            //CHANGE WINDOW NAME IN MENU
            case CHANGE_WIND_NAME:
                DialogBox(NULL, MAKEINTRESOURCE(MYDIALOG), hwnd, (DLGPROC)DialogProc);
                break;

            //SAVE GAME STATE IN MENU
            case ID_SAVE_STATE:
                file = CreateFile("Test.txt", GENERIC_WRITE,0,NULL,CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
                playerInfo.cred = credits;
                playerInfo.w = Nwin;
                playerInfo.l = Nloss;
                txt = "Some text lolol\n";
                if(file != INVALID_HANDLE_VALUE)
                {
                    WriteFile(file, &playerInfo , sizeof(playerInfo), &b_written, NULL);
                    CloseHandle(file);
                }
                break;

            //LOAD GAME STATE FROM MENU
            case ID_LOAD_STATE:
                file = CreateFile("Test.txt", GENERIC_READ,0,NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,NULL);
                if(file != INVALID_HANDLE_VALUE)
                {
                    ReadFile(file, &playerInfo, sizeof(playerInfo), &b_read, NULL);
                    if(b_read)
                    {
                        char c[10];
                        sprintf(c,"Info updated:\n Credits: %d\n Wins: %d\n Losses: %d\n", playerInfo.cred, playerInfo.w, playerInfo.l);
                        MessageBox(hwnd, c, "Reading", MB_OK);
                        credits = playerInfo.cred;
                        Nwin = playerInfo.w;
                        Nloss = playerInfo.l;
                        init(hwnd);
                    }
                    CloseHandle(file);
                }
                break;
            case IDR_RADIO1:
                bkcolor = black;
                InvalidateRect(hwnd, NULL, TRUE);
                break;
            case IDR_RADIO2:
                bkcolor = grey;
                InvalidateRect(hwnd, NULL, TRUE);
                break;
            case IDR_RADIO3:
                bkcolor = darkRed;
                InvalidateRect(hwnd, NULL, TRUE);
                break;
            case BCK_WHITE:
                bkcolor = RGB(255,255,255);
                InvalidateRect(hwnd, NULL, TRUE);
                break;
            }
        break;
    case WM_DESTROY:
        PostQuitMessage (0);       /* send a WM_QUIT to the message queue */
        break;
    default:                      /* for messages that we don't deal with */
            return DefWindowProc (hwnd, message, wParam, lParam);
    }

    return 0;
}

void hit(HWND hwnd)
{
    int seed = int(time(0));
    int value = getCard(seed);
    char p[20];
    sprintf(p, "%d", value);
    playerHand += value;
    if(pcards == 2)
    {
            CreateWindow(
            "STATIC",
            p,
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            130, 130, 40, 50,
            hwnd,
            (HMENU) PLAYER_3,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
            pcards++;

    }
    else if(pcards == 3)
    {
        CreateWindow(
            "STATIC",
            p,
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            180, 130, 40, 50,
            hwnd,
            (HMENU) PLAYER_4,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
            pcards++;
    }

    if(playerHand > 21)
    {
        stay(hwnd);
    }
}
void stay(HWND hwnd)
{
    dcards = 1;
    int seed = int(time(0));
    int value = getCard(seed);
    char d[20];
    sprintf(d, "%d", value);
    while(dealerHand < 16)
        {
            dealerHand += value;
            CreateWindow(
            "STATIC",
            d,
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            30+(dcards*50), 40, 40, 50,
            hwnd,
            (HMENU) DEALER_1,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
            dcards++;
            value = getCard(value);
            sprintf(d, "%d", value);
        }
    determineWinner(playerHand, dealerHand, hwnd);
    char a[100];
    init(hwnd);

}
void redraw(HWND hwnd)
{
    //sleep(5);
    for(int i=0; i<4; i++)
    {
        CreateWindow(
            "STATIC",
            "?",
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            30+(i*50), 40, 40, 50,
            hwnd,
            (HMENU) DEALER_U,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
        CreateWindow(
            "STATIC",
            "?",
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            30+(i*50), 130, 40, 50,
            hwnd,
            (HMENU) PLAYER_U,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);
    }

}
void startGame(HWND hwnd)
{
    char wag[10];
    GetWindowText(wager1, wag, 10);
    sscanf(wag, "%d", &wager);
    int choice;
    int value1;
    int value2;
    int value3;
    int value4;
    srand(time(0));
    int seed = rand();
    bool playerIn = true;
    playerHand = 0;
    dealerHand = 0;

    value1 = getCard(seed);
    playerIn = true;
    dealerHand += value1;
    char d1[20];
    sprintf(d1, "%d", value1);

    CreateWindow(
            "STATIC",
            d1,
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            30, 40, 40, 50,
            hwnd,
            (HMENU) DEALER_1,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);

    value2 = getCard(value1);
    playerHand += value2;

    char p1[20];
    sprintf(p1, "%d", value2);
    CreateWindow(
            "STATIC",
            p1,
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            30, 130, 40, 50,
            hwnd,
            (HMENU) PLAYER_1,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);

    value3 = getCard(value2);
    char p2[20];
    sprintf(p2, "%d", value3);

    CreateWindow(
            "STATIC",
            p2,
            WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
            80, 130, 40, 50,
            hwnd,
            (HMENU) PLAYER_2,
            (HINSTANCE) GetWindowLong(hwnd, GWLP_HINSTANCE),
            NULL);


    playerHand += value3;
    pcards = 2;
}
void determineWinner(int playerHand, int dealerHand, HWND hwnd)
{
    std::string message;
    if(playerHand > 21)
    {
        message = "Over 21! You Bust! DEALER WINS";
        credits -= wager;
        Nloss += 1;
    }
    else if (dealerHand > 21)
    {
        message = "Dealer has over 21 and busts! YOU WIN!";
        credits += wager;
        Nwin += 1;
    }
    else if(playerHand > dealerHand)
    {
        message = "You have " + std::to_string(playerHand) + " and the dealer has " + std::to_string(dealerHand) + " YOU WIN! ";
        credits += wager;
        Nwin += 1;
    }
    else if(playerHand < dealerHand)
    {
        message = "You have " + std::to_string(playerHand) + " and the dealer has " + std::to_string(dealerHand) + " DEALER WINS! ";
        credits -= wager;
        Nloss += 1;
    }
    else
        message = "You have " + std::to_string(playerHand) + " and the dealer has " + std::to_string(dealerHand) + " ITS A DRAW! ";

    dealerHand = 0;
    playerHand = 0;

    char message1[50];

    sprintf(message1, "%s", message.c_str());
    MessageBox(hwnd, message1, "ROUND END", MB_OK);
}
int getCard(int seed)
{
    srand(seed);
    int value = 2 + (rand() % 14);
    if(value > 10)
        return 10;
    else
        return value;
}
void init(HWND hwnd)
{
    wager = 50;
    //RADIO BUTTONS FOR CHANGING BACKGROUND COLORS
    //sleep(5);
    redraw(hwnd);
    CreateWindow("STATIC",
                    TEXT("Background color:"),
                    WS_CHILD | WS_VISIBLE | WS_TABSTOP,
                    10,280,120,20,
                    hwnd, (HMENU) GROUP1, GetModuleHandle(NULL), NULL);
    CreateWindow("BUTTON", TEXT("Black"),
                    BS_AUTORADIOBUTTON | WS_CHILD | WS_VISIBLE,
                    150, 280, 100, 20,
                    hwnd, (HMENU) IDR_RADIO1, GetModuleHandle(NULL), NULL);
    CreateWindow("BUTTON", TEXT("Grey"),
                    BS_AUTORADIOBUTTON | WS_CHILD | WS_VISIBLE,
                    275, 280, 100, 20,
                    hwnd, (HMENU) IDR_RADIO2, GetModuleHandle(NULL), NULL);
    CreateWindow("BUTTON", TEXT("Dark red"),
                    BS_AUTORADIOBUTTON | WS_CHILD | WS_VISIBLE,
                    400, 280, 100, 20,
                    hwnd, (HMENU) IDR_RADIO3, GetModuleHandle(NULL), NULL);
    char c1[20];
    sprintf(c1, "Win/Lose: %d / %d", Nwin, Nloss);
    CreateWindow("STATIC",
                    TEXT(c1),
                    WS_CHILD | WS_VISIBLE | WS_TABSTOP,
                    300,20,150,20,
                    hwnd, (HMENU) GROUP1, GetModuleHandle(NULL), NULL);
    char c2[20];
    sprintf(c2, "Your credits: %d", credits);
    CreateWindow("STATIC",
                    TEXT(c2),
                    WS_CHILD | WS_VISIBLE | WS_TABSTOP,
                    300,50,180,20,
                    hwnd, (HMENU) GROUP1 /* ID */, GetModuleHandle(NULL), NULL);
    wager1 = CreateWindow("STATIC",
                    TEXT("Next bet:"),
                    WS_CHILD | WS_VISIBLE | WS_TABSTOP,
                    300,150,80,20,
                    hwnd, (HMENU) GROUP1, GetModuleHandle(NULL), NULL);
    //GETS NEXT BET
    CreateWindow("EDIT",
                    TEXT("50"),
                    WS_CHILD | WS_VISIBLE | WS_TABSTOP,
                    400,150,50,20,
                    hwnd, (HMENU) GROUPEDIT, GetModuleHandle(NULL), NULL);

}

BOOL CALLBACK DialogProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    int length; //edit fieldui
    LPTSTR buffer;
    LPTSTR edittxt;
    switch(uMsg)
    {
        case WM_INITDIALOG:
            CreateWindow(
            "EDIT",
            "",
            WS_VISIBLE | WS_CHILD | ES_MULTILINE,
            50, 50, 100, 100,
            hDlg,
            (HMENU) EDIT_TITLE_DLG,
            (HINSTANCE) GetWindowLong(hDlg, GWLP_HINSTANCE),
            NULL);
            return TRUE;
        case WM_KEYDOWN:
            MessageBox(hDlg, "Paspaustas mygtukas", "", MB_OK);
            length = SendMessage(GetDlgItem(hDlg, EDIT_TITLE_DLG), WM_GETTEXTLENGTH, 0, 0);
            buffer = new TCHAR[length+1];
            GetWindowText(GetDlgItem(hDlg, EDIT_TITLE_DLG), buffer, length+1);
            SetWindowText(GetParent(hDlg), buffer);
            EndDialog(hDlg, 0);
            return TRUE;
        case WM_COMMAND:
            switch(LOWORD(wParam))
            {
                case DIALOG_BUTTON:
                    length = SendMessage(GetDlgItem(hDlg, EDIT_TITLE_DLG), WM_GETTEXTLENGTH, 0, 0);
                    buffer = new TCHAR[length+1];
                    GetWindowText(GetDlgItem(hDlg, EDIT_TITLE_DLG), buffer, length+1);
                    SetWindowText(GetParent(hDlg), buffer);
                    EndDialog(hDlg, 0);
                    return TRUE;
            }
            return TRUE;
        case WM_CLOSE:
            EndDialog(hDlg, 0);
            return TRUE;
        case WM_DESTROY:
            EndDialog(hDlg, 0);
            return TRUE;

    }

    return FALSE;
}



