#pragma once
#include "common.h"

#define PAGE_SIZE 4096

#define SATP_SV32 (1u << 31)
#define PAGE_V    (1 << 0)   // бит "Valid" (запись активна)
#define PAGE_R    (1 << 1)   // Доступна для чтения
#define PAGE_W    (1 << 2)   // Доступна для записи
#define PAGE_X    (1 << 3)   // Исполняемая
#define PAGE_U    (1 << 4)   // Пользователь (доступна в режиме пользователя)

paddr_t alloc_pages(uint32_t n);

void map_page(uint32_t *table1, uint32_t vaddr, paddr_t paddr, uint32_t flags);