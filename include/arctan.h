#ifndef ARC_ARCTAN_H
#define ARC_ARCTAN_H

#include <stdint.h>
#include <stddef.h>

#ifdef ARC_TARGET_ARCH_X86_64
        enum {
  	        ARC_BOOTPROC_ARCTAN = 1,
	        ARC_BOOTPROC_MB2,
  	        ARC_BOOTPROC_LBP,
	        ARC_BOOTPROC_MAX,
        };

        enum {
	        ARC_MEMORY_BADRAM,
	        ARC_MEMORY_RESERVED,
	        ARC_MEMORY_ACPI_RECLAIMABLE,
	        ARC_MEMORY_NVS,
	        ARC_MEMORY_BOOTSTRAP,
	        ARC_MEMORY_BOOTSTRAP_ALLOC,
	        ARC_MEMORY_AVAILABLE,
	        ARC_MEMORY_MAX,
        };

        enum {
	        ARC_PAGER_FLAG_NX = 0,
	        ARC_PAGER_FLAG_GIB,
	        ARC_PAGER_FLAG_PCID,
	        ARC_PAGER_FLAG_PML5,
	        ARC_PAGER_FLAG_PKS,
	        ARC_PAGER_FLAG_MAX,
        };

        typedef struct ARC_ProcessorFeatures {
	        uint64_t paging;
        } ARC_ProcessorFeatures;
#endif

typedef struct ARC_KernelMeta{
	/// Pointer to the base of the kernel module.
	uint64_t kernel_elf;
	struct {
		uint64_t proc;
		union {
			uint64_t grub_tags;
		} info;
	} boot;
	struct {
		/// Pointer to the base of the initramfs module.
		uint64_t base;
		/// The size of the initramfs module.
		uint64_t size;

	} initramfs;
	struct {
		uint64_t base;
		uint64_t len;
	} arc_mmap;
	uint64_t rsdp;
	ARC_ProcessorFeatures features;
}__attribute__((packed)) ARC_KernelMeta;

typedef struct ARC_BootMeta {
	struct {
		uint64_t base;
		uint64_t size;
	} bsp_image;
	uint64_t mem_size;
	struct {
		uint64_t base;
		uint64_t char_rom;
		int width;
		int height;
		int bpp;
	} term;
}__attribute__((packed)) ARC_BootMeta;

typedef struct ARC_MMap {
	uint64_t base;
	uint64_t len;
	int type;
}__attribute__((packed)) ARC_MMap;

typedef struct ARC_PMMBiasConfigElement {
	size_t min_blocks;                    // The minimum number of 2^exp blocks that need
					      // to be present in a region for it to initialized
					      // as a pfreelist of 2^exp size blocks.
	uint32_t exp;                         // The exponent that this bias applies for.
	uint32_t min_buddy_exp;               // The exponent of the power of two that represents
					      // the smallest object size that a buddy allocator may
					      // allocate in pfreelist block of 2^exp bytes.
	struct {
		uint32_t numerator;
		uint32_t denominator;
	} ratio;                              // The fraction that represents how much memory from a
					      // region should be initialized into the pfreelist granted
					      // at least min_blocks can be initialized.
} ARC_PMMBiasConfigElement;

#endif
