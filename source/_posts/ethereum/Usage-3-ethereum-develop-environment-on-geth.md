---
title: Usage (3) - ethereum develop environment on geth
copyright: true
date: 2019-07-25 18:20:38
categories:
    - ethereum
tags:
    - ethereum
    - 以太坊
    - private chain
    - 私链
    - 挖矿
    - mining
---
创建以太坊私链。    
为私链创建创世块。  
在私有链上挖矿。

<!-- more -->

Build a private chain for development.  
Config your genesis block first.

### **1. mkdir**

```
~:mkdir test
~:cd test
~;mkdir chain
```

### **2. genesis block config**

**test/genesis.json**
```
{
  "config": {
        "chainId": 10,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x4000",
  "extraData"  : "",
  "gasLimit"   : "0x8000000",
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00",
  "alloc": {}
}
```

### **3. init and generate your genesis block for your private chain**

```
~:geth init ./genesis.json --datadir "./chain"
```

+ #### 3.1 geth commands
    ```
    account           Manage accounts
    attach            Start an interactive JavaScript environment (connect to node)
    bug               opens a window to report a bug on the geth repo
    console           Start an interactive JavaScript environment
    copydb            Create a local chain from a target chaindata folder
    dump              Dump a specific block from storage
    dumpconfig        Show configuration values
    export            Export blockchain into file
    export-preimages  Export the preimage database into an RLP stream
    import            Import a blockchain file
    import-preimages  Import the preimage database from an RLP stream
    init              Bootstrap and initialize a new genesis block
    js                Execute the specified JavaScript files
    license           Display license information
    makecache         Generate ethash verification cache (for testing)
    makedag           Generate ethash mining DAG (for testing)
    monitor           Monitor and visualize node metrics
    removedb          Remove blockchain and state databases
    version           Print version numbers
    wallet            Manage Ethereum presale wallets
    help, h           Shows a list of commands or help for one command

    ```

### **4. start your private chain and open a console for interactive**

```
~:geth --datadir "./chain" --networkid 15 --nodiscover --maxpeers 0 console
```

+ #### 4.1 usage

    1) create account

        ```
        >personal.newAccount()
        ```

    2) account list

        ```
        > eth.accounts
        ```

    3) balance of account

        ```
        > eth.getBalance(eth.accounts[0])
        0
        ```

    4) mining

        ```
        >miner.start()
        ```
        percenage=100 is successful.
        ```
        >miner.stop()
        ```

    5) exit

        ```
        >exit
        ```

    6) send money

        Unlock account and send 3 wei from address_A to address_B
        ```
        >personal.unlockAccount("address_A","123")
        >eth.sendTransaction({from:"address_A",to:"address_B",value:web3.toWei(3,"ether")})
        ```