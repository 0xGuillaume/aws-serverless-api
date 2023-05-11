from time import sleep
import json
import argparse
import requests



def url() -> str:
    """."""

    with open("../terraform/terraform.tfstate") as file:
        state = json.load(file)


    for resource in state["resources"]:
        print(resource, "\n")

    
    try:
        url = state["outputs"]["api_url"]["value"]
        return url
    
    except KeyError:
        print("Key ['value'] not found")


url()


parser = argparse.ArgumentParser()

parser.add_argument(
    "-a", "--amount", 
    required=True, 
    type=int,
    help="Amount of requests to run."
)

args = parser.parse_args()


def get() -> None:
    """."""

    url = ""

    response = requests.get(url)

    return response.text


#for _ in range(int(args.amount)):
#    print(f"{_} - {get()}\n")
#    sleep(2)


