#pragma once

#define SBI_CONSOLE_PUTCHAR 1
#define SBI_CONSOLE_GETCHAR 2

struct sbiret {
    long error;
    long value;
};

struct sbiret sbi_call(long arg0, long arg1, long arg2, long arg3, long arg4, long arg5, long fid, long eid);

inline struct sbiret sbi_call0(long eid){
    return sbi_call(0, 0, 0, 0, 0, 0, 0, eid);
}

inline struct sbiret sbi_call1(long arg0, long eid){
    return sbi_call(arg0, 0, 0, 0, 0, 0, 0, eid);
}