# Support Call Enrichment Pipeline (ETL)
##  Overview
This assignment implements an automated, incremental ETL (Extract, Transform, Load) pipeline using Apache Airflow. The system enriches raw support call data from a MySQL database with telephony metadata from a JSON-based Mock API and loads the final analytical dataset into DuckDB.

The pipeline is designed with a focus on Data Quality, Idempotency, and Production Observability.

## Architecture
### 1.  Extract:
  MySQL: Fetches new call records and employee master data from the support_call_center database.
  
  JSON Files: Dynamically reads telephony metadata (duration, LLM-style summaries) for specific call IDs.

### 2. Transform:
Joins data sources using Pandas.

Applies Data Quality (DQ) filters.

### 3. Load:

Performs an "Upsert" (Insert or Replace) into DuckDB.

## Technical Features
### 1. Incremental Loading & Watermarking
Instead of processing the entire database every hour, the DAG utilizes Airflow's data_interval_start and data_interval_end. This ensures:

#### Deterministic Runs: Each run processes exactly one hour of data.

#### Backfill Support: Historical data can be re-processed without manual configuration changes.

### 2. Data Quality & Validation
The pipeline includes a "Defensive Programming" layer:

#### Schema Validation: Ensures JSON files contain all required fields before processing.

#### Business Logic Checks: Filters out records with negative durations.

#### Referential Integrity: Drops call records that do not map to an existing employee_id.

### 3. Idempotency
To prevent data duplication during retries or backfills, the pipeline uses:

#### Primary Key Constraints: Defined on call_id in the DuckDB schema.

#### Upsert Logic: Utilizes INSERT OR REPLACE to ensure that re-running a task updates existing records rather than duplicating them.

### 4. Observability & Reliability
#### Logging: Tracks row counts, processed records, and specific counts for rejected/malformed JSON files.

#### Retry Strategy: Configured with 2 retries and a 5-minute delay to handle transient database connectivity issues.

#### Alerting: Includes an on_failure_callback to trigger notifications in case of critical pipeline failure.
