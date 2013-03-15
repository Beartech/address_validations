# Address Validation Library

Some classes to manipulate and analyze street addresses.

## Installation

I have complied a gem, but not sure if it really works as there is no bin/executable. Can be used by just copying the contents
of /lib to your project.
## Features/Problems

## Usage

The code describes an AddressList class that takes a text file of addresses, one per line, and creates both an array containing
each line, and an array of hashes with each item being an address split into it's components. 
{:number => 24611, :name => '116', :suffix => 'TH', :type => 'AVE', :dir => 'SE'}

There are methods for the Address class that can add or remove the suffix, depending on what your dispatch system requires.
It can also produce text files of the address list, the list of hashed addresses, and a yaml file of all address hashes.

See the spec/rakefile for output usage.

## LICENSE

http://opensource.org/licenses/MIT.
