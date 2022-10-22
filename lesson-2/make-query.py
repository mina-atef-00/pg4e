# ? i want to insert into studernt, and into course, and then insert into roster
text = """
Meghan, si106, Instructor
Conrad, si106, Learner
Jomana, si106, Learner
Sadiyah, si106, Learner
Sonny, si106, Learner
Eniola, si110, Instructor
Caydee, si110, Learner
Fynn, si110, Learner
Noa, si110, Learner
Riley, si110, Learner
Rafif, si206, Instructor
Anum, si206, Learner
Luiza, si206, Learner
Maca, si206, Learner
Morran, si206, Learner
"""

names: dict[str, int] = {
    "Meghan": 1,
    "Conrad": 2,
    "Jomana": 3,
    "Sadiyah": 4,
    "Sonny": 5,
    "Eniola": 6,
    "Caydee": 7,
    "Fynn": 8,
    "Noa": 9,
    "Riley": 10,
    "Rafif": 11,
    "Anum": 12,
    "Luiza": 13,
    "Maca": 14,
    "Morran": 15,
}

courses: dict[str, int] = {"si106": 1, "si110": 2, "si206": 3}

ROLES: dict[str, int] = {"Instructor": 1, "Learner": 0}


def split_text(text: str) -> list[str]:
    lines = text.strip().split("\n")
    return lines


def split_line(line: str) -> list[str]:
    words = line.strip().split(",")
    return words


def make_query(words: list[str]) -> str:
    name: str = words[0].strip()
    course: str = words[1].strip()
    role_text: str = words[2].strip()

    query: str = """INSERT INTO roster
        (student_id, course_id, role)
        VALUES ({},{},{});""".format(
        names[name], courses[course], ROLES[role_text]
    )

    return query


def main():

    lines = split_text(text)

    for line in lines:
        print(make_query(split_line(line)))


if __name__ == "__main__":
    main()
