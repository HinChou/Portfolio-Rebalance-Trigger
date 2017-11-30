# Portfolio-Rebalance-Trigger
A Function in R that Finds the Stock Drawdown Which Will Trigger a Rebalance

# Problem
 Write a function in R that finds the stock drawdown which will trigger a rebalance, if given: 
 1) an X% stock (vs bond) target allocation; 
 and 2) a Y% drift threshold from target allocation. 



Assumptions are made by me:

1st, the current stock matrix has two columns, one is the ticker symbol, another is the current Z% stock (vs bond) allocation.

2nd, the target allocation matrix has two columns, one is the ticker symbol, another is the X% stock (vs bond) target allocation. 

3rd, the drift threshold matrix has two columns, one is the ticker symbol, another is the Y% drift threshold from target allocation. 

4th, the number of the ticker symbols in the drift threshold matrix could be more than the one in the current matrix 

5th, the ticker symbols in the target allocation matrix and the drift threshold matrix should be the same

6th, there is no NA and missing data in all the matrices

