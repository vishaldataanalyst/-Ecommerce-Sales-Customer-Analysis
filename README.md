# E-Commerce Sales & Customer Analysis

## Objective
Analyze e-commerce sales, products, and customer behavior to improve revenue and retention.

## Tools Used
- **Python** – for cleaning data and uploading it into MySQL  
- **SQL** – for analysis and generating business insights  
- **Power BI** – for interactive dashboards and visualization  
- **MySQL** – database to store cleaned data

## Dataset
- [E-Commerce Dataset on Kaggle](https://www.kaggle.com/datasets/shrishtimanja/ecommerce-dataset-for-data-analysis)  
- The dataset must be downloaded separately due to size/license.

## Project Structure
Ecommerce-Sales-Customer-Analysis/
├── data/
│ └── README.md # dataset info
├── python/
│ └── data_upload.ipynb # Python notebook to clean and upload data into MySQL
├── sql/
│ └── analysis_queries.sql # SQL queries for insights
├── powerbi/
│ ├── dashboard.pbix # Power BI dashboard file
│ └── screenshots/ # screenshots of dashboard
└── README.md # project overview

## Methodology
1. Cleaned the dataset using Python.  
2. Uploaded cleaned data into **MySQL** using Python.  
3. Performed all **analysis using SQL queries** (sales trends, top products, high-value customers).  
4. Built **Power BI dashboards** to visualize sales, customer behavior, and insights.  
5. Derived **business recommendations** for revenue growth and customer retention.

## Key Insights
- Top 10% **high-value customers** identified  
- Repeat vs **one-time buyers** analysis  
- Regional revenue distribution  
- Top products contributing to sales  
- Cross-sell opportunities

## Business Recommendations
- Focus marketing efforts on **top 10% high-value customers**  
- Promote **high-selling products across regions**  
- Create **loyalty programs for repeat buyers** to improve retention

## Power BI Dashboard
Here are some key visualizations from the dashboard:

![Sales Overview 1](powerbi/screenshots/sales_overview_1.png)  
![Sales Overview 2](powerbi/screenshots/sales_overview_2.png)  
![Sales Overview 3](powerbi/screenshots/sales_overview_3.png)  
![Insights & Recommendations](powerbi/screenshots/insights_and_recommendations.png)
1. Download the dataset from Kaggle.  
2. Run the **Python notebook** to clean and upload data into MySQL.  
3. Execute **SQL queries** to analyze sales and customer behavior.  
4. Open the **Power BI dashboard** and connect it to the MySQL database.  
5. Explore interactive visuals and filters to gain insights.
