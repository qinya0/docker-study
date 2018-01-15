#!/bin/bash

ip=${1:-"localhost"}
port=${2:-"5000"}

base_url="http://$ip:$port/v2"

image_names=$(curl -s  ${base_url}/_catalog | awk -F'[[]' '{print $2}' |  awk -F'[]]' '{print $1}' | sed 's/\"//g' | sed 's/,/ /g')

for image_name in ${image_names[@]}
do
   image_tags=$(curl -s  ${base_url}/${image_name}/tags/list  | awk -F'[[]' '{print $2}' |  awk -F'[]]' '{print $1}' | sed 's/\"//g' | sed 's/,/ /g')
   tag_num=$(echo ${image_tags[*]} |  sed 's/ /\n/g'  |wc -l)
   echo "$image_name: ${tag_num}"
   for image_tag in ${image_tags[@]}
   do
      echo "  - $image_tag"
   done
done
