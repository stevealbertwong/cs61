int fib(int n) {
    if (n < 2) {
        return n;
    }

    return fib(n-1) + fib(n-2);
}

int main() {
    int result = fib(15);
    return result;
}
