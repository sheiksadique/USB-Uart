# USB-Uart
Verilog module for USB UART interface with RTS/CTS hardware handshake protocol

This is a part of my verilog learning experience.
Most of this project has been derived from http://www.fpga4fun.com/SerialInterface.html
The module has been adapted to take care of RTS/CTS handshaking.

It has been implemented on the Xilinx SPARTAN-6 FPGA SP605 evaluation kit.

# Known issues
This code was tested on SP605 evaluation kit in loopback mode where the
deserializer loops back to the serializer.
 - Baud rate of 115200
 - FPGA clock speed of 200 MHz 

Increasing the clock frequency from 27mhz to 100mhz didn't show any significant
improvement in data quality. Perhaps decreasing the baudrate will lower data
corruption issues.

Cause - still unknown 
Possible location - deserialization module (UART_RX.v)

