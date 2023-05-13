"""Module to query apigw items."""
from colorama import Fore
from random import choice
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

        self._run()


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
    

    def _output(self, code:str, uri:str) -> None:
        """Formats requests output.

        Arguments:
            code: HTTP status code.
            uri: URI's name requested.
        """

        code = str(code)
        output = f"[{code}] - HTTP /GET - {uri.upper()}"

        if code.startswith("2"):
            return Fore.CYAN + output + Fore.RESET

        else:
            return Fore.RED + output + Fore.RESET


    def _requests(self, url:str) -> None:
        """Run HTTP request.

        Argument:
            url: HTTP url to request.
        """

        return requests.get(url).status_code


    def _scan(self) -> str:
        """Returns ApiGateway scan url."""

        url = self.url + self.outputs["uri_scan"]["value"]
        code = self._requests(url)

        return print(self._output(code, "scan"))


    def _get_item(self) -> str:
        """Returns ApiGateway get_item url."""

        url = self.url + self.outputs["uri_put_item"]["value"]
        code = self._requests(url)

        return print(self._output(code, "get item"))


    def _run(self) -> None:
        """Run X HTTP requests for demo purpose."""

        for index in range(1, self.amount + 1):

            choice([self._scan(), self._get_item()])
    
            #self._get_item()
            #self._scan()
            sleep(1)
            

if __name__ == "__main__":
    Demo(args.amount)
