# Instructions to Install the Project

## Requirements
- Python 3.8 or higher
- Python `venv` package
- PostgreSQL

## Phase 1: Installing the Project

1. Clone the repository:
    ```bash
    git clone <repository_url>
    cd <repository_name>
    ```

2. Create a virtual environment using `venv`:
    ```bash
    python3 -m venv venv
    ```

3. Activate the virtual environment:
    - For Linux:
        ```bash
        source venv/bin/activate
        ```
    - For Windows:
        ```bash
        venv\Scripts\activate
        ```

4. Install Poetry:
    ```bash
    pip install poetry
    ```

5. Install project dependencies using Poetry:
    ```bash
    poetry install
    ```

## Phase 2: Installing the Database

1. Navigate to the `database` directory:
    ```bash
    cd database
    ```

2. Ensure you have already created a PostgreSQL database.

3. \:
    ```bash
    psql -U <username> -d <dbname> < filename.sql
    ```
    Replace `<username>` with your PostgreSQL username, `<dbname>` with the name of your database, and `filename.sql` with the SQL file to import.

4. Copy and paste the `.env.template` file located in the root of the project and rename it to `.env`.

5. Edit the following environment variables in the `.env` file with your PostgreSQL configuration:
    - `POSTGRES_NAME`
    - `POSTGRES_HOST`
    - `POSTGRES_USER`
    - `POSTGRES_PASSWORD`
    - `POSTGRES_PORT`

## Phase 3: Starting the Project

To start the project, run the following command:
```bash
uvicorn app.main:app --reload --host 127.0.0.1 --port 8080
```
**Now the project is running http://localhost:8080**