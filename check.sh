#!/bin/bash

script -q -c 'sshpass -p secret ssh -t git@localhost | grep "fatal: Interactive git shell is not enabled." || exit 1'

