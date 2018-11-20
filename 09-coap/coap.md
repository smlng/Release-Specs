## Goal: Send/Receive typical CoAP messages

Introduction
============
These tests exercise RIOT's CoAP implementations, [gcoap and nanocoap](https://github.com/RIOT-OS/RIOT/wiki/CoAP-Home). The tests are automated with the use of [pytest](https://pytest.org/).

With all of these tests, your confidence in the results will increase by watching the CoAP messages in Wireshark.

These tests all were developed using native on a recent Ubuntu Linux. However, they all may be run just as well on hardware.

Materials
---------

In addition to pytest, you'll need a recent copy of these projects:

* [aiocoap](https://github.com/chrysn/aiocoap)
* [soscoap](https://github.com/kb2ma/soscoap)

The _Setup_ section below assumes these projects are installed in source code form, not with pip or setup.py.

Setup
-----

Before running any test you need to setup the environment, e.g. certain path
variables and the above mentioned dependencies. Just run the following script
which will do everything:
```Bash
    $ . setup_env.sh
```

*Note* The script assumes that the RIOT repository is on the same folder level
or hierarchy as the Release-Specs repository.

Running the tests
-----------------
You can run all tests in this directory with a single invocation as follows:

```Bash
    $ python3 -m robot *.robot
```


Task #01 - CORD Endpoint
========================
### Description

gcoap client registers with an aiocoap CORE Resource Directory server.
### Result

Registration succeeds.

### Details

Exercises confirmable client messaging, including Uri-Query and Location-Path options.


Task #02 - Confirmable retries
==============================
### Description

gcoap retries CON GET requests to an soscoap server. The soscoap server is instrumented to ignore a configurable number of requests before responding with the expected ACK.

### Result
Results depend on the particular test. Either:

* gcoap receives the server response and stops resending messages
* gcoap does not receive a server response, gives up and reports the timeout.

### Details
gcoap attempts a maximum of four retries; five messages altogether including the initial request. The retries are timed with CoAP's exponential backoff mechanism.
