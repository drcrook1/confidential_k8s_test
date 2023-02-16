#!/bin/bash
docker inspect -f '{{.State.Pid}}' $1