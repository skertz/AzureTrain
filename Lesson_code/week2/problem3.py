import math
def mytuple(num):
    'Return my number, its square and its sine in a tuple'
    sq=num**2
    sn=math.sin(num)
    result = num, sq, sn 
    return result
for x in range(0,10):
   output=mytuple(x)
   print output
