#!/bin/sh
for f in test/*.jl; do julia -E "include(\"$f\")"; done