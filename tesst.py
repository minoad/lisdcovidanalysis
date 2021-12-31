from inp import myfunc


def this_test(x):
    print(x.to_bytes())
    return(x)

if __name__ == '__main__':
    myfunc(this_test(1))