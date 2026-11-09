# Student Performance Analytics & Reporting Pipeline

An automated R-based data analytics pipeline and reporting tool designed to evaluate student assessment metrics, analyze score distributions, and generate professional HTML performance dashboards.

## 📊 Project Overview
This project simulates student grading data, calculates weighted final scores (40% Midterm + 60% Final), applies performance thresholds, and organizes cohorts using custom exploratory data visualization panels.

## 🛠️ Built With
- **Language:** R (v4.6.1)
- **Environment:** RStudio / R Markdown
- **Key Techniques:** Vectorized data pipelines, custom multi-panel plotting layouts (`par(mfrow)`), and automated HTML report generation (`knitter`).

## 📁 Repository Structure
- `analysis_pipeline.R`: Core data generation, computation, and multi-panel dashboard script.
- `performance_reports_rmd.Rmd`: R Markdown source template for executive and statistical summaries.
- `performance_reports_rmd.html`: Fully compiled, interactive HTML performance report.
