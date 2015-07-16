import serial

BAUDRATE = 115200
PARITY=serial.PARITY_NONE
STOPBITS=1
DATABITS=8

def readwrite(ser, data_in='0'):
    '''
    ser: Serial port
    data: data string to send
    '''
    ser.write(data_in)
    return ser.read(size=100)

if __name__=='__main__':
    ser = serial.Serial('/dev/ttyUSB0', BAUDRATE, bytesize=DATABITS,
                        timeout=0.005,
                        parity=PARITY,stopbits=STOPBITS,rtscts=True)
    data_in = 'Hey I can read and write!'
    data_out = readwrite(ser,data_in)
    print(data_out)
