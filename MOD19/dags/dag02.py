import airflow
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
from aws_dag.aws import AWS_Airflow

aws = AWS_Airflow()

args = {
    'owner': 'airflow',
    'start_date': airflow.utils.dates.days_ago(0),
}

dag = DAG(
    dag_id='aws_covid', 
    default_args=args,
    schedule_interval=None,
    dagrun_timeout=timedelta(minutes=60)
)

t1 = PythonOperator(
    task_id='baixar_base',
    python_callable=aws.baixar_base,
    dag=dag)

t2 = PythonOperator(
    task_id='iniciar_bucket',
    python_callable=aws.iniciar,
    dag=dag)

t3 = PythonOperator(
    task_id='carregar_dados',
    python_callable=aws.enviar_arquivo,
    dag=dag)


t1.set_downstream(t2)
t2.set_downstream(t3)

