import random
upper="QWERTYUIOPASDFGHJKLZXCVBNM"
lower="qwertyuiopasdfghjklzxcvbnm"
digit="1234567890"
symbl="!@#$%^&*()_+-=[]{}\|;:<>,.?/"

code_scope = [lower, digit]

pw_table = []

for cs in code_scope:
    pw_table += random.choices(cs, k=random.randint(3, 5))

new_pw = "".join(pw_table)
print(new_pw)
