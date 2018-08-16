from urllib.parse import urljoin
import os
import requests

def register_snapshot_repository(bucket: str, region: str, role_arn: str, domain: str, repository_name: str) -> bool:
    """Register snapshot repository on Elasticsearch Cluster if it does not exist

     Args:
         bucket (str): S3 bucket use to store the indicies snapshot
         region (str): S3 bucket region
         role_arn (str): The ARN of the role authorize Elasticsearch to use S3 bucket
         domain (str): The Elasticsearch Cluster domain
         repository_name (str): The name of the repository to create

    Returns:
        bool: Result of the registration
    """
    payload = dict(type='s3', settings=dict(bucket=bucket, region=region, role_arn=role_arn))
    uri = urljoin(domain, f'_snapshot/{repository_name}')

    resp = requests.get(uri, headers={'Content-Type': 'application/json'})
    if resp.status_code == 200:
        return True

    resp = requests.put(uri, json=payload, headers={'Content-Type': 'application/json'})
    if resp.status_code == 200:
        return True
    else:
        print(resp.text)
        return False

def getenv_or_raise(key: str) -> str:
    value = os.getenv(key)
    if value == None:
        message = f'Missing {key} environment key'
        raise Exception(message)
    else:
        return value

if __name__ == '__main__':
    register_snapshot_repository(
        getenv_or_raise('AWS_S3_BUCKET'),
        getenv_or_raise('AWS_REGION'),
        getenv_or_raise('AWS_ROLE_ARN'),
        getenv_or_raise('AWS_ES_DOMAIN'),
        getenv_or_raise('REPOSITORY_NAME')
    )
