#!/usr/bin/env bash

set -e
set -o pipefail

TPNFILE=../THIRD_PARTY_NOTICES.txt

DEPENDENCIES=(
    azure-storage-python
    https://github.com/Azure/azure-storage-python
    https://github.com/Azure/azure-storage-python/raw/master/LICENSE.txt
    bitstring
    https://github.com/scott-griffiths/bitstring
    https://github.com/scott-griffiths/bitstring/raw/master/LICENSE
    click
    https://github.com/pallets/click
    https://github.com/pallets/click/raw/master/LICENSE
    cryptography
    https://github.com/pyca/cryptography
    https://github.com/pyca/cryptography/raw/master/LICENSE.BSD
    future
    https://github.com/PythonCharmers/python-future
    https://github.com/PythonCharmers/python-future/raw/master/LICENSE.txt
    Python
    https://python.org
    https://github.com/python/cpython/raw/master/LICENSE
    python-dateutil
    https://github.com/dateutil/dateutil
    https://github.com/dateutil/dateutil/raw/master/LICENSE
    requests
    https://github.com/requests/requests
    https://github.com/requests/requests/raw/master/LICENSE
    ruamel.yaml
    https://bitbucket.org/ruamel/yaml
    https://bitbucket.org/ruamel/yaml/raw/aea7d3ed00153263b5aa3ff5dd7b5a0658bf8ae7/LICENSE
)
DEPLEN=${#DEPENDENCIES[@]}

add_attribution() {
    name=$1
    url=$2
    license=$(curl -fSsL $3)

    echo "" >> $TPNFILE
    echo "-------------------------------------------------------------------------------" >> $TPNFILE
    echo "" >> $TPNFILE
    echo "$name ($url)" >> $TPNFILE
    echo "" >> $TPNFILE
    echo "$license" >> $TPNFILE
}

cat << 'EOF' > $TPNFILE
Do Not Translate or Localize

This file is based on or incorporates material from the projects listed
below (Third Party IP). The original copyright notice and the license under
which Microsoft received such Third Party IP, are set forth below. Such
licenses and notices are provided for informational purposes only. Microsoft
licenses the Third Party IP to you under the licensing terms for the
Microsoft product. Microsoft reserves all other rights not expressly
granted under this agreement, whether by implication, estoppel or otherwise.
EOF

echo -n "Generating $(($DEPLEN / 3)) attributions: ["
i=0
while [ $i -lt $DEPLEN ]; do
    add_attribution ${DEPENDENCIES[$i]} ${DEPENDENCIES[$(($i+1))]} ${DEPENDENCIES[$(($i+2))]}
    i=$(($i + 3))
    echo -n "."
done
echo "" >> $TPNFILE
echo "-------------------------------------------------------------------------------" >> $TPNFILE
echo "] done."
