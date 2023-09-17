# CS 331 (Ying Li) Project 1, Fall 2023
# 09/17/2023
# Chandrachud Malali Gowda
# How to Run: python3 project1.py <IP_address> <prefix_length>

# Importing the required libraries
import sys
import ipaddress

# Function to check if the IP address is valid
def check_ip(ip):
    try:
        # Parse the IP address as IPv4
        ipaddress.IPv4Address(ip)
        return True
    except ipaddress.AddressValueError as e:
        print("Error:", e)
        return False
    
# Function to check if the prefix length is valid
def check_prefix(prefix):
    if (prefix >= 0 and prefix <= 32):
        return True
    else:
        return False
    
# Function to calculate the subnet address
def subnet_address(ip, prefix):
    subnet = ipaddress.ip_network(ip + '/' + str(prefix), strict=False)
    return subnet.network_address

# Function to calculate the first address that can be used for a host on the network
def first_address(ip, prefix):
    subnet = ipaddress.ip_network(ip + '/' + str(prefix), strict=False)
    return subnet[1]

# Function to calculate the last address that can be used for a host on the network
def last_address(ip, prefix):
    subnet = ipaddress.ip_network(ip + '/' + str(prefix), strict=False)
    return subnet[-2]

# Function to calculate the subnet broadcast address
def broadcast_address(ip, prefix):
    subnet = ipaddress.ip_network(ip + '/' + str(prefix), strict=False)
    return subnet.broadcast_address

# Function to calculate the subnet mask
def subnet_mask(ip, prefix):
    subnet = ipaddress.ip_network(ip + '/' + str(prefix), strict=False)
    return subnet.netmask

import sys

# Main function
def main():
    # Checking if the correct number of command-line arguments are provided
    if len(sys.argv) != 3:
        print("Usage: python script.py <IP_address> <prefix_length>")
        sys.exit(1)

    # Extracting the IP address and prefix length from command-line arguments
    ip = sys.argv[1]
    prefix = int(sys.argv[2])

    # Printing the IP address and prefix length
    print("IP address:", ip)
    print("Prefix length:", prefix)

    # Checking if the IP address is valid
    if not check_ip(ip):
        print("Invalid IP address")
        sys.exit(1)

    # Checking if the prefix length is valid
    if not check_prefix(prefix):
        print("Invalid prefix length")
        sys.exit(1)

    # Printing the results
    print("Subnet address:", subnet_address(ip, prefix))
    print("First address:", first_address(ip, prefix))
    print("Last address:", last_address(ip, prefix))
    print("Broadcast address:", broadcast_address(ip, prefix))
    print("Subnet mask:", subnet_mask(ip, prefix))

if __name__ == "__main__":
    main()
