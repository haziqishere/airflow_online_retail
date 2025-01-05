# Overview

Welcome to the Airflow Online Retail Project! This project demonstrates a data pipeline using Apache Airflow, Google Cloud BigQuery, and Metabase for data visualization. Below is an overview of the data pipeline.

![Pipeline Flow Overview](pictures/pipeline_flow_overview_drawn.png)

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

![Data Model Schema](pictures/data_model_schema.png)

# Pipeline Flow in Airflow

Here is a screenshot of the successful pipeline flows in Apache Airflow.

![Pipeline Flow Successful](pictures/pipeline_flow_successful_from_airflow.png)

# Generated Dashboard

The dashboard below is generated using Metabase and connects directly to Google Cloud BigQuery.

!Dashboard

# BigQuery UI

This screenshot shows the BigQuery UI after all the tables have been created, including fact, dimensional, and report tables.

![BigQuery UI](pictures/BigQuery_screenshoot.png)

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

# Tech Stack

- ![Docker](https://www.docker.com/sites/default/files/d8/2019-07/Moby-logo.png) **Docker**
- ![Apache Airflow](https://airflow.apache.org/docs/apache-airflow/stable/_images/pin_large.png) **Apache Airflow**
- ![Google Cloud BigQuery](https://upload.wikimedia.org/wikipedia/commons/5/5f/Google_Cloud_BigQuery_Logo.png) **Google Cloud BigQuery**
- ![Astro](https://www.astronomer.io/img/brand/astro-logo-dark.png) **Astro**
- ![Metabase](https://www.metabase.com/images/logo.svg) **Metabase**
- ![Soda Core](https://soda.io/wp-content/uploads/2021/05/soda-logo.png) **Soda Core**
- ![dbt](https://docs.getdbt.com/img/dbt-logo.svg) **dbt (Data Build Tool)**