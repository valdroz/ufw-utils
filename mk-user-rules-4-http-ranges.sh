#!/usr/bin/env bash

_in_file=$1

_out_file=user.rules

if [ ! -f "${_in_file}" ]; then
  echo "File ${_in_file} does not exist"
  exit -1
fi

> $_out_file

_size=$(cat $_in_file | wc -l)

while read _line; do

        echo $_line >> $_out_file

        if [ "$_line" == "### RULES ###" ]; then

                echo "" >> $_out_file

                _i=0
                for _ipr in $(cat $_in_file); do

                        _i=$((_i+1))
                        printf "\r${_i}:${_size}"

                        echo "### tuple ### allow any 80 0.0.0.0/0 any $_ipr in" >> $_out_file
                        echo "-A ufw-user-input -p tcp --dport 80 -s $_ipr -j ACCEPT" >> $_out_file
                        echo "-A ufw-user-input -p udp --dport 80 -s $_ipr -j ACCEPT" >> $_out_file
                        echo "" >> $_out_file
                        echo "### tuple ### allow any 443 0.0.0.0/0 any $_ipr in" >> $_out_file
                        echo "-A ufw-user-input -p tcp --dport 443 -s $_ipr -j ACCEPT" >> $_out_file
                        echo "-A ufw-user-input -p udp --dport 443 -s $_ipr -j ACCEPT" >> $_out_file
                        echo "" >> $_out_file

                done
                printf "\n"

                echo "### tuple ### deny tcp 80 0.0.0.0/0 any 0.0.0.0/0 in" >> $_out_file
                echo "-A ufw-user-input -p tcp --dport 80 -j DROP" >> $_out_file
                echo "" >> $_out_file
                echo "### tuple ### deny tcp 443 0.0.0.0/0 any 0.0.0.0/0 in" >> $_out_file
                echo "-A ufw-user-input -p tcp --dport 443 -j DROP" >> $_out_file
                echo "" >> $_out_file

        fi

done < /etc/ufw/user.rules
