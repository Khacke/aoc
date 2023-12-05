#!/usr/bin/env python

# test_text = """1abc2
# pqr3stu8vwx
# a1b2c3d4e5f
# treb7uchet"""

def read_file(path):
    with open(path, "r") as f:
        return [line for line in f]
text = read_file("input.txt")

# part 1

# result = 0
# for row in text:
#     first = 0
#     last = 0
#     for c in row:
#         if c.isnumeric():
#             if first == 0:
#                 first = c
#             last = c
#     result += int(str(first)+str(last))
# print(result)


# test_text = """two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen"""

dict = {
    "one":"1",
    "two":"2",
    "three":"3",
    "four":"4",
    "five":"5",
    "six":"6",
    "seven":"7",
    "eight":"8",
    "nine":"9"
}

res = 0
print(text)
for row in text:
    first = 0
    last = 0
    sb = ""
    for c in row.strip():
        sb+=c
        for key,val in dict.items():
            sb = sb.replace(key, val)
    for c in sb:
        if c.isnumeric():
            if first == 0:
                first = c
            last = c

    #print(f"Row: {sb}")
    #print(f"First: {first}, Last: {last}")
    #print(f"res: {res}, change:+{int(str(first) + str(last))}")
    res += int(str(first) + str(last))

print(res)