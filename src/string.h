#pragma once 
#include "sbi.h"

inline void putchar(char ch) {
    sbi_call1(ch, SBI_CONSOLE_PUTCHAR);
}

void printf(const char *fmt, ...);
char *strcpy(char *dst, const char *src);
int strcmp(const char *s1, const char *s2);