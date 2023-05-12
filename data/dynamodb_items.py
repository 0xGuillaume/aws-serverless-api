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
            "monitoring": {"S": ""}
        }

        i = self._generate()
        print(i)



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

        items = {}

        for index in range(1, self.amount + 1):

            item = self.item
            i_ = f"Item{index}"

            item[i_] = {}

            print(item[i_])
            os = self._os()

            #item[i_]["os"]["S"]            = os
            #item[i_]["hostname"]["S"]      = f"AWS{os[:3]}{index}".upper()
            #item[i_]["region"]["S"]        = self._region()
            #item[i_]["ipaddress"]["S"]     = self._ipaddress()
            #item[i_]["state"]["S"]         = self._state()
            #item[i_]["monitoring"]["S"]    = str(choice([True, False]))

            #items.update("Item{index}", item)

        #print(items,"\n")
        return items


    def _write(self) -> None:
        """Write DynamoDb items into a json file."""

        with open(FILENAME, "w", encoding="utf-8") as file:
            dump(self.items, file, indent=4)


if __name__ == "__main__":
    DynamoDbItems(100)
