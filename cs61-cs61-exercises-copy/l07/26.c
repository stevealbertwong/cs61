
int
func(char c)
{
    switch (c) {
        case 'a':
            return (10 * c);
            break;
        case 'b':
            return (c + 50);
            break;
        case 'c':
            return (c << 10);
            break;
        default:
            return (c);
    }
}
