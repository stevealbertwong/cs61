import argparse
import os
import random

types = ["DEPOSIT", "WITHDRAW", "TRANSFER"]

parser = argparse.ArgumentParser("generate traces for bank app")
parser.add_argument("accounts", type=int, help="number of accounts")
parser.add_argument("operations", type=int, help="number of operations")
parser.add_argument("traces", type=int, help="number of traces to generate")
parser.add_argument("tracedir", type=str, help="directory to store traces")
parser.add_argument("--seed", type=int, dest="seed",
                    help="seed for random generator")

args = vars(parser.parse_args())
if "seed" in args:
    random.seed(args["seed"])
else:
    random.seed()

accounts = args["accounts"]
operations = args["operations"]
traces = args["traces"]
tracedir = args["tracedir"]
assert(accounts > 0)
assert(operations > 0)
assert(traces > 0)

if not os.path.exists(tracedir):
    os.makedirs(tracedir)

for i in range(traces):
    tracename = tracedir + "/" + str(i) + ".txt"
    tracefile = open(tracename, "wb")
    for _ in range(operations):
        optype = random.randint(0, len(types) - 1)
        account = random.randint(0, accounts - 1)
        amount = random.randint(1, 100)
        type = types[optype]
        if type == "TRANSFER":
            account2 = account
            while account2 == account:
                account2 = random.randint(0, accounts - 1)
            tracefile.write("%s %d %d %d\n" % (type, account, amount, account2))
        else:
            tracefile.write("%s %d %d\n" % (type, account, amount))
    tracefile.write("\n")
    tracefile.close()
    print "made trace: %s" % tracename
