from typing import Iterator

import hidden
import psycopg


class Solution:
    secrets = hidden.secrets()
    connection = psycopg.connect(
        host=secrets["host"],
        port=secrets["port"],
        dbname=secrets["dbname"],
        user=secrets["user"],
        password=secrets["pass"],
        connect_timeout=3,
    )

    def __init__(self) -> None:
        self.cur = self.connection.cursor()
        self._refresh_table()

    def _refresh_table(self) -> None:
        self.cur.execute("DROP TABLE IF EXISTS pythonseq")
        print("DROP TABLE IF EXISTS pythonseq")
        self.cur.execute("CREATE TABLE pythonseq (iter INTEGER, val INTEGER);")
        print("CREATE TABLE pythonseq (iter INTEGER, val INTEGER);")

    @staticmethod
    def _create_pseudo_nums() -> Iterator[str]:
        yield (f"{1} {651612}")
        value = 651612
        for num in range(2, 301):
            value = int((value * 22) / 7) % 1000000
            yield (f"{num} {int(value)}")

    def insert_sequence_db(self) -> None:
        sequences: Iterator[str] = self._create_pseudo_nums()

        for sequence in sequences:
            seq_list: list[str] = sequence.split()
            iter: int = int(seq_list[0])
            val: int = int(seq_list[1])

            self.cur.execute(
                "INSERT INTO pythonseq (iter, val) VALUES (%s,%s)", (iter, val)
            )
            print(
                "INSERT INTO pythonseq (iter, val) VALUES (%s,%s)", (iter, val)
            )

        self.connection.commit()


def main() -> None:
    soln = Solution()
    soln.insert_sequence_db()


if __name__ == "__main__":
    main()
