// Practice manipulating bits in the service of accessing parts of
// virtual memory structures.
//
// In the video we saw a collection of macros that we'll use when we
// implement parts of Weensy OS. For now, let's write some routines
// that extract fields from virtual addresses and page table entries,
// given the sizes of those fields.  This will both provide experience
// manipulating virtual addresses as well as reinforce all those pesky
// bit manipulation mechanisms in C.
#include <assert.h>
#include <stdio.h>
#include "bits.h"

// Determine if a value is a power of 2
int
is_power_of_two(unsigned val)
{
	while ((val & 0x1) != 1)
		val >>= 1;
	// At this point, the low bit is 1; it
	// had better be the only bit set.
	return ((val & (~0x1)) == 0);
}

// Assuming that val is a power of 2, figure out
// how many bits you have to shift for it.
int
bit_shift(unsigned val)
{
	int n;

	n = 0;
	while ((val >>= 1) != 0)
		n++;
	// At this point, the low bit is 1; it
	// had better be the only bit set.
	return (n);
}

unsigned
va_to_page_offset(uintptr_t va, unsigned pagesize)
{
	assert(is_power_of_two(pagesize));
	return (va & (pagesize - 1));
}



unsigned
va_to_page_number(uintptr_t va, unsigned pagesize)
{
	assert(is_power_of_two(pagesize));
	return (va >> bit_shift(pagesize));
}

#define	PRIV_BIT 	0x1
#define	READ_BIT 	0x2
#define	WRITE_BIT	0x4
#define	EXEC_BIT	0x8
#define	PPGNO_SHIFT	4

unsigned
pte_is_privileged(unsigned pte)
{
	return (pte & PRIV_BIT);
}

unsigned
pte_is_readable(unsigned pte)
{
	return (pte & READ_BIT);
}

unsigned
pte_is_writeable(unsigned pte)
{
	return (pte & WRITE_BIT);
}

unsigned
pte_is_executable(unsigned pte)
{
	return (pte & EXEC_BIT);
}

unsigned
pte_to_pagenum(unsigned pte)
{
	return (pte >> PPGNO_SHIFT);
}


unsigned
make_pte(unsigned pgno, unsigned access, unsigned priv)
{
	return ((pgno << PPGNO_SHIFT) | ((access & 0x7) << 1) | (priv & 1));
}

