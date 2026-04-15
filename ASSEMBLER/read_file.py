
# f is an iterator
with open("assembly.txt") as f:
    for line in f:
        print(line)
        op_data = line.split(" ")

        operation = op_data[0]

        data = op_data[1].split(",")
        last_data = data[len(data) - 1].split(";")[0]
        data[len(data) - 1] = last_data
        
        print(data)


