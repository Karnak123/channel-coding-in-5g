#!/bin/sh
echo 
for f in test/*.jl; do julia -E "include(\"$f\")"; done