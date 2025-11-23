#!/bin/bash

# Usage: ./cidr.sh <CIDR>
# Example: ./cidr.sh 141.193.213.0/24

cidr=$1

if [ -z "$cidr" ]; then
  echo "Usage: $0 <CIDR>"
  exit 1
fi

# Split IP and mask
ip=$(echo "$cidr" | cut -d/ -f1)
mask=$(echo "$cidr" | cut -d/ -f2)

# Convert IP to integer
ip2int() {
  local IFS=.
  read -r i1 i2 i3 i4 <<< "$1"
  echo $(((i1 << 24) + (i2 << 16) + (i3 << 8) + i4))
}

# Convert integer back to IP
int2ip() {
  local ip=$1
  echo "$(( (ip >> 24) & 255 )).$(( (ip >> 16) & 255 )).$(( (ip >> 8) & 255 )).$(( ip & 255 ))"
}

# Calculate network and broadcast
ip_int=$(ip2int "$ip")
mask_int=$(( 0xFFFFFFFF << (32 - mask) & 0xFFFFFFFF ))
network=$(( ip_int & mask_int ))
broadcast=$(( network | (~mask_int & 0xFFFFFFFF) ))

# Print usable IPs (skip network and broadcast)
for ((i=network+1; i<broadcast; i++)); do
  int2ip $i
done
