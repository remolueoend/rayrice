# Command Wiki

## Capture traffic of docker container in Wireshark
> wireshark, docker, container
* Get name of interface via following commands:
  ```sh
  link_id=$(docker exec -ti <container id> cat /sys/class/net/eth0/iflink)
  ip link | grep $link_id
  ```
* Interface should be listed in Wireshark while container is running.

