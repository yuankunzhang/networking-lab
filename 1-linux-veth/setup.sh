#!/usr/bin/env bash

set -e

echo "Creating namespace NS1"
sudo ip netns add NS1

echo "Creating veth pair myveth ~ myveth-peer"
sudo ip link add myveth type veth peer name myveth-peer

echo "Putting one end (myveth-peer) of the veth pair to the namespace"
sudo ip link set myveth-peer netns NS1

echo "Enabling the interface on the host (myveth)"
sudo ip link set dev myveth up

echo "Enabling the interface inside the namespace (myveth-peer)"
sudo ip netns exec NS1 ip link set dev myveth-peer up

echo "Assiging IP address to the interface on the host (myveth)"
sudo ip addr add 192.168.10.10/24 dev myveth

echo "Assiging IP address to the interface inside the namespace (myveth-peer)"
sudo ip netns exec NS1 ip addr add 192.168.10.20/24 dev myveth-peer
