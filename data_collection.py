import serial
from datetime import datetime

serial_port = "COM3"
baud_rate = 115200 ;#In arduino, Serial.begin(baud_rate)
write_to_file_path = "C://users//shoun//OneDrive//Documents//MATLAB//3104_project//Mateye//demo.txt"

output_file = open(write_to_file_path, "w")
ser = serial.Serial(serial_port, baud_rate)
time = datetime.now().strftime('%H:%M:%S.%f')[:-3]
print(time)


while True:
    line = ser.readline()
    line = line.decode("utf-8"); #ser.readline returns a binary, convert to string
    t = datetime.now().strftime("%H:%M:%S.%f")[:-3]
    output_file.write(t)
    output_file.write(",")
    output_file.write(line)
