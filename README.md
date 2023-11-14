# bank-simulation

### Sample Usage

```bash
# To build the project
stack build
# To run the project
stack exec bank-simulation-exe
# To run the tests
stack test
# To run the tests with coverage
stack test --coverage
```

### Sample Output

The answer is generated multiple times to negate one-off spikes except Q3 where values for yellow, red and blue are printed successively. Although the maximum service time for a yellow customer is around 16s, there might be cases where multiple people with 16s service time line up to actually make waiting time more than expected.

```
"Given only yellow customers, what are the average and maximum customer waiting times?"
(0.4027657862338188,21.716760796378367)
(0.41836228109946505,29.05950358370319)
(0.41305499282236025,30.31309690361377)

"Given only red customers, what are the average and maximum queue lengths in-front of the teller?"
(1.4254,7.0)
(1.4249,6.0)
(1.4272,7.0)

"Which type of customer(yellow, red or blue) gives the gives the closest value between the average and maximum customer waiting times?"
(0.4027657862338188,21.716760796378367)
(9.594163872695344,232.1099520015414)
(39.424092592453,668.3177335856017)
"The difference between the two values seems to be lowest for yellow."


```

### Future Scope

- Write extensive tests to get 100% code coverage and cover various sad flow scenarios
- Fix Float inequality for getServiceTimeTest
- Incorporate ADTs like Person and PersonTimestamp commented out in BankSim.
- Comments
