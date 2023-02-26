while True:
    txt: str = input("Enter a string: ")
    if len(txt) < 1:
        break

    hash_val: int = 0
    position: int = 0
    for letter in txt:
        position = (position % 3) + 1
        hash_val = (hash_val + (position * ord(letter))) % 1000000
        print(letter, position, ord(letter), hash_val)

    print(hash_val, txt)
