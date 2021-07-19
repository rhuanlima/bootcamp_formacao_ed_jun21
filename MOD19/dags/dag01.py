import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta


args = {
    'owner': 'airflow',
    'start_date': airflow.utils.dates.days_ago(2),
}

dag = DAG(
    dag_id='dag_datas_rhuan', 
    default_args=args,
    schedule_interval='@daily',
    dagrun_timeout=timedelta(minutes=60)
)

t1 = BashOperator(
    task_id='task_datas_rhuan',
    bash_command='date',
    dag=dag)

t2 = BashOperator(
    task_id='sleep_10s',
    bash_command='sleep 10',
    retries=3,
    dag=dag)

t3 = BashOperator(
    task_id='saida',
    bash_command='date > /opt/airflow/outputs/date_output.txt',
    retries=3,
    dag=dag)

t1 >> t2 >> t3

