# Playing with the Collatz conjecture

This program prints at least `SETSIZE` (its only command-line argument) numbers
known to collapse to 1 for the Collatz conjecture. If the program loops
infinitely, the number doesn't reach 1! This is obviously not a practical way of
trying to prove the conjecture.

## Try it

```{sh}
$ ghc -O2 -dynamic collatz
$ ./collatz 100
```
