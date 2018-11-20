# Environment variables for tests. Source this file before running them.
#
# Tests use environment variables rather than an INI file because it matches
# how the tests also would be run from within RIOT.

BASEDIR=$(dirname $0)
cd $BASEDIR
echo "PWD: $(pwd)"

export RIOTBASE=$(pwd)/../../RIOT
export AIOCOAP_BASE=$(pwd)/aiocoap
export SOSCOAP_BASE=$(pwd)/soscoap
export PYTHONPATH="${SOSCOAP_BASE}"

[ ! -d $AIOCOAP_BASE ] && {
    echo " . cloning aiocoap"
    git clone https://github.com/chrysn/aiocoap
}

[ ! -d $SOSCOAP_BASE ] && {
    echo " . cloning soscoap"
    git clone https://github.com/kb2ma/soscoap
}

[ ! -d $RIOTBASE ] && {
    echo " ! RIOT repo is missing,  not found in $RIOTBASE"
    return
}

echo " . creating tap devices"
$RIOTBASE/dist/tools/tapsetup/tapsetup
echo " . set IP address "
sudo ip addr add fd00:bbbb::1/64 dev tapbr0
