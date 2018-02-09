import math
def mytuple(num):
    'Return my number, its square and its sine in a tuple'
    sq=num**2
    sn=math.sin(num)
    result = num, sq, sn 
    return result
infile = open('input.txt')
outfile = open('output.txt','w')
for line in infile:
   conv_num = int(line)
   output=mytuple(conv_num)
   outfile.write(str(output))
   outfile.write("\n")
infile.close()
outfile.close()

