import numpy as np
import time

my_array = np.arange(100).reshape(10,10)

def change_my_array():
    global my_array
    my_array = np.arange(100).reshape(10,10)

if __name__ == "__main__":
    while(True):
        time.sleep(5)
        change_my_array()
