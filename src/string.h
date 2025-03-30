#pragma once 
#include "sbi.h"

inline void putchar(char ch) {
    sbi_call1(ch, SBI_CONSOLE_PUTCHAR);
}

void printf(const char *fmt, ...);