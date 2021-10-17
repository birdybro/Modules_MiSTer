# Ultimate CRC
by Geir Drange - January 14, 2016

## Description

Ultimate CRC is a CRC generator/checker. Using generics the core can be fully customized. It creates a function of the data input and the CRC register using XOR-logic. Although the levels of logic gets very high for wide data inputs, the throughput still benefits from this architecture, as can be seen from the synthesis page.

## Features

* Executes in one clock cycle per data word
* Any polynomial from 4 to 32 bits
* Any data width from 1 to 256 bits
* Any initialization value
* Synchronous or asynchronous reset