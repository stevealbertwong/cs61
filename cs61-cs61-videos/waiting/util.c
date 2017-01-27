#include <sys/types.h>
#include <sys/stat.h>
#include <assert.h>
#include <fcntl.h>
#include <unistd.h>
int
main(void)
{
    char c;
    int fd;

    assert((fd = open("/dev/null", O_RDONLY)) > 0);
    while (1)
        read(fd, &c, 1);
    return (0);
}
