import json
import random
import string
from pathlib import Path  # this is the path for the json file





class Bank:

    database = 'data.json'

    data = []



    try:

        with open(database) as fs:
            data = json.loads(fs.read())
    except Exception as err:

        print(f"an exception occured as {err}")



    @classmethod

    def __update(cls):
        with open(cls.database, 'w') as fs:

            fs.write(json.dumps(Bank.data, indent=4))



    @classmethod

    def __accountgenrerate(cls):
        alpha=random.choices(string.ascii_letters,k=3)
        num=random.choices(string.digits,k=3)
        spchar=random.choices("!@#$&*",k=1)
        id= alpha+num+spchar
        random.shuffle(id)
        return"".join(id)





    def Createaccount(self):

        info = {

            "name": input("Tell your name :-"),
            "age": int(input("Enter your age :-")),
            "email": input("Enter your email :-"),
            "pin": int(input("Tell your pin :-")),
            "accountNo.": Bank.__accountgenrerate() ,                  
            "balance": 0

        }

       

        if info['age'] < 18 or len(str(info['pin'])) != 4:
            print("sorry you can't create your account :(")

        else:

            print("account has been created successfully")
            for i in info:

                print(f"{i}: {info[i]}")
            print("please note down your account number")  



            Bank.data.append(info)
            Bank.__update()



    def depositmoney(self):
        accnumber = input("Please tell me your account number :-")
        pin = int(input("please tell me your account pin :-"))  # Converted pin to int to match info['pin']



        userdata = [i for i in Bank.data if i['accountNo.'] == accnumber and i['pin'] == pin]
        if  not userdata:
            print("sorry no data found")



        else:

            amount = int(input("how much do you want to deposit :-"))
            if amount>100000 or amount<0:
                print("sorry the amount is too much :)")

            

            else:
                userdata[0]['balance']+= amount  # Access index [0] to modify the dictionary
                Bank.__update()
                print("Amount deposited succesfully")







user = Bank()  # object of bank class



print("Press 1 for creating an account")
print("press 2 for depositing the money in the bank ")
print("press 3 for withdrawing the money")
print("press 4 for details")
print("press 5 for updating the details ")
print("press 6 for deleting your account ")



check = int(input("Tell your response :-"))

if check == 1:
    user.Createaccount()

if check == 2:
 user.depositmoney()
