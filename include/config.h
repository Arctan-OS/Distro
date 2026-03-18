#ifndef ARC_CONFIG_H
#define ARC_CONFIG_H

#define ARC_HHDM_VADDR (uint64_t)0xFFFFC00000000000
#define ARC_PHYS_TO_HHDM(physical) ((uint64_t)(physical) + (uint64_t)ARC_HHDM_VADDR)
#define ARC_HHDM_TO_PHYS(hhdm) ((uint64_t)(hhdm) - (uint64_t)ARC_HHDM_VADDR)

// The number of processor descriptors to statically allocate
// TODO: Get rid of this
#define ARC_MAX_PROCESSORS 16
// The number of ticks, or timer interrupts, that are to happen
// in one second
#define ARC_TICK_FREQUENCY 1000
// The number of ticks that constitute a single timeslice for
// the scheduler
#define ARC_TICKS_PER_TIMESLICE 1000
// The number of file descriptors a single process can have
#define ARC_PROCESS_FILE_LIMIT 512
// The standard size of a memory buffer
#define ARC_STD_BUFF_SIZE (size_t)0x1000

// In the command line compile options it is possible to
// define a COM port to have debug on, use -DARC_COM_PORT=0xXXX
// (on x86-64 0x3F8 is COM1)

// Default Kernel and Userpsace stack initial sizes
// in bytes
#define ARC_STD_KSTACK_SIZE (size_t)0x2000
#define ARC_STD_USTACK_SIZE (size_t)0x2000

#define ARC_SYSCALL_STACK_SIZE 0x2000

#ifdef ARC_TARGET_ARCH_X86_64
#include <arch/x86-64/config.h>
#endif

#endif
