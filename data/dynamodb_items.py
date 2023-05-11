"""Generate random dynamodb dataset."""
from random import randint, choice
from json import dump


FILENAME = "items.json"


class DynamoDbItems:
    """Generate DynamoTb json items."""


    def __init__(self, amount:int) -> None:
        """Initialize DynamoDbItems class.

        Argument:
            amount: Amount of items to create.
        """

        self.amount = amount

        self.items = {}
        self.item = {
            "hostname": {"S": ""},
            "os": {"S": ""},
            "region": {"S": ""},
            "ipaddress": {"S": ""},
            "state": {"S": ""},
            "monitoring": {"BOOl": ""},
        }

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


    def _generate(self) -> list:
        """Generate items dataset."""

        for index in range(1, self.amount + 1):

            self.item["os"]         = self._os()
            self.item["hostname"]   = f"AWS{self._os()[:3]}{index}".upper()
            self.item["region"]     = self._region()
            self.item["ipaddress"]  = self._ipaddress()
            self.item["state"]      = self._state()
            self.item["monitoring"] = choice([True, False])

            self.items.update({f"Item{index}": self.item})


    def _write(self) -> None:
        """Write DynamoDb items into a json file."""

        with open(FILENAME, "w", encoding="utf-8") as file:
            dump(self.items, file, indent=4)


if __name__ == "__main__":
    DynamoDbItems(100)
