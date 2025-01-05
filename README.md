# Overview

Welcome to the Airflow Online Retail Project! This project demonstrates a data pipeline using Apache Airflow, Google Cloud BigQuery, and Metabase for data visualization. Below is an overview of the data pipeline.

![Pipeline Flow Overview](README%20pictures/pipeline_flow_overview_drawn.png)

# Tech Stack

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Apache Airflow](https://img.shields.io/badge/Apache%20Airflow-017CEE?style=for-the-badge&logo=Apache%20Airflow&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Metabase](https://img.shields.io/badge/Metabase-509EE3?style=for-the-badge&logo=metabase&logoColor=fff)
![Soda](https://img.shields.io/badge/Soda-0C344B?style=for-the-badge&logo=soda&logoColor=fff)
# Project Contents

Your Astro project contains the following files and folders:

- **dags**: This folder contains the Python files for your Airflow DAGs.
- **Dockerfile**: This file contains a versioned Astro Runtime Docker image.
- **include**: This folder contains additional files for your project.
- **packages.txt**: Install OS-level packages needed for your project.
- **requirements.txt**: Install Python packages needed for your project.
- **plugins**: Add custom or community plugins for your project.
- **airflow_settings.yaml**: Specify Airflow Connections, Variables, and Pools.

# Deploy Your Project Locally

1. Start Airflow on your local machine by running:
    ```sh
    astro dev start
    ```

    This command will spin up 4 Docker containers on your machine:
    - Postgres: Airflow's Metadata Database
    - Webserver: The Airflow component responsible for rendering the Airflow UI
    - Scheduler: The Airflow component responsible for monitoring and triggering tasks
    - Triggerer: The Airflow component responsible for triggering deferred tasks

2. Verify that all 4 Docker containers were created by running:
    ```sh
    docker ps
    ```

3. Access the Airflow UI for your local Airflow project at [http://localhost:8080/](http://localhost:8080/) and log in with 'admin' for both your Username and Password.

# Deploy Your Project to Astronomer

If you have an Astronomer account, pushing code to a Deployment on Astronomer is simple. For deploying instructions, refer to [Astronomer documentation](https://www.astronomer.io/docs/astro/deploy-code/).

# Data Model Schema

Below is the data model schema for the dimension and fact tables.

![Data Model Schema](README%20pictures/data_model_schema.png)

# Pipeline Flow in Airflow

Here is a screenshot of the successful pipeline flows in Apache Airflow.

![Pipeline Flow Successful](README%20pictures/pipeline_flow_successful_from_airflow.png)

# Generated Dashboard

The dashboard below is generated using Metabase and connects directly to Google Cloud BigQuery.

!Dashboard

# BigQuery UI

This screenshot shows the BigQuery UI after all the tables have been created, including fact, dimensional, and report tables.

![BigQuery UI](README%20pictures/BigQuery_screenshoot.png)

# Important Commands

Testing each task:
```sh
airflow tasks test retail upload_csv_to_gcs 2023-01-01
airflow tasks test retail create_retail_dataset 2023-01-01
airflow tasks test retail gcs_to_raw 2023-01-01
```

Checking data quality types:
```sh
soda scan -d retail -c include/soda/configuration.yml include/soda/checks/sources/raw_invoices.yml
```

First data quality check in place:
```sh
airflow tasks test retail check_load 2023-01-01
```

Transformation:
```sh
astro dev bash
source /usr/local/airflow/dbt_venv/bin/activate
cd include/dbt 
dbt deps
dbt run --profiles-dir /usr/local/airflow/include/dbt/
```

Quality Check and Report:
```sh
astro dev bash
source /usr/local/airflow/dbt_venv/bin/activate
cd include/dbt 
dbt deps
dbt run --select path:models/report --profiles-dir /usr/local/airflow/include/dbt/
```