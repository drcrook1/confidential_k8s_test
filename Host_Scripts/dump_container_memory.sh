#!/usr/bin/env bash
#
# Generate core dumps of docker container processes
#
# Usage:
#  ./dump_docker_memory.sh [containerid]
#
# Output directory will be created in /tmp
#
set -eo pipefail
containerid=$1
if [[ "$containerid" = "" ]]; then
echo "Usage: $0 [containerid]"
exit 1
fi
dir="/tmp/${containerid}"
mkdir -p "${dir}"
rm -f $dir/core.*
pushd $dir
echo
echo "Finding process ID for ${containerid}..."
pid=$(docker inspect "${containerid}" | grep '"Pid"' | head -n1 | awk -F':' '{print $2}' | sed 's/[^0-9]//g')
if [[ "$pid" = "0" ]]; then
echo "Container ${containerid} is not running."
exit 1
fi
echo

echo "dumping memory for container process: $pid ..."
gcore $pid

echo "Looking for child processes..."
children=$(pstree -p $pid | awk -F'}' '{print $2}' | sed 's/[^0-9]*//g')
for child in $children; do
echo
echo "Dumping for pid ${child}..."
	gcore $child
done
echo
echo "Dumps are available in ${dir}:"
ls -la ${dir}/core.*
echo

#docker inspect -f '{{.State.Pid}}'
#docker inspect "${containerid}" | grep '"Pid"' | head -n1 | awk -F':' '{print $2}' | sed 's/[^0-9]//g'