#include "main.h"

// a sample exported function
void DLL_EXPORT SomeFunction(const LPCSTR sometext, HWND hwnd)
{
    MessageBoxA(hwnd, sometext, "What is BlackJack?", MB_OK | MB_ICONINFORMATION); //msg box name does not change, idk why
}

extern "C" DLL_EXPORT BOOL APIENTRY DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
    switch (fdwReason)
    {
        case DLL_PROCESS_ATTACH:
            // attach to process
            // return FALSE to fail DLL load
            break;

        case DLL_PROCESS_DETACH:
            // detach from process
            break;

        case DLL_THREAD_ATTACH:
            // attach to thread
            break;

        case DLL_THREAD_DETACH:
            // detach from thread
            break;
    }
    return TRUE; // succesful
}
