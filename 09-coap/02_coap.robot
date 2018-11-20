*** Settings ***
Library         ExpectHost  %{RIOTBASE}/examples/gcoap    make term  timeout=${100}  WITH NAME  CoAP
Library         ExpectHost  %{PWD}   ./con_ignore_server.py -i 2    WITH NAME  RS2
Library         ExpectHost  %{PWD}   ./con_ignore_server.py -i 5    WITH NAME  RS5

Test Setup      CoAP.connect
Test Teardown   CoAP.disconnect

Variables       test_vars.py

*** Test Cases ***
Recover
    [Documentation]     Recover from 2 ignored requests and receive time value.
    CoAP.send recv      ifconfig 6 add unicast fd00:bbbb::2/64      success:
    RS2.connect
    CoAP.send recv      coap get -c fd00:bbbb::1 5683 /time         ${REGEXP}
    RS2.disconnect

Timeout
    [Documentation]     Times out from 5 ignored requests.
    CoAP.send recv      ifconfig 6 add unicast fd00:bbbb::2/64      success:
    RS5.connect
    Run Keyword And Expect Error  TIMEOUT*  CoAP.send recv  coap get -c fd00:bbbb::1 5683 /time  ${REGEXP}
    RS5.disconnect
