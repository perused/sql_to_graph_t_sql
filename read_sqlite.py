with open("battle_death/battle_death.sqlite", "rb") as fp:
    contents = fp.readlines()
    for line in contents:
        print(line.strip())