# def login(func):
#     def wrapper():
#         print("Hello I am started")
#         func()
#         print("ended with modification")
#     return wrapper()

# @login
# def greet():
#     print("Good Morning")


# text = 'I am data engineer'
#write a python program to find duplicate alphabetes

# def find_duplicates(text):
#     seen = set()
#     dup = []
#     for i in text:
#         if i in seen:
#             dup.append(i)
#         else:
#             seen.add(i)
    # return dup

# print(find_duplicates(text))


dict1 = {
 'a':1,
 'b':2
}

dict2 = {
    'a':10,
    'd':20,
}

dict3 = dict1 | dict2
print(dict3)
