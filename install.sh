#!/bin/bash

declare path_var=$PATH

echo "$path_var:$(pwd)"
export PATH=$PATH:$(pwd)
