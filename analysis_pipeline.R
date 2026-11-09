rm(list = ls()) # Clear workspace
set.seed(42)    # Fixed random seed for deterministic simulation

#Data Generation & Feature Engineering
N_STUDENTS <- 50

# Synthetic Data Generation
student_ids <- sprintf("STD-%03d", 1:N_STUDENTS)
gender      <- factor(sample(c("Female", "Male"), N_STUDENTS, replace = TRUE))
midterm     <- round(runif(N_STUDENTS, min = 40, max = 95), 0)
final       <- round(runif(N_STUDENTS, min = 30, max = 100), 0)

# Construct Primary Data Frame
student_df <- data.frame(
  student_id = student_ids,
  gender     = gender,
  midterm    = midterm,
  final      = final,
  stringsAsFactors = FALSE
)

#Composite Metric & Categorical Recoding 
# Weighted Final Grade Formula: 40% Midterm + 60% Final
student_df$composite_score <- (student_df$midterm * 0.40) + (student_df$final * 0.60)

# Binary Classification (Pass/Fail Threshold = 60)
student_df$status <- factor(
  ifelse(student_df$composite_score >= 60, "Passed", "Failed"),
  levels = c("Failed", "Passed")
)

# --- 4. Matrix Operations & Summary Statistics ---
# Extract Numeric Sub-matrix
numeric_cols <- c("midterm", "final", "composite_score")
metric_matrix <- student_df[, numeric_cols]

# Vectorized Column-wise Aggregations via apply() (MARGIN = 2 for Columns)
metric_means <- apply(metric_matrix, 2, mean)
metric_sds   <- apply(metric_matrix, 2, sd)

# Consolidate Descriptive Summary Table
summary_table <- rbind(
  Mean = round(metric_means, 2),
  Std_Dev = round(metric_sds, 2)
)

cat("\n======================================================\n")
cat("          DESCRIPTIVE PERFORMANCE SUMMARY             \n")
cat("======================================================\n")
print(summary_table)
cat("======================================================\n\n")

# Data Visualization & Dashboard Rendering 
# Initialize 2x2 Graphics Layout
par(mfrow = c(2, 2), mar = c(3, 3, 2, 1))

# Plot 1: Midterm Score Histogram
hist(
  student_df$midterm,
  col  = "#4C72B0",
  main = "Midterm Distribution",
  xlab = "Score",
  ylab = "Student Count",
  border = "white"
)
# Plot 2: Final Score Histogram
hist(
  student_df$final,
  col  = "#55A868",
  main = "Final Score Distribution",
  xlab = "Score",
  ylab = "Student Count",
  border = "white"
)

# Plot 3: Boxplot of Composite Score by Academic Status
boxplot(
  composite_score ~ status,
  data = student_df,
  col  = c("#C44E52", "#8172B2"),
  main = "Score Variance by Status",
  xlab = "Academic Status",
  ylab = "Composite Score"
)

# Plot 4: Bivariate Correlation Scatter Plot with Group Segmentation
cohort_colors <- ifelse(student_df$gender == "Female", "#DD8452", "#4C72B0")

plot(
  student_df$midterm,
  student_df$final,
  col  = cohort_colors,
  pch  = 19,
  cex  = 1.2,
  main = "Midterm vs. Final Score Correlation",
  xlab = "Midterm Score",
  ylab = "Final Score"
)

# Benchmark Average Indicators
abline(h = mean(student_df$final), col = "gray40", lty = 2, lwd = 1.5)
abline(v = mean(student_df$midterm), col = "gray40", lty = 2, lwd = 1.5)

# Add Legend
legend(
  "topleft",
  legend = levels(student_df$gender),
  col    = c("#DD8452", "#4C72B0"),
  pch    = 19,
  bty    = "n",
  cex    = 0.9
)

# Reset Device Grid Layout
par(mfrow = c(1, 1))

