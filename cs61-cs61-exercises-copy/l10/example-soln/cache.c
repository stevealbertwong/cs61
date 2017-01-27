#include <assert.h>
#include <errno.h>
#include "cache.h"

// In-class exercise to build a simple read cache capable
// of handling sequential byte accesses
//
// We will make the function prototype of cache_file_open and cache_byte_read
// match open and read so that you can switch to your own cache with minimal
// code modifications.
#define BLOCKSIZE 512

// We are keeping a cache of blocks of size BLOCKSIZE. We make sure that
// BLOCKSIZE is always a power of two. To figure out if a particular offset
// resides in a particular entry, we want to check if the offset is greater
// than or equal to the tag and less than tag + BLOCKSIZE. However, due to
// the wonders of the powers of two, we can use bitwise operations to make
// that more efficient -- by masking out the low order bits (those less than
// the blocksize) in the position, we will produce the address of the first
// byte in a block and thus the tag -- so we only need check for equality.
//
// BLOCKSIZE - 1 produces a value that has just the lower bits set
// If we AND that with an offset, we get the number of bytes into a cache
// entry we find that offset.
//
// If we now applying ~ to our offset, we get a mask with 0 in all the lower
// bits and 1 in the high order bits.
// And-ing that value with the offset produces the tag for the block
// containing this offset
#define CACHE_OFFSET(O)   (O & (BLOCKSIZE - 1))
#define CACHE_TAG(O)   (O & ~(BLOCKSIZE - 1))

#define MAXFD 10
#define MAX_CACHE_SIZE 200

// If valid_bytes is 0, then this is an invalid cache entry
typedef struct _ce {
    char buf[BLOCKSIZE];    // Buffer to hold data already read
    size_t valid_bytes;     // Number of valid bytes in the buffer
    off_t tag;
} cache_entry;

typedef struct _fd {
    cache_entry entries[MAX_CACHE_SIZE]; 
    off_t offset;           // Next file position to read
    int last_entry;         // Last cache entry accessed
    int not_seq;            // Need to lseek
} filedata;

filedata fd_table[MAXFD + 1];
long cache_hits, cache_misses;

int
cache_file_open(const char *path, int oflag)
{
    int fd, i;

    fd = open (path, oflag);
    if (fd  >= 0) {
        fd_table[fd].offset = 0;
        for (i = 0; i < MAX_CACHE_SIZE; i++)
            fd_table[fd].entries[i].valid_bytes = 0;
    }
    return (fd);
}

// Search for the cache entry matching the offset
// Use last_entry as a hint of where to start looking
// Return -1 if not found, else return index of found entry
int
__cache_no_entry(filedata *fdp)
{
    int i;

    i = fdp->last_entry; 
    do {
        if (CACHE_TAG(fdp->offset) == fdp->entries[i].tag &&
          fdp->entries[i].valid_bytes != 0) {
            // Found it!
            cache_hits++;
            return (i);
        }
        i = (i + 1) % MAX_CACHE_SIZE;
    } while (i != fdp->last_entry);
    cache_misses++;
    return (-1);
}

int
cache_file_read(int fd, void *buf, size_t nbytes)
{
    filedata *fdp;
    int do_seek, i, min_ndx, n;
    off_t offset, start_off;

    assert(fd <= MAXFD);
    // assert(nbytes == 1); (Remove this for part II)
    fdp = &fd_table[fd];
    offset = fdp->offset;
    do_seek = fdp->not_seq;
    fdp->not_seq = 0;

    // First check if we need to do a read.

    if ((i = __cache_no_entry(fdp)) == -1) {
        // Find a cache-entry: look for an invalid cache entry;
        min_ndx = 0;
        for (i = 0; i < MAX_CACHE_SIZE; i++) {
            if (fdp->entries[i].valid_bytes == 0)
                break;
            if (fdp->entries[i].tag < fdp->entries[min_ndx].tag)
                min_ndx = i;
        }
        // When we get here, either the ith entry has no valid bytes
        // or our cache is full and we need to evict someone
        // If the cache isn't full, then i is where we should put
        // our new block if it is full, we'll pick the one with the
        // smallest tag (based on the assumption that most file access is
        // forward sequential. This isn't a great policy but it's
        // fine for now. (Note we set that up above.)
        if (i != MAX_CACHE_SIZE)
            min_ndx = i;

        fdp->entries[min_ndx].valid_bytes = 0;
        fdp->entries[min_ndx].tag = CACHE_TAG(offset);
        if (do_seek && lseek(fd, offset, SEEK_SET) != offset)
            return (-1);
        n = read(fd, fdp->entries[min_ndx].buf, BLOCKSIZE);
        if (n <= 0)
            return (n);
        fdp->entries[min_ndx].valid_bytes = n;
        fdp->last_entry = min_ndx;
    }

    // At this point, offset is the byte we want; last_entry is the entry
    // containing the data; all we need do is return the data now.
    
    // Find the offset in the current entry corresponding to our file offset.
    start_off = CACHE_OFFSET(offset);

    // In a more complete cache implementation we'd have to check if the
    // number of bytes we need to read exceeds the number of bytes that
    // we have in this cache entry, but right now, we know that we only
    // ever return full blocks or one byte.

    memcpy(buf, &fdp->entries[fdp->last_entry].buf[start_off], nbytes);
    fdp->offset++;
    return (nbytes);
}

void
cache_read_block(int fd, void  *buf, size_t blocksize, size_t blocknum)
{
    filedata *fdp;
    off_t offset;

    assert(fd <= MAXFD);
    fdp = &fd_table[fd];
    offset = blocksize * blocknum;
    if (offset != fdp->offset) {
        fdp->not_seq = 1;
        fdp->offset = offset;
    }
    if (cache_file_read(fd, buf, blocksize) != blocksize) {
        fprintf(stderr, "Fatal error %s\n", strerror(errno));
    }
}


void
cache_stats()
{
    printf("Hits = %ld Misses = %ld Hit rate: %4.2f\n",
      cache_hits, cache_misses,
      (float)cache_hits / (float) (cache_hits + cache_misses));
}
