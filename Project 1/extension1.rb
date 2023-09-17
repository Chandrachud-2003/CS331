# CS 331 (Ying Li) Project 1, Fall 2023
# 09/17/2023
# Chandrachud Malali Gowda
# Extension 1: Implement the programming assignment using another programming language.
# How to Run: ruby extension1.rb <IP_address> <prefix_length>
# Requirements:
  # Local installation of ipaddress gem
    # mkdir gems
    # gem install ipaddress

require 'ipaddress'

ENV['GEM_PATH'] = "#{File.expand_path('.')}/gems"

# Function to check if the IP address is valid
def check_ip(ip)
  begin
    # Parse the IP address as IPv4
    IPAddress(ip)
    return true
  rescue IPAddress::InvalidAddressError => e
    puts "Error: #{e.message}"
    return false
  end
end

# Function to check if the prefix length is valid
def check_prefix(prefix)
  prefix >= 0 && prefix <= 32
end

# Function to calculate the subnet address
def subnet_address(ip, prefix)
  subnet = IPAddress("#{ip}/#{prefix}")
  subnet.network.to_s
end

# Function to calculate the first address that can be used for a host on the network
def first_address(ip, prefix)
    subnet = IPAddress("#{ip}/#{prefix}")
    first_usable = subnet.network.to_u32 + 1
    IPAddress::IPv4::parse_u32(first_usable).to_s
end
  

# Function to calculate the last address that can be used for a host on the network
def last_address(ip, prefix)
  subnet = IPAddress("#{ip}/#{prefix}")
  last_usable = subnet.broadcast.to_u32 - 1
  IPAddress::IPv4::parse_u32(last_usable).to_s
end

# Function to calculate the subnet broadcast address
def broadcast_address(ip, prefix)
  subnet = IPAddress("#{ip}/#{prefix}")
  subnet.broadcast.to_s
end

# Function to calculate the subnet mask
def subnet_mask(ip, prefix)
  subnet = IPAddress("#{ip}/#{prefix}")
  subnet.netmask.to_s
end

# Main function
def main
  # Checking if the correct number of command-line arguments are provided
  if ARGV.length != 2
    puts "Usage: ruby script.rb <IP_address> <prefix_length>"
    exit(1)
  end

  # Extracting the IP address and prefix length from command-line arguments
  ip = ARGV[0]
  prefix = ARGV[1].to_i

  # Printing the IP address and prefix length
  puts "IP address: #{ip}"
  puts "Prefix length: #{prefix}"

  # Checking if the IP address is valid
  unless check_ip(ip)
    puts "Invalid IP address"
    exit(1)
  end

  # Checking if the prefix length is valid
  unless check_prefix(prefix)
    puts "Invalid prefix length"
    exit(1)
  end

  # Printing the results
  puts "Subnet address: #{subnet_address(ip, prefix)}"
  puts "First address: #{first_address(ip, prefix)}"
  puts "Last address: #{last_address(ip, prefix)}"
  puts "Broadcast address: #{broadcast_address(ip, prefix)}"
  puts "Subnet mask: #{subnet_mask(ip, prefix)}"
end

if __FILE__ == $PROGRAM_NAME
  main
end
