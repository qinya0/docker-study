#!/bin/bash

image_names=$(curl -s  http://localhost:5000/v2/_catalog | awk -F'[[]' '{print $2}' |  awk -F'[]]' '{print $1}' | sed 's/\"//g' | sed 's/,/ /g')

for image_name in ${image_names[@]}
do
   image_tags=$(curl -s  http://localhost:5000/v2/${image_name}/tags/list  | awk -F'[[]' '{print $2}' |  awk -F'[]]' '{print $1}' | sed 's/\"//g' | sed 's/,/ /g')
   echo "$image_name"
   for image_tag in ${image_tags[@]}
   do
      echo "  - $image_tag"
   done
done
