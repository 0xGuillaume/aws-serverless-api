"""Module to query apigw items."""
import subprocess
from time import sleep
import json
from argparse import ArgumentParser
import requests


parser = ArgumentParser()

parser.add_argument(
    "-a", "--amount", 
    required=True, 
    type=int,
    help="Amount of requests to run."
)

args = parser.parse_args()


class Demo:
    """Run API calls."""

    def __init__(self, amount:int) -> None:
        """Initialize Demo class."""

        self.amount = amount
        self.outputs = self._outputs()
        self.url = self._url()

        self._requests(self._scan())
        print(self._get_item())

    def _outputs(self) -> dict:
        """Get terraform outputs."""

        outputs = subprocess.getoutput(
            "terraform -chdir=./terraform/ output -json | jq"
        )

        return json.loads(outputs) 


    def _url(self) -> str:
        """Get ApiGateway url."""

        base_url    = self.outputs["api_url"]["value"]
        stage       = self.outputs["stage"]["value"]

        return f"{base_url}{stage}/"


    def _scan(self) -> str:
        """Returns ApiGateway scan url."""

        return self.url + self.outputs["uri_scan"]["value"]


    def _get_item(self) -> str:
        """Returns ApiGateway get_item url."""

        return self.url + self.outputs["uri_put_item"]["value"]


    def _requests(self, url:str) -> None:
        """."""

        return requests.get(url).status_code



if __name__ == "__main__":
    Demo(args.amount)
