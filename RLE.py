import numpy as np
import cv2
import json
# from bitarray import bitarray
from bitarray import bitarray
from bitarray.util import int2ba


def decompress():
    a = bitarray()
    with open('compressed', 'rb') as fh:
        a.fromfile(fh)
    # read first bit value
    for i in range(0, 3):
        print(a[16 * i: 16 * (i + 1)])



def rlencode(x, dropna=False):
    
    where = np.flatnonzero
    x = np.asarray(x)
    n = len(x)
    if n == 0:
        return (np.array([], dtype=int), 
                np.array([], dtype=int), 
                np.array([], dtype=x.dtype))

    starts = np.r_[0, where(~np.isclose(x[1:], x[:-1], equal_nan=True)) + 1]
    lengths = np.diff(np.r_[starts, n])
    values = x[starts]
    return starts, lengths, values

def compress_image(image : str):
    # compress image
    img = cv2.imread(image)

    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # get height and width 
    h, w = img.shape

    x = img.flatten()
    a = bitarray()

    for i in x:
        j = int(i)
        a.extend(int2ba(j, length=8))

    bitList = a.tolist()

    # print(len(x)*8, ' = ', len(bitList))
    starts, lengths, values = rlencode(bitList)
    # print(max(lengths))
    # print("lengths: ", len(lengths))

    f = open('./compressedImage', 'wb')

    bit = bitarray(int2ba(a[0], length=16))
    bit.tofile(f)
    # print(bit)
    bitList = []

    # add new line
    bitList = int2ba(10, length=8)
    bitList.tofile(f)

    a = bitarray()


    for l in lengths:
        i = int(l)
        bitList = int2ba(i, length=16)
        bitList.tofile(f)
        # add new line
        bitList = int2ba(10, length=8)
        bitList.tofile(f)
    f.close()


def compress_cnn(file : str):
    f = open(file)
    data = json.load(f)
    f.close()
    
    a = bitarray()
    for key in data:
        bt = bitarray()
        
        bt.append((data[key] < 0))
        
        vi = abs(int(data[key]))

        vf = abs(int((data[key] - vi) * 10000))
        
        if vf >= 2048:
            vf = vf // 10

        bt.extend(int2ba(vi, length=4))
        bt.extend(int2ba(vf, length=11))

        a.extend(bt)

    bitList = a.tolist()

    starts, lengths, values = rlencode(bitList)

    f = open('./compressedCNN', 'wb')

    bit = bitarray(int2ba(a[0], length=16))
    bit.tofile(f)
    # print(bit)
    bitList = []

    # add new line
    bitList = int2ba(10, length=8)
    bitList.tofile(f)

    a = bitarray()


    for l in lengths:
        i = int(l)
        bitList = int2ba(i, length=16)
        bitList.tofile(f)
        # add new line
        bitList = int2ba(10, length=8)
        bitList.tofile(f)
    f.close()


compress_cnn('./cnn.json')
compress_image('./train_0.bmp')
