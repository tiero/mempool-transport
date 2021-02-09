# Mempool as transport for unstoppable messaging 

This repository serves the needs for exploring semi-decentralized messaging network. This exploits the Bitcoin mempool as a p2p network and the default minimum relay fee configuration option of Bitcoin core. This allows anyone with very little effort to be part of this special network wich the ultimate goal is entirely to relay messages.

## Default minimum relay fee

The `minrelaytxfee` specifies a feerate acting as a lower bound for a node's mempool. A node will not admit unconfirmed transactions below that feerate to its mempool and thus will not relay them to its peers. The `minrelaytxfee` is a configuration setting and can be specified by each node operator independently. The value only impacts unconfirmed transactions, transactions included in a block are processed even when they do not meet the `minrelaytxfee`

## Memory pool limiting

Bitcoin Core 0.12 will have a strict maximum size on the mempool. The default value is 300 MB and can be configured with the `maxmempool` parameter. Whenever a transaction would cause the mempool to exceed its maximum size, the transaction that (along with in-mempool descendants) has the lowest total feerate (as a package) will be evicted and the node’s effective minimum relay feerate will be increased to match this feerate plus the initial minimum relay feerate. The initial minimum relay feerate is set to 1000 satoshis per kB.

# Run the demo

## Requirements

* Docker/compose
* Make
* `jq` bash utility



## Start bitcoin nodes

This will start-up three nodes, Alice and Bob patched with `-minrelaytxfee=0` and `Charlie` unpatched

```sh
$ docker-compose up
```

## Send a message 

This will embed in an OP_RETURN "Ocelot rocks!" and will spend the whole utxo versus a well known address. 
This tx will never get mined, in the eventuality one miner gets crazy, better to put an address controlled by the sender or to embed an amount you actually want to send to someone.

```sh
$ make send
```

## Retrieve info about the mempools of nodes


Charlie will not relay the transaction in the mempool, only Alice and Bob with thei relay fee policy will.
```sh
$ make info
```

## Tear down

```sh
$ docker-compose down
```