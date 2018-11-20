*** Settings ***
Library         ExpectHost  %{RIOTBASE}/examples/cord_ep    make term       WITH NAME  CordEP
Library         ExpectHost  %{AIOCOAP_BASE}                 ./aiocoap-rd    WITH NAME  CoapRD

Test Setup      Run Keywords    CordEP.connect
...                             CoapRD.connect

Test Teardown   Run Keywords    CordEP.disconnect
...                             CoapRD.disconnect

*** Test Cases ***
Cord Register Should Succeed
    [Documentation]     Register a CoAP endpoint with a CoAP resource directory.
    Sleep   2   Wait for initialization
    CordEP.send recv    ifconfig 7 add unicast fd00:bbbb::2/64  success:
    CordEP.send recv    cord_ep register [fd00:bbbb::1]         registration successful
