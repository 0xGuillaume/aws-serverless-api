"""Module to query apigw items."""
import sys
from random import choice
from subprocess import getoutput
from time import sleep
from datetime import datetime
from json import loads
from argparse import ArgumentParser
from requests import get as request
from colorama import Fore


parser = ArgumentParser()

parser.add_argument(
    "-a", "--amount",
    required=True,
    type=int,
    help="Amount of requests to run."
)

args = parser.parse_args()


class Demo:
    """Run API calls.

    Arguments:
        amount: An integer indicates amount of HTTP request to run.
    """

    def __init__(self, amount:int) -> None:
        """Initialize Demo class.
        
        Arguments:
            amount: Amount of query to run.
        """

        self.amount = amount
        self.outputs = self._outputs()
        self.url = self._url()

        self._run()


    def _outputs(self) -> dict:
        """Get terraform outputs."""

        outputs = getoutput(
            "terraform -chdir=./terraform/ output -json | jq"
        )

        if not loads(outputs):
            error = Fore.RED + (
                "ERROR: Terraform output returns nothing. "
                "Your infrastructure might not be up."
            ) + Fore.RESET
            sys.exit(error)

        return loads(outputs)


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
        output = f"{datetime.now()} - [{code}] - HTTP /GET - {uri.upper()}"

        if code.startswith("2"):
            return Fore.CYAN + output + Fore.RESET

        return Fore.RED + output + Fore.RESET


    def _requests(self, url:str) -> None:
        """Run HTTP request.

        Argument:
            url: HTTP url to request.
        """

        return request(url, timeout=3).status_code


    def _scan(self) -> str:
        """Returns ApiGateway scan url."""

        url = self.url + self.outputs["uri_scan"]["value"]
        code = self._requests(url)

        return print(self._output(code, "scan"))


    def _get_item(self) -> str:
        """Returns ApiGateway get_item url."""

        url = self.url + self.outputs["uri_get_item"]["value"]
        code = self._requests(url)

        return print(self._output(code, "get item"))


    def _run(self) -> None:
        """Run X HTTP requests for demo purpose."""

        try :
            for _ in range(1, self.amount + 1):

                choice_ = choice([1, 2])

                if choice_ == 1:
                    self._get_item()

                else:
                    self._scan()
                sleep(1)

        except KeyboardInterrupt:
            sys.exit()

if __name__ == "__main__":
    Demo(args.amount)
