#ifndef CS61_BANK_H
#define CS61_BANK_H

#define NACCOUNTS 4
#define NTRACES 32

enum bank_op_type {
    bank_op_deposit,
    bank_op_withdraw,
    bank_op_transfer
};

typedef struct bank_op {
    enum bank_op_type type;
    int acct1;
    int amount;
    int acct2; // only used for TRANSFER
} bank_op;

void* bank_thread_start(void* arg);
void bank_apply(bank_op* op);
void bank_deposit(int acct, int amount);
void bank_withdraw(int acct, int amount);
void bank_transfer(int acct1, int acct2, int amount);
void bank_parse_line(const char* line, bank_op* retop);
enum bank_op_type bank_parse_op_type(const char* s);

// bank_apply(op)
//    Apply a bank operation.
void bank_apply(bank_op* op) {
    switch (op->type) {
    case bank_op_deposit:
        bank_deposit(op->acct1, op->amount);
        break;
    case bank_op_withdraw:
        bank_withdraw(op->acct1, op->amount);
        break;
    case bank_op_transfer:
        bank_transfer(op->acct1, op->acct2, op->amount);
        break;
    }
}

// bank_parse_op_type(str)
//    Return the bank operation type corresponding to a string.
enum bank_op_type bank_parse_op_type(const char* str) {
    if (strcmp(str, "DEPOSIT") == 0)
        return bank_op_deposit;
    else if (strcmp(str, "WITHDRAW") == 0)
        return bank_op_withdraw;
    else if (strcmp(str, "TRANSFER") == 0)
        return bank_op_transfer;
    else
        assert(0);
}

// bank_parse_line(str, op)
//    Parse a line and store the bank operation in `op`. A line has the form
//    "TYPE ACCT1 AMOUNT ACCT2", where ACCT2 is only used for TRANSFER
//    operations.
//    Examples: DEPOSIT 0 100    // deposit $100 into account 0
//              WITHDRAW 1 100   // withdraw $100 from account 1
//              TRANSFER 0 100 1 // transfer $100 from account 0 to account 1
void bank_parse_line(const char* line, bank_op* op) {
    char type_string[16];
    int result = sscanf(line, "%15s %d %d %d",
                        type_string,
                        &op->acct1,
                        &op->amount,
                        &op->acct2);
    assert(result >= 3);
    op->type = bank_parse_op_type(type_string);
}


typedef struct bank_thread_args {
    int index;
    int nthreads;
} bank_thread_args;

void* bank_thread_start(void* args) {
    bank_thread_args* ba = (bank_thread_args*) args;

    while (ba->index < NTRACES) {
        char buf[BUFSIZ];
        sprintf(buf, "traces/%d.txt", ba->index);
        FILE* f = fopen(buf, "r");
        if (!f) {
            fprintf(stderr, "traces/%d.txt: %s\n", ba->index, strerror(errno));
            exit(1);
        }

        while (!feof(f)) {
            char* line = fgets(buf, sizeof(buf), f);
            if (line == NULL || line[0] == '\n')
                break;

            bank_op op;
            bank_parse_line(line, &op);
            bank_apply(&op);
        }

        fclose(f);
        ba->index += ba->nthreads;
    }

    free(ba);
    pthread_exit(NULL);
}

#endif
