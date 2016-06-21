# Assumptions:
# 1st, the current stock matrix has two columns, one is the ticker symbol, another is the current Z% stock (vs bond) allocation.
# 2nd, the target allocation matrix has two columns, one is the ticker symbol, another is the X% stock (vs bond) target allocation. 
# 3rd, the drift threshold matrix has two columns, one is the ticker symbol, another is the Y% drift threshold from target allocation. 
# 4th, the number of the ticker symbols in the drift threshold matrix could be more than the one in the current matrix 
# 5th, the ticker symbols in the target allocation matrix and the drift threshold matrix should be the same
# 6th, there is no NA and missing data in all the matrices

# Input the current stock matrix, the stock (vs bond) target allocation matrix and the drift threshold matrix
DrawdownFinder <- function(current_matrix, target_allocation, drift_threshold)
{
  # Data pre-processing, build the data frame and order data by the ticker
  current_matrix <- as.data.frame(current_matrix)
  colnames(current_matrix) <- c("Ticker", "Current")
  current_matrix <- current_matrix[order(current_matrix$Ticker), ]
  
  drift_threshold <- as.data.frame(drift_threshold)
  colnames(drift_threshold) <- c("Ticker", "Threshold")
  drift_threshold <- drift_threshold[order(drift_threshold$Ticker), ]
  
  target_allocation <- as.data.frame(target_allocation)
  colnames(target_allocation) <- c("Ticker", "Target")
  target_allocation <- target_allocation[order(target_allocation$Ticker), ]
   
  # Get the ticker symbols which exist in all the data frames
  intersect_info <- intersect(current_matrix$Ticker, drift_threshold$Ticker)
  intersect_current <- current_matrix$Ticker %in% intersect_info
  intersect_driftNtarget <- drift_threshold$Ticker %in% intersect_info
 
  # Generate the stock drawdown data frame
  drawdown_matrix <- current_matrix[intersect_current, ]
  drawdown_matrix$Current <- current_matrix$Current[intersect_current] - target_allocation$Target[intersect_driftNtarget]
  colnames(drawdown_matrix)[2] <- "Drawdown"
  
  new_matrix <- cbind(drawdown_matrix, 
                      drift_threshold[intersect_driftNtarget, "Threshold",  drop = F],
                      target_allocation[intersect_driftNtarget, "Target", drop = F])
  
  
  drawndown_stock <- new_matrix[abs(new_matrix$Drawdown) >= new_matrix$Threshold, ]

  drawndown_stock
}


