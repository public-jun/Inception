#!/bin/sh

# set DOMAIN_NAME
DOMAIN_NAME=`grep "DOMAIN_NAME=" ../../.env | sed -e "s/^.*=//"`
HOSTS_PATH=/etc/hosts

if [ "${#DOMAIN_NAME}" -eq 0 ]; then
	echo "DOMAIN_NAME not found in .env"
	exit 1
fi

grep -v "#" "${HOSTS_PATH}" | grep "${DOMAIN_NAME}";
if [ $? -ne 0 ]; then
	echo "${DOMAIN_NAME} not found in ${HOSTS_PATH}"
	echo "Add ${DOMAIN_NAME} ..."
	sed -i 1i"127.0.0.1	${DOMAIN_NAME}" "${HOSTS_PATH}"
	echo "${DOMAIN_NAME} complete!"
else
	echo "${DOMAIN_NAME} found in ${HOSTS_PATH}"
fi
