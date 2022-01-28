#!/bin/sh
set -ux;

DOMAIN_NAME=`grep "DOMAIN_NAME=" ./srcs/.env | sed -e "s/^.*=//"`
HOSTS_PATH=/etc/hosts

grep -v "#" "${HOSTS_PATH}" | grep "${DOMAIN_NAME}";
if [ $? -eq 0 ]; then
	echo "Delete ${DOMAIN_NAME} in ${HOSTS_PATH}"
	sed -ie "/127.0.0.1	${DOMAIN_NAME}/d" "${HOSTS_PATH}"
	echo "Complete!!"
else
	echo "${DOMAIN_NAME} not found in ${HOSTS_PATH}"
fi
