# Dockerized iotaledger-iri

This is a containerized iotaledger-iri from iotaledger. The goal of this guide is to help you use docker to setup your own full node which can be used by a iota lite-wallet client. Make IOTA Great Again.

Detail installation guides

```
http://iota.partners/
```

## IRI Version

iotaledger-iri :  1.4.1.6 Release

## Official iotaledger-iri

https://github.com/iotaledger/iri

## Minimal System Requirement

- 4 Core
- 4GB Ram
- 20GB HD space

## Database

Download current database snapshots to speedup sync progress. This should only be done if you have a fresh node without any data.

> Note: current database is roughly 7~10GB

[DATABASE](http://db.iota.partners/IOTA.partners-mainnetdb.tar.gz)


## Add Neighbor

Full nodes requires neighbors. Goto the #nodesharing on slack for more information. If you can't find any neighbors then you can try adding swarm nodes. 

Slack Channel 
```
https://iotatangle.slack.com
```

Forum
```
https://forum.helloiota.com/1156/Add-Neighbor
```

- Recommand number of neighbors 3-5. Exceeding this number could be stressful for your node. 

## Command line for testing your node. Most commonly used commands

After your full node is up and running, you can use the following curl command to query node information.

Get Node Information
```
curl -s http://localhost:14265 -X POST -H 'X-IOTA-API-Version: 1' -H 'Content-Type: application/json' -d '{"command": "getNodeInfo"}'
```

Get Neighbors
```
curl -s http://localhost:14265 -X POST -H 'X-IOTA-API-Version: 1' -H 'Content-Type: application/json' -d '{"command": "getNeighbors"}'
```

Add Neighbor
```
curl -s http://localhost:14265 -X POST -H 'X-IOTA-API-Version: 1' -H 'Content-Type: application/json' -d "{"command": "addNeighbors", "uris": ["tcp://neighborIP:port"]}"
```

Remove Neighbor
```
curl -s http://localhost:14265 -X POST -H 'X-IOTA-API-Version: 1' -H 'Content-Type: application/json' -d "{"command": "removeNeighbors", "uris": ["tcp://neighborIP:port"]}"
```

# Disabled command error

Command is limited by REMOTE_LIMIT_API 

```
{"error":"COMMAND getNodeInfo is not available on this node","duration":27}
```

# Sync time

Estimate sync time varies based on neighbor quality and system spec. With downloaded DB, it could be as quick as 1~2hrs for full sync. Fresh node sync with neighbor without DB could take more than 5 days. 

# Iota Peer Manager (IPM)

This is a graphical user inteface that can be used on your full node and lets you add neighbors and see neighbor status. 

- https://github.com/carbonsphere/iota-ipm

## Swarm Nodes

These nodes will add you after a while, it is better to use a real neighbor. These nodes are good for fresh nodes that didn't have existing DB.

Note, these nodes are not fully synced.

> udp://88.99.249.250:41041
> udp://94.156.128.15:14600
> udp://185.181.8.149:14600

Ex:

```
curl -s http://localhost:14265 -X POST -H 'X-IOTA-API-Version: 1' -H 'Content-Type: application/json' -d "{"command": "addNeighbors", "uris": ["udp://88.99.249.250:41041"]}"
```

## Environment Variables

- API_PORT    : This port is used for lite-wallet/Curl/Node peer manager to connect.

- TCP_PORT    : TCP neighboring.

- UDP_PORT    : UDP neighboring

- MAX_MEMORY  : Set Max memory allocation for iri 

- MIN_MEMORY  : Set Min memory allocation for iri

- REMOTE_LIMIT_API : Disables certain commands. 

Ex: attachToTangle

> attachToTangle uses iri server to do proof of work which is very CPU intensive. If you are running a public node, please disable attachToTangle and all of the neighboring commands. 

Ex:
```
-e REMOTE_LIMIT_API='attachToTangle,addNeighbors,removeNeighbors,getNodeInfo'
```

## Setup

1. $ mkdir iotaledger

2. $ cd iotaledger

3. download DB and extract to ./db directory

4. create ixi directory  $ mkdir ixi

5. copy iota.ini from github. Modify iota.ini if you have existing neighbor. If not, you can just leave it empty then add your neighbors after server has started with curl command. 

- Note: By adding neighbor during runtime will not save neighbor listing. If server restarts, then you will loose all your neighbor if not correctly added into ini file.

6. run docker

```
docker run -d --name iota --net=host -e MAX_MEMORY=4G -e MIN_MEMORY=1G -e UDP_PORT=14666 -p 14666:14666/udp -e API_PORT=14265 -p 14265:14265 -e TCP_PORT=15666 -p 15666:15666 -e REMOTE_LIMIT_API='attachToTangle' -v $(pwd)/db:/iri/db -v $(pwd)/ixi:/iri/ixi -v $(pwd)/iota.ini:/iri/iota.ini carbonsphere/iotaledger-iri
```

OSX 

```
docker run -d --name iota -e MAX_MEMORY=4G -e MIN_MEMORY=1G -e UDP_PORT=14666 -p 14666:14666/udp -e API_PORT=14265 -p 14265:14265 -e TCP_PORT=15666 -p 15666:15666 -e REMOTE_LIMIT_API='attachToTangle' -v $(pwd)/db:/iri/db -v $(pwd)/ixi:/iri/ixi -v $(pwd)/iota.ini:/iri/iota.ini carbonsphere/iotaledger-iri
```

Example above uses a predefined UDP/TCP/API port. You can take those out if you are using default build in variables.


# Donation Address

If it works for you, please consider donating.

Every bit helps. Thanks!

- BTC: 395vsb41m46voFyhrgYMh6TauWKmNqJAtm
- ETH: 0xB205A4560BBc9840b80d36245333401E65d4f05e
- XMR: 46duR7umVuuCaAeVc27L1aXk4vJikNm81Xf2YbRkxDU3Nz69gTporVjbNkia6wkHc2BfYcH2xYPBY6m9t7AVQZU61dWmFro
- IOTA: FBIDRYFZKSYNGQICJTPPYAFUKYGCEVLCKHPKAXHLBGXJ9ENVRYYIYEMVQHIK9GNXFVILHYAKKPVBQSNTCBCKVPDM9Z

# Buy ETH or BTC with USD / Credit Card from CoinBase.com to get Free $10 BTC

Buy your cryptos now!!!

- [CoinBase](https://www.coinbase.com/join/59fd2b2af2e50b01171a4ae6)

# Binance Exchange

Exchange your cryptos. Reliable and fast!

- [Binance](https://www.binance.com/?ref=11217913)


