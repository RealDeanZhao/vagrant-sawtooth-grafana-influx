#!/bin/bash
sawtooth keygen jack
sawtooth keygen jill
sawtooth keygen john
while [ 1 -eq 1 ]
do
  xo create my-game-$RANDOM --username jack
done