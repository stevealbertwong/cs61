
obj/p-quotes.full:     file format elf32-i386


Disassembly of section .text:

00100000 <process_main>:
    "When I make contact with a piece of paper without looking up I am happy.",
    "The mountain skies were clear except for the umlaut of a cloud.",
    "What's more, try it sometime. It works."
};

void process_main(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	57                   	push   %edi
  100004:	56                   	push   %esi
  100005:	53                   	push   %ebx
  100006:	81 ec 1c 01 00 00    	sub    $0x11c,%esp
    unsigned i = 0;
  10000c:	bb 00 00 00 00       	mov    $0x0,%ebx
    char buf[256];

    while (1) {
        if (i % (1 << 30) == 0) {
            int len = snprintf(buf, sizeof(buf), "%s\n",
                               messages[rand() % nmessages]);
  100011:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
    unsigned nmessages = sizeof(messages) / sizeof(messages[0]);
    char buf[256];

    while (1) {
        if (i % (1 << 30) == 0) {
            int len = snprintf(buf, sizeof(buf), "%s\n",
  100016:	8d b5 e8 fe ff ff    	lea    -0x118(%ebp),%esi
    unsigned i = 0;
    unsigned nmessages = sizeof(messages) / sizeof(messages[0]);
    char buf[256];

    while (1) {
        if (i % (1 << 30) == 0) {
  10001c:	f7 c3 ff ff ff 3f    	test   $0x3fffffff,%ebx
  100022:	75 3c                	jne    100060 <process_main+0x60>
            int len = snprintf(buf, sizeof(buf), "%s\n",
                               messages[rand() % nmessages]);
  100024:	e8 fe 00 00 00       	call   100127 <rand>
  100029:	89 c1                	mov    %eax,%ecx
  10002b:	f7 e7                	mul    %edi
  10002d:	c1 ea 02             	shr    $0x2,%edx
  100030:	8d 04 52             	lea    (%edx,%edx,2),%eax
  100033:	01 c0                	add    %eax,%eax
  100035:	29 c1                	sub    %eax,%ecx
    unsigned nmessages = sizeof(messages) / sizeof(messages[0]);
    char buf[256];

    while (1) {
        if (i % (1 << 30) == 0) {
            int len = snprintf(buf, sizeof(buf), "%s\n",
  100037:	8b 04 8d 00 10 10 00 	mov    0x101000(,%ecx,4),%eax
  10003e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100042:	c7 44 24 08 20 07 10 	movl   $0x100720,0x8(%esp)
  100049:	00 
  10004a:	c7 44 24 04 00 01 00 	movl   $0x100,0x4(%esp)
  100051:	00 
  100052:	89 34 24             	mov    %esi,(%esp)
  100055:	e8 9b 06 00 00       	call   1006f5 <snprintf>
  10005a:	89 c1                	mov    %eax,%ecx
    return arg0;
}

static inline uint32_t syscall_2_args(int syscall_number, uint32_t arg0,
                                      uint32_t arg1) {
    asm volatile("int %1\n"
  10005c:	89 f0                	mov    %esi,%eax
  10005e:	cd 31                	int    $0x31
                               messages[rand() % nmessages]);
            sys_write(buf, len);
        }
        ++i;
  100060:	83 c3 01             	add    $0x1,%ebx
    }
  100063:	eb b7                	jmp    10001c <process_main+0x1c>

00100065 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  100065:	55                   	push   %ebp
  100066:	89 e5                	mov    %esp,%ebp
  100068:	53                   	push   %ebx
  100069:	8b 45 08             	mov    0x8(%ebp),%eax
  10006c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end)
  10006f:	8b 50 04             	mov    0x4(%eax),%edx
  100072:	3b 50 08             	cmp    0x8(%eax),%edx
  100075:	73 08                	jae    10007f <string_putc+0x1a>
        *sp->s++ = c;
  100077:	8d 5a 01             	lea    0x1(%edx),%ebx
  10007a:	89 58 04             	mov    %ebx,0x4(%eax)
  10007d:	88 0a                	mov    %cl,(%edx)
    (void) color;
}
  10007f:	5b                   	pop    %ebx
  100080:	5d                   	pop    %ebp
  100081:	c3                   	ret    

00100082 <strlen>:
    for (char* p = (char*) v; n > 0; ++p, --n)
        *p = c;
    return v;
}

size_t strlen(const char* s) {
  100082:	55                   	push   %ebp
  100083:	89 e5                	mov    %esp,%ebp
  100085:	8b 55 08             	mov    0x8(%ebp),%edx
    size_t n;
    for (n = 0; *s != '\0'; ++s)
  100088:	80 3a 00             	cmpb   $0x0,(%edx)
  10008b:	74 10                	je     10009d <strlen+0x1b>
  10008d:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  100092:	83 c0 01             	add    $0x1,%eax
    return v;
}

size_t strlen(const char* s) {
    size_t n;
    for (n = 0; *s != '\0'; ++s)
  100095:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100099:	75 f7                	jne    100092 <strlen+0x10>
  10009b:	eb 05                	jmp    1000a2 <strlen+0x20>
  10009d:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
    return n;
}
  1000a2:	5d                   	pop    %ebp
  1000a3:	c3                   	ret    
  1000a4:	66 90                	xchg   %ax,%ax
  1000a6:	66 90                	xchg   %ax,%ax
  1000a8:	66 90                	xchg   %ax,%ax
  1000aa:	66 90                	xchg   %ax,%ax
  1000ac:	66 90                	xchg   %ax,%ax
  1000ae:	66 90                	xchg   %ax,%ax

001000b0 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1000b0:	55                   	push   %ebp
  1000b1:	89 e5                	mov    %esp,%ebp
  1000b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1000b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s)
  1000b9:	85 d2                	test   %edx,%edx
  1000bb:	74 19                	je     1000d6 <strnlen+0x26>
  1000bd:	80 39 00             	cmpb   $0x0,(%ecx)
  1000c0:	74 1b                	je     1000dd <strnlen+0x2d>
  1000c2:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1000c7:	83 c0 01             	add    $0x1,%eax
    return n;
}

size_t strnlen(const char* s, size_t maxlen) {
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s)
  1000ca:	39 d0                	cmp    %edx,%eax
  1000cc:	74 14                	je     1000e2 <strnlen+0x32>
  1000ce:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1000d2:	75 f3                	jne    1000c7 <strnlen+0x17>
  1000d4:	eb 0c                	jmp    1000e2 <strnlen+0x32>
  1000d6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000db:	eb 05                	jmp    1000e2 <strnlen+0x32>
  1000dd:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
    return n;
}
  1000e2:	5d                   	pop    %ebp
  1000e3:	c3                   	ret    
  1000e4:	66 90                	xchg   %ax,%ax
  1000e6:	66 90                	xchg   %ax,%ax
  1000e8:	66 90                	xchg   %ax,%ax
  1000ea:	66 90                	xchg   %ax,%ax
  1000ec:	66 90                	xchg   %ax,%ax
  1000ee:	66 90                	xchg   %ax,%ax

001000f0 <strchr>:
        ++a, ++b;
    return ((unsigned char) *a > (unsigned char) *b)
        - ((unsigned char) *a < (unsigned char) *b);
}

char* strchr(const char* s, int c) {
  1000f0:	55                   	push   %ebp
  1000f1:	89 e5                	mov    %esp,%ebp
  1000f3:	53                   	push   %ebx
  1000f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1000f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*s && *s != (char) c)
  1000fa:	0f b6 11             	movzbl (%ecx),%edx
  1000fd:	84 d2                	test   %dl,%dl
  1000ff:	74 16                	je     100117 <strchr+0x27>
  100101:	89 d8                	mov    %ebx,%eax
  100103:	38 da                	cmp    %bl,%dl
  100105:	74 1b                	je     100122 <strchr+0x32>
        ++s;
  100107:	83 c1 01             	add    $0x1,%ecx
    return ((unsigned char) *a > (unsigned char) *b)
        - ((unsigned char) *a < (unsigned char) *b);
}

char* strchr(const char* s, int c) {
    while (*s && *s != (char) c)
  10010a:	0f b6 11             	movzbl (%ecx),%edx
  10010d:	84 d2                	test   %dl,%dl
  10010f:	74 06                	je     100117 <strchr+0x27>
  100111:	38 c2                	cmp    %al,%dl
  100113:	75 f2                	jne    100107 <strchr+0x17>
  100115:	eb 0b                	jmp    100122 <strchr+0x32>
        ++s;
    if (*s == (char) c)
        return (char*) s;
    else
        return NULL;
  100117:	b8 00 00 00 00       	mov    $0x0,%eax
}

char* strchr(const char* s, int c) {
    while (*s && *s != (char) c)
        ++s;
    if (*s == (char) c)
  10011c:	38 da                	cmp    %bl,%dl
  10011e:	66 90                	xchg   %ax,%ax
  100120:	75 02                	jne    100124 <strchr+0x34>
        return (char*) s;
  100122:	89 c8                	mov    %ecx,%eax
    else
        return NULL;
}
  100124:	5b                   	pop    %ebx
  100125:	5d                   	pop    %ebp
  100126:	c3                   	ret    

00100127 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100127:	55                   	push   %ebp
  100128:	89 e5                	mov    %esp,%ebp
    if (!rand_seed_set)
  10012a:	83 3d 1c 10 10 00 00 	cmpl   $0x0,0x10101c
  100131:	75 14                	jne    100147 <rand+0x20>
    rand_seed = rand_seed * 1664525U + 1013904223U;
    return rand_seed & RAND_MAX;
}

void srand(unsigned seed) {
    rand_seed = seed;
  100133:	c7 05 18 10 10 00 9e 	movl   $0x30d4879e,0x101018
  10013a:	87 d4 30 
    rand_seed_set = 1;
  10013d:	c7 05 1c 10 10 00 01 	movl   $0x1,0x10101c
  100144:	00 00 00 
static unsigned rand_seed;

int rand(void) {
    if (!rand_seed_set)
        srand(819234718U);
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100147:	69 05 18 10 10 00 0d 	imul   $0x19660d,0x101018,%eax
  10014e:	66 19 00 
  100151:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100156:	a3 18 10 10 00       	mov    %eax,0x101018
    return rand_seed & RAND_MAX;
  10015b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100160:	5d                   	pop    %ebp
  100161:	c3                   	ret    
  100162:	66 90                	xchg   %ax,%ax
  100164:	66 90                	xchg   %ax,%ax
  100166:	66 90                	xchg   %ax,%ax
  100168:	66 90                	xchg   %ax,%ax
  10016a:	66 90                	xchg   %ax,%ax
  10016c:	66 90                	xchg   %ax,%ax
  10016e:	66 90                	xchg   %ax,%ax

00100170 <printer_vprintf>:
#define FLAG_LEFTJUSTIFY        (1<<2)
#define FLAG_SPACEPOSITIVE      (1<<3)
#define FLAG_PLUSPOSITIVE       (1<<4)
static const char flag_chars[] = "#0- +";

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100170:	55                   	push   %ebp
  100171:	89 e5                	mov    %esp,%ebp
  100173:	57                   	push   %edi
  100174:	56                   	push   %esi
  100175:	53                   	push   %ebx
  100176:	83 ec 6c             	sub    $0x6c,%esp
  100179:	8b 7d 08             	mov    0x8(%ebp),%edi
  10017c:	8b 75 10             	mov    0x10(%ebp),%esi
  10017f:	8b 45 14             	mov    0x14(%ebp),%eax
  100182:	89 45 b0             	mov    %eax,-0x50(%ebp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100185:	0f b6 06             	movzbl (%esi),%eax
  100188:	84 c0                	test   %al,%al
  10018a:	0f 84 09 05 00 00    	je     100699 <printer_vprintf+0x529>
        base = -base;
    }

    *--numbuf_end = '\0';
    do {
        *--numbuf_end = digits[val % base];
  100190:	89 f3                	mov    %esi,%ebx
  100192:	89 fe                	mov    %edi,%esi
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
        if (*format != '%') {
  100194:	3c 25                	cmp    $0x25,%al
  100196:	74 1a                	je     1001b2 <printer_vprintf+0x42>
            p->putc(p, *format, color);
  100198:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10019b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10019f:	0f b6 c0             	movzbl %al,%eax
  1001a2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a6:	89 34 24             	mov    %esi,(%esp)
  1001a9:	ff 16                	call   *(%esi)
            continue;
  1001ab:	89 df                	mov    %ebx,%edi
  1001ad:	e9 03 04 00 00       	jmp    1005b5 <printer_vprintf+0x445>
        }

        // process flags
        int flags = 0;
        for (++format; *format; ++format) {
  1001b2:	8d 7b 01             	lea    0x1(%ebx),%edi
  1001b5:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
  1001b9:	84 db                	test   %bl,%bl
  1001bb:	0f 84 08 04 00 00    	je     1005c9 <printer_vprintf+0x459>
            p->putc(p, *format, color);
            continue;
        }

        // process flags
        int flags = 0;
  1001c1:	b8 00 00 00 00       	mov    $0x0,%eax
  1001c6:	89 75 08             	mov    %esi,0x8(%ebp)
  1001c9:	89 c6                	mov    %eax,%esi
        for (++format; *format; ++format) {
            const char* flagc = strchr(flag_chars, *format);
  1001cb:	0f be c3             	movsbl %bl,%eax
  1001ce:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001d2:	c7 04 24 62 09 10 00 	movl   $0x100962,(%esp)
  1001d9:	e8 12 ff ff ff       	call   1000f0 <strchr>
            if (flagc)
  1001de:	85 c0                	test   %eax,%eax
  1001e0:	74 25                	je     100207 <printer_vprintf+0x97>
                flags |= 1 << (flagc - flag_chars);
  1001e2:	2d 62 09 10 00       	sub    $0x100962,%eax
  1001e7:	89 c1                	mov    %eax,%ecx
  1001e9:	b8 01 00 00 00       	mov    $0x1,%eax
  1001ee:	d3 e0                	shl    %cl,%eax
  1001f0:	09 c6                	or     %eax,%esi
            continue;
        }

        // process flags
        int flags = 0;
        for (++format; *format; ++format) {
  1001f2:	83 c7 01             	add    $0x1,%edi
  1001f5:	0f b6 1f             	movzbl (%edi),%ebx
  1001f8:	84 db                	test   %bl,%bl
  1001fa:	75 cf                	jne    1001cb <printer_vprintf+0x5b>
  1001fc:	89 75 c4             	mov    %esi,-0x3c(%ebp)
  1001ff:	8b 75 08             	mov    0x8(%ebp),%esi
  100202:	e9 c9 03 00 00       	jmp    1005d0 <printer_vprintf+0x460>
  100207:	89 75 c4             	mov    %esi,-0x3c(%ebp)
  10020a:	8b 75 08             	mov    0x8(%ebp),%esi
                break;
        }

        // process width
        int width = -1;
        if (*format >= '1' && *format <= '9') {
  10020d:	8d 43 cf             	lea    -0x31(%ebx),%eax
  100210:	3c 08                	cmp    $0x8,%al
  100212:	77 2d                	ja     100241 <printer_vprintf+0xd1>
            for (width = 0; *format >= '0' && *format <= '9'; )
  100214:	0f b6 07             	movzbl (%edi),%eax
  100217:	8d 50 d0             	lea    -0x30(%eax),%edx
  10021a:	80 fa 09             	cmp    $0x9,%dl
  10021d:	77 41                	ja     100260 <printer_vprintf+0xf0>
  10021f:	ba 00 00 00 00       	mov    $0x0,%edx
                width = 10 * width + *format++ - '0';
  100224:	83 c7 01             	add    $0x1,%edi
  100227:	8d 14 92             	lea    (%edx,%edx,4),%edx
  10022a:	0f be c0             	movsbl %al,%eax
  10022d:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
        }

        // process width
        int width = -1;
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
  100231:	0f b6 07             	movzbl (%edi),%eax
  100234:	8d 48 d0             	lea    -0x30(%eax),%ecx
  100237:	80 f9 09             	cmp    $0x9,%cl
  10023a:	76 e8                	jbe    100224 <printer_vprintf+0xb4>
  10023c:	89 55 c0             	mov    %edx,-0x40(%ebp)
  10023f:	eb 26                	jmp    100267 <printer_vprintf+0xf7>
            else
                break;
        }

        // process width
        int width = -1;
  100241:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
                width = 10 * width + *format++ - '0';
        } else if (*format == '*') {
  100248:	80 fb 2a             	cmp    $0x2a,%bl
  10024b:	75 1a                	jne    100267 <printer_vprintf+0xf7>
            width = va_arg(val, int);
  10024d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100250:	8b 08                	mov    (%eax),%ecx
  100252:	89 4d c0             	mov    %ecx,-0x40(%ebp)
            ++format;
  100255:	8d 7f 01             	lea    0x1(%edi),%edi
        int width = -1;
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
                width = 10 * width + *format++ - '0';
        } else if (*format == '*') {
            width = va_arg(val, int);
  100258:	8d 40 04             	lea    0x4(%eax),%eax
  10025b:	89 45 b0             	mov    %eax,-0x50(%ebp)
  10025e:	eb 07                	jmp    100267 <printer_vprintf+0xf7>
        }

        // process width
        int width = -1;
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
  100260:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
            width = va_arg(val, int);
            ++format;
        }

        // process precision
        int precision = -1;
  100267:	c7 45 b8 ff ff ff ff 	movl   $0xffffffff,-0x48(%ebp)
        if (*format == '.') {
  10026e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100271:	75 58                	jne    1002cb <printer_vprintf+0x15b>
            ++format;
  100273:	8d 4f 01             	lea    0x1(%edi),%ecx
            if (*format >= '0' && *format <= '9') {
  100276:	0f b6 57 01          	movzbl 0x1(%edi),%edx
  10027a:	8d 42 d0             	lea    -0x30(%edx),%eax
  10027d:	3c 09                	cmp    $0x9,%al
  10027f:	77 21                	ja     1002a2 <printer_vprintf+0x132>
  100281:	89 cf                	mov    %ecx,%edi
  100283:	b8 00 00 00 00       	mov    $0x0,%eax
                for (precision = 0; *format >= '0' && *format <= '9'; )
                    precision = 10 * precision + *format++ - '0';
  100288:	83 c7 01             	add    $0x1,%edi
  10028b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10028e:	0f be d2             	movsbl %dl,%edx
  100291:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
        // process precision
        int precision = -1;
        if (*format == '.') {
            ++format;
            if (*format >= '0' && *format <= '9') {
                for (precision = 0; *format >= '0' && *format <= '9'; )
  100295:	0f b6 17             	movzbl (%edi),%edx
  100298:	8d 4a d0             	lea    -0x30(%edx),%ecx
  10029b:	80 f9 09             	cmp    $0x9,%cl
  10029e:	76 e8                	jbe    100288 <printer_vprintf+0x118>
  1002a0:	eb 1c                	jmp    1002be <printer_vprintf+0x14e>
                    precision = 10 * precision + *format++ - '0';
            } else if (*format == '*') {
  1002a2:	80 fa 2a             	cmp    $0x2a,%dl
  1002a5:	75 10                	jne    1002b7 <printer_vprintf+0x147>
                precision = va_arg(val, int);
  1002a7:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  1002aa:	8b 01                	mov    (%ecx),%eax
                ++format;
  1002ac:	83 c7 02             	add    $0x2,%edi
            ++format;
            if (*format >= '0' && *format <= '9') {
                for (precision = 0; *format >= '0' && *format <= '9'; )
                    precision = 10 * precision + *format++ - '0';
            } else if (*format == '*') {
                precision = va_arg(val, int);
  1002af:	8d 49 04             	lea    0x4(%ecx),%ecx
  1002b2:	89 4d b0             	mov    %ecx,-0x50(%ebp)
  1002b5:	eb 07                	jmp    1002be <printer_vprintf+0x14e>
        }

        // process precision
        int precision = -1;
        if (*format == '.') {
            ++format;
  1002b7:	89 cf                	mov    %ecx,%edi
            width = va_arg(val, int);
            ++format;
        }

        // process precision
        int precision = -1;
  1002b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1002be:	85 c0                	test   %eax,%eax
  1002c0:	ba 00 00 00 00       	mov    $0x0,%edx
  1002c5:	0f 49 d0             	cmovns %eax,%edx
  1002c8:	89 55 b8             	mov    %edx,-0x48(%ebp)
        // process main conversion character
        int negative = 0;
        int numeric = 0;
        int base = 10;
        char* data;
        switch (*format) {
  1002cb:	0f b6 17             	movzbl (%edi),%edx
  1002ce:	8d 42 bd             	lea    -0x43(%edx),%eax
  1002d1:	3c 35                	cmp    $0x35,%al
  1002d3:	0f 87 15 01 00 00    	ja     1003ee <printer_vprintf+0x27e>
  1002d9:	0f b6 c0             	movzbl %al,%eax
  1002dc:	ff 24 85 68 08 10 00 	jmp    *0x100868(,%eax,4)
        case 'd': {
            int x = va_arg(val, int);
  1002e3:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1002e6:	8d 48 04             	lea    0x4(%eax),%ecx
  1002e9:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  1002ec:	8b 00                	mov    (%eax),%eax
  1002ee:	89 c1                	mov    %eax,%ecx
  1002f0:	89 45 b4             	mov    %eax,-0x4c(%ebp)
            data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10);
  1002f3:	c1 f8 1f             	sar    $0x1f,%eax
  1002f6:	31 c1                	xor    %eax,%ecx
  1002f8:	29 c1                	sub    %eax,%ecx
    if (base < 0) {
        digits = lower_digits;
        base = -base;
    }

    *--numbuf_end = '\0';
  1002fa:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  1002fe:	8d 5d e7             	lea    -0x19(%ebp),%ebx
    do {
        *--numbuf_end = digits[val % base];
  100301:	83 eb 01             	sub    $0x1,%ebx
  100304:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
  100309:	f7 e1                	mul    %ecx
  10030b:	c1 ea 03             	shr    $0x3,%edx
  10030e:	8d 04 92             	lea    (%edx,%edx,4),%eax
  100311:	01 c0                	add    %eax,%eax
  100313:	29 c1                	sub    %eax,%ecx
  100315:	0f b6 81 51 09 10 00 	movzbl 0x100951(%ecx),%eax
  10031c:	88 03                	mov    %al,(%ebx)
        val /= base;
  10031e:	89 d1                	mov    %edx,%ecx
    } while (val != 0);
  100320:	85 d2                	test   %edx,%edx
  100322:	75 dd                	jne    100301 <printer_vprintf+0x191>
        switch (*format) {
        case 'd': {
            int x = va_arg(val, int);
            data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10);
            if (x < 0)
                negative = 1;
  100324:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  100327:	c1 e8 1f             	shr    $0x1f,%eax
  10032a:	89 45 ac             	mov    %eax,-0x54(%ebp)
        int numeric = 0;
        int base = 10;
        char* data;
        switch (*format) {
        case 'd': {
            int x = va_arg(val, int);
  10032d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  100330:	89 45 b0             	mov    %eax,-0x50(%ebp)
  100333:	e9 04 03 00 00       	jmp    10063c <printer_vprintf+0x4cc>
            numeric = 1;
            break;
        }
        case 'u':
        print_unsigned: {
            unsigned x = va_arg(val, unsigned);
  100338:	8b 45 b0             	mov    -0x50(%ebp),%eax
  10033b:	8b 10                	mov    (%eax),%edx
  10033d:	8d 40 04             	lea    0x4(%eax),%eax
  100340:	89 45 b0             	mov    %eax,-0x50(%ebp)

static char* fill_numbuf(char* numbuf_end, uint32_t val, int base) {
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100343:	b9 51 09 10 00       	mov    $0x100951,%ecx
        }

        // process main conversion character
        int negative = 0;
        int numeric = 0;
        int base = 10;
  100348:	b8 0a 00 00 00       	mov    $0xa,%eax
    if (base < 0) {
        digits = lower_digits;
        base = -base;
    }

    *--numbuf_end = '\0';
  10034d:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  100351:	8d 5d e7             	lea    -0x19(%ebp),%ebx
  100354:	89 75 08             	mov    %esi,0x8(%ebp)
  100357:	89 c6                	mov    %eax,%esi
    do {
        *--numbuf_end = digits[val % base];
  100359:	83 eb 01             	sub    $0x1,%ebx
  10035c:	89 d0                	mov    %edx,%eax
  10035e:	ba 00 00 00 00       	mov    $0x0,%edx
  100363:	f7 f6                	div    %esi
  100365:	0f b6 14 11          	movzbl (%ecx,%edx,1),%edx
  100369:	88 13                	mov    %dl,(%ebx)
        val /= base;
  10036b:	89 c2                	mov    %eax,%edx
    } while (val != 0);
  10036d:	85 c0                	test   %eax,%eax
  10036f:	75 e8                	jne    100359 <printer_vprintf+0x1e9>
  100371:	e9 bc 02 00 00       	jmp    100632 <printer_vprintf+0x4c2>
            goto print_unsigned;
        case 'X':
            base = 16;
            goto print_unsigned;
        case 'p': {
            void* x = va_arg(val, void*);
  100376:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100379:	8d 48 04             	lea    0x4(%eax),%ecx
  10037c:	89 4d bc             	mov    %ecx,-0x44(%ebp)
            data = fill_numbuf(numbuf + NUMBUFSIZ, (uintptr_t) x, -16);
  10037f:	8b 10                	mov    (%eax),%edx
    if (base < 0) {
        digits = lower_digits;
        base = -base;
    }

    *--numbuf_end = '\0';
  100381:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  100385:	8d 45 e7             	lea    -0x19(%ebp),%eax
    do {
        *--numbuf_end = digits[val % base];
  100388:	83 e8 01             	sub    $0x1,%eax
  10038b:	89 d1                	mov    %edx,%ecx
  10038d:	83 e1 0f             	and    $0xf,%ecx
  100390:	0f b6 89 40 09 10 00 	movzbl 0x100940(%ecx),%ecx
  100397:	88 08                	mov    %cl,(%eax)
        val /= base;
  100399:	89 d1                	mov    %edx,%ecx
  10039b:	c1 e9 04             	shr    $0x4,%ecx
  10039e:	89 ca                	mov    %ecx,%edx
    } while (val != 0);
  1003a0:	85 c9                	test   %ecx,%ecx
  1003a2:	75 e4                	jne    100388 <printer_vprintf+0x218>
            base = 16;
            goto print_unsigned;
        case 'p': {
            void* x = va_arg(val, void*);
            data = fill_numbuf(numbuf + NUMBUFSIZ, (uintptr_t) x, -16);
            data[-1] = 'x';
  1003a4:	c6 40 ff 78          	movb   $0x78,-0x1(%eax)
            data[-2] = '0';
  1003a8:	c6 40 fe 30          	movb   $0x30,-0x2(%eax)
            data -= 2;
  1003ac:	8d 58 fe             	lea    -0x2(%eax),%ebx
            goto print_unsigned;
        case 'X':
            base = 16;
            goto print_unsigned;
        case 'p': {
            void* x = va_arg(val, void*);
  1003af:	8b 45 bc             	mov    -0x44(%ebp),%eax
  1003b2:	89 45 b0             	mov    %eax,-0x50(%ebp)
            data = fill_numbuf(numbuf + NUMBUFSIZ, (uintptr_t) x, -16);
            data[-1] = 'x';
            data[-2] = '0';
            data -= 2;
            break;
  1003b5:	eb 44                	jmp    1003fb <printer_vprintf+0x28b>
        }
        case 's':
            data = va_arg(val, char*);
  1003b7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1003ba:	8b 18                	mov    (%eax),%ebx
  1003bc:	8d 40 04             	lea    0x4(%eax),%eax
  1003bf:	89 45 b0             	mov    %eax,-0x50(%ebp)
            break;
  1003c2:	eb 37                	jmp    1003fb <printer_vprintf+0x28b>
        case 'C':
            color = va_arg(val, int);
  1003c4:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1003c7:	8b 08                	mov    (%eax),%ecx
  1003c9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  1003cc:	8d 40 04             	lea    0x4(%eax),%eax
  1003cf:	89 45 b0             	mov    %eax,-0x50(%ebp)
            goto done;
  1003d2:	e9 de 01 00 00       	jmp    1005b5 <printer_vprintf+0x445>
        case 'c':
            data = numbuf;
            numbuf[0] = va_arg(val, int);
  1003d7:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  1003da:	8b 01                	mov    (%ecx),%eax
  1003dc:	88 45 d0             	mov    %al,-0x30(%ebp)
            numbuf[1] = '\0';
  1003df:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
        case 'C':
            color = va_arg(val, int);
            goto done;
        case 'c':
            data = numbuf;
            numbuf[0] = va_arg(val, int);
  1003e3:	8d 41 04             	lea    0x4(%ecx),%eax
  1003e6:	89 45 b0             	mov    %eax,-0x50(%ebp)
            break;
        case 'C':
            color = va_arg(val, int);
            goto done;
        case 'c':
            data = numbuf;
  1003e9:	8d 5d d0             	lea    -0x30(%ebp),%ebx
            numbuf[0] = va_arg(val, int);
            numbuf[1] = '\0';
            break;
  1003ec:	eb 0d                	jmp    1003fb <printer_vprintf+0x28b>
        normal:
        default:
            data = numbuf;
            numbuf[0] = (*format ? *format : '%');
  1003ee:	84 d2                	test   %dl,%dl
  1003f0:	0f 85 2d 02 00 00    	jne    100623 <printer_vprintf+0x4b3>
  1003f6:	e9 15 02 00 00       	jmp    100610 <printer_vprintf+0x4a0>
                format--;
            break;
        }

        int len;
        if (precision >= 0 && !numeric)
  1003fb:	8b 4d b8             	mov    -0x48(%ebp),%ecx
  1003fe:	89 c8                	mov    %ecx,%eax
  100400:	f7 d0                	not    %eax
  100402:	c1 e8 1f             	shr    $0x1f,%eax
  100405:	88 45 98             	mov    %al,-0x68(%ebp)
  100408:	84 c0                	test   %al,%al
  10040a:	74 16                	je     100422 <printer_vprintf+0x2b2>
            len = strnlen(data, precision);
  10040c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100410:	89 1c 24             	mov    %ebx,(%esp)
  100413:	e8 98 fc ff ff       	call   1000b0 <strnlen>
  100418:	89 45 bc             	mov    %eax,-0x44(%ebp)
        else
            len = strlen(data);
        if (numeric && negative)
  10041b:	ba 00 00 00 00       	mov    $0x0,%edx
  100420:	eb 27                	jmp    100449 <printer_vprintf+0x2d9>
  100422:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
  100429:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)

        int len;
        if (precision >= 0 && !numeric)
            len = strnlen(data, precision);
        else
            len = strlen(data);
  100430:	89 1c 24             	mov    %ebx,(%esp)
  100433:	e8 4a fc ff ff       	call   100082 <strlen>
  100438:	89 45 bc             	mov    %eax,-0x44(%ebp)
        if (numeric && negative)
  10043b:	0f b6 55 b4          	movzbl -0x4c(%ebp),%edx
  10043f:	83 7d ac 00          	cmpl   $0x0,-0x54(%ebp)
  100443:	74 04                	je     100449 <printer_vprintf+0x2d9>
  100445:	84 d2                	test   %dl,%dl
  100447:	75 24                	jne    10046d <printer_vprintf+0x2fd>
            negative = '-';
        else if (flags & FLAG_PLUSPOSITIVE)
            negative = '+';
  100449:	c7 45 b4 2b 00 00 00 	movl   $0x2b,-0x4c(%ebp)
            len = strnlen(data, precision);
        else
            len = strlen(data);
        if (numeric && negative)
            negative = '-';
        else if (flags & FLAG_PLUSPOSITIVE)
  100450:	f6 45 c4 10          	testb  $0x10,-0x3c(%ebp)
  100454:	75 1e                	jne    100474 <printer_vprintf+0x304>
            negative = '+';
        else if (flags & FLAG_SPACEPOSITIVE)
  100456:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  100459:	83 e0 08             	and    $0x8,%eax
            negative = ' ';
  10045c:	83 f8 01             	cmp    $0x1,%eax
  10045f:	19 c0                	sbb    %eax,%eax
  100461:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  100464:	f7 55 b4             	notl   -0x4c(%ebp)
  100467:	83 65 b4 20          	andl   $0x20,-0x4c(%ebp)
  10046b:	eb 07                	jmp    100474 <printer_vprintf+0x304>
        if (precision >= 0 && !numeric)
            len = strnlen(data, precision);
        else
            len = strlen(data);
        if (numeric && negative)
            negative = '-';
  10046d:	c7 45 b4 2d 00 00 00 	movl   $0x2d,-0x4c(%ebp)
        else if (flags & FLAG_SPACEPOSITIVE)
            negative = ' ';
        else
            negative = 0;
        int zeros;
        if (numeric && precision >= 0)
  100474:	84 d2                	test   %dl,%dl
  100476:	74 1f                	je     100497 <printer_vprintf+0x327>
  100478:	80 7d 98 00          	cmpb   $0x0,-0x68(%ebp)
  10047c:	74 19                	je     100497 <printer_vprintf+0x327>
            zeros = precision > len ? precision - len : 0;
  10047e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  100481:	89 c2                	mov    %eax,%edx
  100483:	8b 4d bc             	mov    -0x44(%ebp),%ecx
  100486:	29 ca                	sub    %ecx,%edx
  100488:	39 c8                	cmp    %ecx,%eax
  10048a:	b8 00 00 00 00       	mov    $0x0,%eax
  10048f:	0f 4f c2             	cmovg  %edx,%eax
  100492:	89 45 b8             	mov    %eax,-0x48(%ebp)
  100495:	eb 35                	jmp    1004cc <printer_vprintf+0x35c>
        else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100497:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  10049a:	83 e0 06             	and    $0x6,%eax
                 && numeric && len + !!negative < width)
            zeros = width - len - !!negative;
        else
            zeros = 0;
  10049d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
        else
            negative = 0;
        int zeros;
        if (numeric && precision >= 0)
            zeros = precision > len ? precision - len : 0;
        else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1004a4:	83 f8 02             	cmp    $0x2,%eax
  1004a7:	75 23                	jne    1004cc <printer_vprintf+0x35c>
                 && numeric && len + !!negative < width)
  1004a9:	84 d2                	test   %dl,%dl
  1004ab:	74 1f                	je     1004cc <printer_vprintf+0x35c>
  1004ad:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  1004b1:	0f 95 c0             	setne  %al
  1004b4:	0f b6 c0             	movzbl %al,%eax
  1004b7:	8b 4d bc             	mov    -0x44(%ebp),%ecx
  1004ba:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1004bd:	39 55 c0             	cmp    %edx,-0x40(%ebp)
  1004c0:	7e 0a                	jle    1004cc <printer_vprintf+0x35c>
            zeros = width - len - !!negative;
  1004c2:	8b 55 c0             	mov    -0x40(%ebp),%edx
  1004c5:	29 ca                	sub    %ecx,%edx
  1004c7:	29 c2                	sub    %eax,%edx
  1004c9:	89 55 b8             	mov    %edx,-0x48(%ebp)
        else
            zeros = 0;
        width -= len + zeros + !!negative;
  1004cc:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  1004d0:	0f 95 c0             	setne  %al
  1004d3:	88 45 98             	mov    %al,-0x68(%ebp)
  1004d6:	8b 55 bc             	mov    -0x44(%ebp),%edx
  1004d9:	03 55 b8             	add    -0x48(%ebp),%edx
  1004dc:	0f b6 c0             	movzbl %al,%eax
  1004df:	01 d0                	add    %edx,%eax
  1004e1:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  1004e4:	29 c1                	sub    %eax,%ecx
  1004e6:	89 4d c0             	mov    %ecx,-0x40(%ebp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1004e9:	f6 45 c4 04          	testb  $0x4,-0x3c(%ebp)
  1004ed:	75 2b                	jne    10051a <printer_vprintf+0x3aa>
  1004ef:	85 c9                	test   %ecx,%ecx
  1004f1:	0f 8f 75 01 00 00    	jg     10066c <printer_vprintf+0x4fc>
  1004f7:	eb 21                	jmp    10051a <printer_vprintf+0x3aa>
  1004f9:	85 db                	test   %ebx,%ebx
  1004fb:	90                   	nop
  1004fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100500:	0f 85 4d 01 00 00    	jne    100653 <printer_vprintf+0x4e3>
  100506:	8b 7d ac             	mov    -0x54(%ebp),%edi
  100509:	8b 5d a8             	mov    -0x58(%ebp),%ebx
  10050c:	b8 01 00 00 00       	mov    $0x1,%eax
  100511:	2b 45 c0             	sub    -0x40(%ebp),%eax
  100514:	03 45 c4             	add    -0x3c(%ebp),%eax
  100517:	89 45 c0             	mov    %eax,-0x40(%ebp)
            p->putc(p, ' ', color);
        if (negative)
  10051a:	80 7d 98 00          	cmpb   $0x0,-0x68(%ebp)
  10051e:	74 14                	je     100534 <printer_vprintf+0x3c4>
            p->putc(p, negative, color);
  100520:	8b 45 0c             	mov    0xc(%ebp),%eax
  100523:	89 44 24 08          	mov    %eax,0x8(%esp)
  100527:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
  10052b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10052f:	89 34 24             	mov    %esi,(%esp)
  100532:	ff 16                	call   *(%esi)
        for (; zeros > 0; --zeros)
  100534:	8b 45 b8             	mov    -0x48(%ebp),%eax
  100537:	85 c0                	test   %eax,%eax
  100539:	7e 27                	jle    100562 <printer_vprintf+0x3f2>
  10053b:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  10053e:	89 5d b8             	mov    %ebx,-0x48(%ebp)
  100541:	89 c3                	mov    %eax,%ebx
  100543:	8b 7d 0c             	mov    0xc(%ebp),%edi
            p->putc(p, '0', color);
  100546:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10054a:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
  100551:	00 
  100552:	89 34 24             	mov    %esi,(%esp)
  100555:	ff 16                	call   *(%esi)
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
            p->putc(p, ' ', color);
        if (negative)
            p->putc(p, negative, color);
        for (; zeros > 0; --zeros)
  100557:	83 eb 01             	sub    $0x1,%ebx
  10055a:	75 ea                	jne    100546 <printer_vprintf+0x3d6>
  10055c:	8b 7d c4             	mov    -0x3c(%ebp),%edi
  10055f:	8b 5d b8             	mov    -0x48(%ebp),%ebx
            p->putc(p, '0', color);
        for (; len > 0; ++data, --len)
  100562:	8b 45 bc             	mov    -0x44(%ebp),%eax
  100565:	85 c0                	test   %eax,%eax
  100567:	7e 26                	jle    10058f <printer_vprintf+0x41f>
  100569:	01 d8                	add    %ebx,%eax
  10056b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  10056e:	89 7d bc             	mov    %edi,-0x44(%ebp)
  100571:	8b 7d 0c             	mov    0xc(%ebp),%edi
            p->putc(p, *data, color);
  100574:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100578:	0f b6 03             	movzbl (%ebx),%eax
  10057b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10057f:	89 34 24             	mov    %esi,(%esp)
  100582:	ff 16                	call   *(%esi)
            p->putc(p, ' ', color);
        if (negative)
            p->putc(p, negative, color);
        for (; zeros > 0; --zeros)
            p->putc(p, '0', color);
        for (; len > 0; ++data, --len)
  100584:	83 c3 01             	add    $0x1,%ebx
  100587:	3b 5d c4             	cmp    -0x3c(%ebp),%ebx
  10058a:	75 e8                	jne    100574 <printer_vprintf+0x404>
  10058c:	8b 7d bc             	mov    -0x44(%ebp),%edi
            p->putc(p, *data, color);
        for (; width > 0; --width)
  10058f:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  100592:	85 db                	test   %ebx,%ebx
  100594:	7e 1f                	jle    1005b5 <printer_vprintf+0x445>
  100596:	89 7d c4             	mov    %edi,-0x3c(%ebp)
  100599:	8b 7d 0c             	mov    0xc(%ebp),%edi
            p->putc(p, ' ', color);
  10059c:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1005a0:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  1005a7:	00 
  1005a8:	89 34 24             	mov    %esi,(%esp)
  1005ab:	ff 16                	call   *(%esi)
            p->putc(p, negative, color);
        for (; zeros > 0; --zeros)
            p->putc(p, '0', color);
        for (; len > 0; ++data, --len)
            p->putc(p, *data, color);
        for (; width > 0; --width)
  1005ad:	83 eb 01             	sub    $0x1,%ebx
  1005b0:	75 ea                	jne    10059c <printer_vprintf+0x42c>
  1005b2:	8b 7d c4             	mov    -0x3c(%ebp),%edi

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1005b5:	8d 5f 01             	lea    0x1(%edi),%ebx
  1005b8:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  1005bc:	84 c0                	test   %al,%al
  1005be:	0f 85 d0 fb ff ff    	jne    100194 <printer_vprintf+0x24>
  1005c4:	e9 d0 00 00 00       	jmp    100699 <printer_vprintf+0x529>
            p->putc(p, *format, color);
            continue;
        }

        // process flags
        int flags = 0;
  1005c9:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
            else
                break;
        }

        // process width
        int width = -1;
  1005d0:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
  1005d7:	e9 8b fc ff ff       	jmp    100267 <printer_vprintf+0xf7>
            numeric = 1;
            break;
        }
        case 'u':
        print_unsigned: {
            unsigned x = va_arg(val, unsigned);
  1005dc:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1005df:	8b 10                	mov    (%eax),%edx
  1005e1:	8d 40 04             	lea    0x4(%eax),%eax
  1005e4:	89 45 b0             	mov    %eax,-0x50(%ebp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
    if (base < 0) {
        digits = lower_digits;
  1005e7:	b9 40 09 10 00       	mov    $0x100940,%ecx
        base = -base;
  1005ec:	b8 10 00 00 00       	mov    $0x10,%eax
  1005f1:	e9 57 fd ff ff       	jmp    10034d <printer_vprintf+0x1dd>
            numeric = 1;
            break;
        }
        case 'u':
        print_unsigned: {
            unsigned x = va_arg(val, unsigned);
  1005f6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1005f9:	8b 10                	mov    (%eax),%edx
  1005fb:	8d 40 04             	lea    0x4(%eax),%eax
  1005fe:	89 45 b0             	mov    %eax,-0x50(%ebp)

static char* fill_numbuf(char* numbuf_end, uint32_t val, int base) {
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100601:	b9 51 09 10 00       	mov    $0x100951,%ecx
        }
        case 'x':
            base = -16;
            goto print_unsigned;
        case 'X':
            base = 16;
  100606:	b8 10 00 00 00       	mov    $0x10,%eax
  10060b:	e9 3d fd ff ff       	jmp    10034d <printer_vprintf+0x1dd>
            numbuf[1] = '\0';
            break;
        normal:
        default:
            data = numbuf;
            numbuf[0] = (*format ? *format : '%');
  100610:	c6 45 d0 25          	movb   $0x25,-0x30(%ebp)
            numbuf[1] = '\0';
  100614:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
            if (!*format)
                format--;
  100618:	83 ef 01             	sub    $0x1,%edi
            numbuf[0] = va_arg(val, int);
            numbuf[1] = '\0';
            break;
        normal:
        default:
            data = numbuf;
  10061b:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  10061e:	e9 d8 fd ff ff       	jmp    1003fb <printer_vprintf+0x28b>
            numbuf[0] = (*format ? *format : '%');
  100623:	88 55 d0             	mov    %dl,-0x30(%ebp)
            numbuf[1] = '\0';
  100626:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
            numbuf[0] = va_arg(val, int);
            numbuf[1] = '\0';
            break;
        normal:
        default:
            data = numbuf;
  10062a:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  10062d:	e9 c9 fd ff ff       	jmp    1003fb <printer_vprintf+0x28b>
  100632:	8b 75 08             	mov    0x8(%ebp),%esi
            if (precision < 0)
                precision = 0;
        }

        // process main conversion character
        int negative = 0;
  100635:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)
                format--;
            break;
        }

        int len;
        if (precision >= 0 && !numeric)
  10063c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  10063f:	f7 d0                	not    %eax
  100641:	c1 e8 1f             	shr    $0x1f,%eax
  100644:	89 45 98             	mov    %eax,-0x68(%ebp)
  100647:	c7 45 b4 01 00 00 00 	movl   $0x1,-0x4c(%ebp)
  10064e:	e9 dd fd ff ff       	jmp    100430 <printer_vprintf+0x2c0>
            zeros = width - len - !!negative;
        else
            zeros = 0;
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
            p->putc(p, ' ', color);
  100653:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100657:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10065e:	00 
  10065f:	89 34 24             	mov    %esi,(%esp)
  100662:	ff 16                	call   *(%esi)
                 && numeric && len + !!negative < width)
            zeros = width - len - !!negative;
        else
            zeros = 0;
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100664:	83 eb 01             	sub    $0x1,%ebx
  100667:	e9 8d fe ff ff       	jmp    1004f9 <printer_vprintf+0x389>
            p->putc(p, ' ', color);
  10066c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066f:	89 44 24 08          	mov    %eax,0x8(%esp)
  100673:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10067a:	00 
  10067b:	89 34 24             	mov    %esi,(%esp)
  10067e:	ff 16                	call   *(%esi)
                 && numeric && len + !!negative < width)
            zeros = width - len - !!negative;
        else
            zeros = 0;
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100680:	8b 45 c0             	mov    -0x40(%ebp),%eax
  100683:	83 e8 01             	sub    $0x1,%eax
  100686:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  100689:	89 7d ac             	mov    %edi,-0x54(%ebp)
  10068c:	89 5d a8             	mov    %ebx,-0x58(%ebp)
  10068f:	89 c3                	mov    %eax,%ebx
  100691:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100694:	e9 60 fe ff ff       	jmp    1004f9 <printer_vprintf+0x389>
            p->putc(p, *data, color);
        for (; width > 0; --width)
            p->putc(p, ' ', color);
    done: ;
    }
}
  100699:	83 c4 6c             	add    $0x6c,%esp
  10069c:	5b                   	pop    %ebx
  10069d:	5e                   	pop    %esi
  10069e:	5f                   	pop    %edi
  10069f:	5d                   	pop    %ebp
  1006a0:	c3                   	ret    

001006a1 <vsnprintf>:
    if (sp->s < sp->end)
        *sp->s++ = c;
    (void) color;
}

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1006a1:	55                   	push   %ebp
  1006a2:	89 e5                	mov    %esp,%ebp
  1006a4:	53                   	push   %ebx
  1006a5:	83 ec 24             	sub    $0x24,%esp
  1006a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  1006ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    string_printer sp;
    sp.p.putc = string_putc;
  1006ae:	c7 45 ec 65 00 10 00 	movl   $0x100065,-0x14(%ebp)
    sp.s = s;
  1006b5:	89 5d f0             	mov    %ebx,-0x10(%ebp)
    if (size) {
  1006b8:	85 c0                	test   %eax,%eax
  1006ba:	74 2e                	je     1006ea <vsnprintf+0x49>
        sp.end = s + size - 1;
  1006bc:	8d 44 03 ff          	lea    -0x1(%ebx,%eax,1),%eax
  1006c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        printer_vprintf(&sp.p, 0, format, val);
  1006c3:	8b 45 14             	mov    0x14(%ebp),%eax
  1006c6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1006ca:	8b 45 10             	mov    0x10(%ebp),%eax
  1006cd:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006d1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1006d8:	00 
  1006d9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1006dc:	89 04 24             	mov    %eax,(%esp)
  1006df:	e8 8c fa ff ff       	call   100170 <printer_vprintf>
        *sp.s = 0;
  1006e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006e7:	c6 00 00             	movb   $0x0,(%eax)
    }
    return sp.s - s;
  1006ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006ed:	29 d8                	sub    %ebx,%eax
}
  1006ef:	83 c4 24             	add    $0x24,%esp
  1006f2:	5b                   	pop    %ebx
  1006f3:	5d                   	pop    %ebp
  1006f4:	c3                   	ret    

001006f5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1006f5:	55                   	push   %ebp
  1006f6:	89 e5                	mov    %esp,%ebp
  1006f8:	83 ec 18             	sub    $0x18,%esp
    va_list val;
    va_start(val, format);
  1006fb:	8d 45 14             	lea    0x14(%ebp),%eax
    int n = vsnprintf(s, size, format, val);
  1006fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100702:	8b 45 10             	mov    0x10(%ebp),%eax
  100705:	89 44 24 08          	mov    %eax,0x8(%esp)
  100709:	8b 45 0c             	mov    0xc(%ebp),%eax
  10070c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100710:	8b 45 08             	mov    0x8(%ebp),%eax
  100713:	89 04 24             	mov    %eax,(%esp)
  100716:	e8 86 ff ff ff       	call   1006a1 <vsnprintf>
    va_end(val);
    return n;
}
  10071b:	c9                   	leave  
  10071c:	c3                   	ret    
