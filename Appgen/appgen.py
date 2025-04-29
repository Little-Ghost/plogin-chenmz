import os, random, time

version="2.10.11"

wd = "."

os.chdir(wd)

upper = "QWERTYUIOPASDFGHJKLZXCVBNM"
lower = "qwertyuiopasdfghjklzxcvbnm"
digit = "1234567890"


B2Eapp='Bat_To_Exe_Converter.exe'

def sig_gen(source=upper + lower + digit, length=20):
    return ''.join(random.choices(source, k=length))


def hamming_D(chaine1, chaine2):
    return sum(c1 != c2 for c1, c2 in zip(chaine1, chaine2))


def register(username, syn=True):
    with open('rhost.txt', 'r+', encoding='utf-8') as rf:
        H = dict([line.strip().split(',') for line in rf.readlines()])

        sigs = H.values()
        usrs = H.keys()

        while username in usrs:
            print('There is an user with the same name already in the registration.')
            choice = input("Continue? ([Y]/N)")
            if choice in "Yy" or choice == "":
                username = input('Please assign a new name for fully discrimination.')
            else:
                print('Abort.')
                return

        hds = [0]

        while min(hds) <= 15:
            new_sig = sig_gen()
            hds = [hamming_D(new_sig, term) for term in sigs]
        
        rf.write(f"{username},{new_sig}\n")

    if syn:
        os.system("syn_rhost.bat")

    return new_sig


def read_user(name):
    with open("rhost_machine.txt", 'r', encoding='utf-8') as mf:
        machines = [line.strip().split(',') for line in mf.readlines()]

    match = filter(lambda x: x[0]==name, machines)

    try:
        return next(match)
    except StopIteration:
        raise ValueError("Username does not exist.")


def make_app(username, hostname, mac):
    try:
        line = ','.join(read_user(username)) + "\n"
    except ValueError:
        option=input("New user detected. Check in? ([Y]/N)")
        if option in "Yy" or option == "":
            with open('rhost_machine.txt', 'a+', encoding='utf-8') as mf:
                mf.write(f"{username},{hostname},{mac}\n")

    print('Starting to make a new client app.')
    time.sleep(1)

    with open('rhost.txt', 'r', encoding='utf-8') as rf:
        H = dict([line.split(',') for line in rf.readlines()])

    sig = H.get(username)

    if not sig:
        choice = input("Username not registered. Sign in one? ([Y]/N)")
        if choice == '' or choice in 'Yy':
            sig = register(username)
        else:
            print('Abort.')
            return

    split_line = ':: User-info\n'
    
    with open("LoginT3.bat.tmp", 'r', encoding='utf-8') as lf:
        script = lf.read()

    script = script.replace('Do not run this script!\n', '')

    former, set_info, latter = script.split(split_line)
    set_info = set_info.format(hostname, mac, sig)

    os.chdir('usr')

    BAT = f"LoginT3-{username}-{version}.bat"
    EXE = f"LoginT3-{username}-{version}.exe"

    with open(BAT, 'w', encoding='utf-8') as bf:
        bf.write(former)
        bf.write(set_info)
        bf.write(latter)

    os.system(f"{B2Eapp} /bat {BAT} /exe {EXE}")
    print('Done.')
    os.chdir(wd)

if __name__ == "__main__":
    username = "ZhangSan"
    rhost = "Laptop-1122334455"
    rmac = "ABCDEFG"
    make_app(username, rhost, rmac)
    
    

