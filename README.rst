==============
Geth on Docker
==============

*My Fork, done to suit my needs. Your mileage may vary*

This runs a container with private Ethereum chain with some precreated accounts
and balances. This is inspired by the `StackOverflow thread <http://ethereum.stackexchange.com/questions/1516/how-can-i-completely-automate-a-docker-image-and-dockerfile-for-a-geth-test-netw>`_ and fixing problems encountered on the way.

1. Build the container: ::

     make build


2. Run as standalone command for RPC use: ::

     make rpc

   Please note that the non-standard port (8110) is used for RPC server, so be sure to
   configure your client accordingly.


3. Run as part of docker-compose: ::

     geth:
       image: ethereum/client-go:test
       ports:
         - "8110:8110"


Miner address
=============

On launch the miner address will be printed. If you miss it, you can always open
keystore file located at ``./tmp/go-eth*/*`` and check the miner address.

Sending eth
===========

1. Get the miner address (see above)
2. Run ``make send-eth from=<miner_address> to=<receiver> value=<eth_hex_value>``

Example:  
``make send-eth from=0x8fd58fc34538603458a93b1923256e7b066e4478 to=0x60c56553495612d4b93b6BC1deffE937223eaF51 value=0x1080dccde6d3fd00``

Precreated accounts
===================

- ``de1e758511a7c67e7db93d1c23c1060a21db4615`` (initial balance: 1000 wei).
  This account is used as a coinbase for mining, so it will have plenty of ether
  fast.

- ``27dc8de9e9a1cb673543bd5fce89e83af09e228f`` (initial balance: 1100 wei)

- ``d64a66c28a6ae5150af5e7c34696502793b91ae7`` (initial balance: 900 wei)

All the accounts have the same passphrase: ``password``


Example: check balance with RPC call
====================================

You can run ``make test`` which is actually::

  curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x27dc8de9e9a1cb673543bd5fce89e83af09e228f", "latest"],"id":1}' 'localhost:8110'

The response should be: ::

  {"jsonrpc":"2.0","id":1,"result":"0x44c"}

(``0x44c`` is hex for ``1100``)
