import boto3
from botocore import exceptions
from botocore.exceptions import ClientError
import logging
from dotenv import load_dotenv
from os import getenv
from abc import ABC
from datetime import datetime
import pandas as pd


logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

load_dotenv('/opt/airflow/outputs/.env')



class AWS_Airflow(ABC):
    def __init__(self) -> None:
        self.s3_client = boto3.client(
            's3',
            aws_access_key_id = getenv('AWS_ID'),
            aws_secret_access_key = getenv('AWS_KEY')
        )
        self.s3_resource = boto3.resource(
            's3',
            aws_access_key_id = getenv('AWS_ID'),
            aws_secret_access_key = getenv('AWS_KEY')
        )


    def _valida_bucket(self) -> bool:
        try:
            self.s3_client.list_buckets()['Buckets'][0]['Name']
        except IndexError:
            print('Não existe bucket nenhum')
            return True
        return False


    def _criar_bucket(self, nome) -> bool:
        try:
            self.s3_client.create_bucket(Bucket=nome)
        except ClientError as e:
            logging.error(e)
            return False
        return True


    def baixar_base(self):
        url = "https://s3-sa-east-1.amazonaws.com/ckan.saude.gov.br/Leitos/2021-07-17/esus-vepi.LeitoOcupacao.csv"
        df = pd.read_csv(url, low_memory=False)
        df.to_csv("/opt/airflow/outputs/dados.csv", index=False)

    def iniciar(self) -> None:
        if self._valida_bucket():
            self._criar_bucket('rhl-s3-bucket-da-pastel')
            print(f'bucket riado com suceso: rhl-s3-bucket-da-pastel')
        else:
            nome = self.s3_client.list_buckets()['Buckets'][0]['Name']
            print(f'bucket ja criado: {nome}')


    def enviar_arquivo(self) -> None:
        data_proc=datetime.now().strftime("%Y%m%d_%H%M%S")
        self.s3_resource.Bucket('rhl-s3-bucket-da-pastel').upload_file(
            '/opt/airflow/outputs/dados.csv',
            f"airflow/dados/input/dados_{data_proc}.csv"
            )