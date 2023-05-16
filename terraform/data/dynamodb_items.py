"""Generate random dynamodb dataset."""
from argparse import ArgumentParser
from random import randint, choice
from json import dump


parser = ArgumentParser(
    description="Generate X AWS DynamoDb table items in a JSON file."
)

parser.add_argument(
    "-a", "--amount",
    required=True,
    type=int,
    help="How many items you want to generate.",
)

args = parser.parse_args()


class DynamoDbItems:
    """Generate DynamoTb json items.

    The dataset used is based uppon AWS EC2
    instances attributes such as :
        - IpAddress
        - Region
        - Os
        - Hostname

    Attributes:
        amount: A integer indicating how many items to generate.
    """


    def __init__(self, amount:int) -> None:
        """Initialize DynamoDbItems class.

        Argument:
            amount: Amount of items to create.
        """

        self.amount = amount
        self.filename = "items.json"
        self.items = {}

        self._generate()
        self._write()


    def _region(self) -> str:
        """Generate a random AWS region."""

        return f"{choice(['eu', 'us'])}-west-{randint(1,4)}"


    def _os(self) -> str:
        """Pick an OS between several linux distributions."""

        return choice(["ubuntu", "rhel", "debian", "amazonlinux"])


    def _byte(self) -> int:
        """Generate randome byte for ipaddress."""

        return randint(1, 255)


    def _ipaddress(self) -> str:
        """Generate random private ipaddress."""

        return f"10.{self._byte()}.{self._byte()}.{self._byte()}"


    def _state(self) -> str:
        """Pick a random EC2 instance state."""

        return choice(["running", "stopped", "terminated"])


    def _generate(self) -> dict:
        """Generate items dataset."""

        for index in range(1, self.amount + 1):

            item = {
                "hostname": {"S": ""},
                "os": {"S": ""},
                "region": {"S": ""},
                "ipaddress": {"S": ""},
                "state": {"S": ""},
                "monitoring": {"S": ""}
            }

            system = self._os()

            item["os"]["S"]            = system
            item["hostname"]["S"]      = f"AWS{system[:3]}{index}".upper()
            item["region"]["S"]        = self._region()
            item["ipaddress"]["S"]     = self._ipaddress()
            item["state"]["S"]         = self._state()
            item["monitoring"]["S"]    = str(choice([True, False]))

            self.items[f"Item{index}"] = item


    def _write(self) -> None:
        """Write DynamoDb items into a json file."""

        with open(self.filename, "w", encoding="utf-8") as file:
            dump(self.items, file, indent=4)


if __name__ == "__main__":
    DynamoDbItems(args.amount)
