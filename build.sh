#!/bin/bash

echo "Cleaning up..."
rm -rf _site
echo "Building site..."
awestruct -P production
echo "DONE!"

