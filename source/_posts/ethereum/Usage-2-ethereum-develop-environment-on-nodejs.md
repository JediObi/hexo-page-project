---
title: Usage (2) - ethereum develop environment on nodejs
copyright: true
date: 2019-07-25 18:11:01
categories:
    - ethereum
tags:
    - ethereum
    - 以太坊
    - nodejs
    - rpc
    - contract
    - 智能合约
---
配置以太坊nodejs开发环境。  
使用truffle调用以太坊rpc接口。  
发布一个只能合约并测试。

<!-- more -->

## (1) install truffle and testrpc

```
~:sudo npm i -g truffle
~:sudo npm i -g ethereumjs-testrpc
```

Maybe you need to make soft link of the package.

```
~:sudo ln -s /usr/local/bin/node-8.xx/bin/truffle /usr/local/bin/truffle
~:sudo ln -s /usr/local/bin/node-8.xx/bin/testrpc /usr/local/bin/testrpc
```

## (2) start development

+ #### start testnet by testrpc

    `testrpc` will just build a temporary block chain in RAM.       
    The development environment doesn't need the huge testnet data like rinkeby.        
    It will create ten accounts.
    ```
    ~:testrpc
    ```

+ #### init project

    ```
    ~:mkdir test_contract
    ~:cd test_contract
    ~:truffle init
    ```

    Some new files and directories will be generated.

    ```
    .
    ├── contracts   // directory of contracts
    ├── migrations  // deploy script
    ├── test  // test script
    ├── truffle-config.js
    └── truffle.js  // config file, u can use truffle-conif.js or this.
    ```

+ #### config network to deploy contract

    truffle.js  
    Here we use two network.    
    ```
    module.exports = {
    networks: {
            development: {
                host: "localhost",
                port: 8545,
                network_id: "*" // 匹配任何network id
            }
        },
    live: {
        host: "178.25.19.88", // Random IP for example purposes (do not use)
        port: 80,
        network_id: 1,        // Ethereum public network
        // optional config values:
        // gas  Gas limit used for deploys. Default is 4712388
        // gasPrice Gas price used for deploys. Default is 100000000000 (100 Shannon).
        // from - default address to use for any transaction Truffle makes during migrations
        // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
        //          - if specified, host and port are ignored.
    }
    };
    ```

+ #### modify a new contract

    ```
    ~:cd contracts
    ~:vim MyContract.js
    ```

    Mycontract.js

    ```
    pragma solidity ^0.4.4;
    contract MyTest {
        function multiply(uint a) public pure returns(uint d) {
            return a * 7;
        }

        function say() public pure returns (string) {
            return "Hello Contract";
    }
    }
    ```

    Input a, return a*7.    
    `pure` like const after method.

+ #### compile and deploy

    1. modify deploy script.    

        migrations/1_initial_migration.js
        ```js
        var Migrations = artifacts.require("./Migrations.sol");
        var MyTest = artifacts.require("./MyTest.sol");

        module.exports = function(deployer) {
        deployer.deploy(Migrations);
        deployer.deploy(MyTest);
        };
        ```

    2. compile

        ```
        ~:truffle compile --compile-all
        ```
        `--compile-all` do not use hot compile. Hot compile will only compile the file modified from since compiling.
        This command will compile contracts in contracts directory and put the result in build directory.

    3. deploy

        ```
        ~:truffle migrate --reset
        ```
        `--reset` do not use hot migrate. Hot migrate will only deploy new js file in build directory.  
        `--network <network_name>` specify the network to deploy. You can config more than one network in config file.

    4. test

        Enter in truffle console.
        ```
        ~:truffle console
        truffle(development)> var contract;
        undefined

        truffle(development)> MyTest.deployed().then(function(instance){contract= instance;});
        undefined

        truffle(development)> 
        undefined

        truffle(development)> 
        undefined

        truffle(development)> contract.multiply(3)
        { [String: '21'] s: 1, e: 1, c: [ 21 ] }

        truffle(development)> 
        undefined

        truffle(development)> contract.say()
        'Hello Contract'
        ```
        Enter `.exit` to leave console.

    5. automatic test
    
        Automatic test script files are in test directory.
        We can use `truffle test` to run these scripts.
        A test script example.  

        + test/Example.js
            ``` 
            pragma solidity ^0.4.0;  

            import "truffle/Assert.sol";  
            import "truffle/DeployedAddresses.sol";  
            import "../contracts/MyTest.sol";  

            contract TestMyTest {    
                    uint someValue;  
                    uint value;  
                    function testmultiply(){  
                        someValue=3;  
                        MyTest aaa=MyTest(DeployedAddresses.MyTest());  
                        value = aaa.multiply(someValue);  
                        uint expected = 21;  
                        Assert.equal(value, expected, "should 3*7=21");  
                    }
            }   
            ```
        + run test
            ```
            ~:truffle test
            Using network 'development'.

            Compiling ./contracts/MyTest.sol...
            Compiling ./test/TestMyTest.sol...
            Compiling truffle/Assert.sol...
            Compiling truffle/DeployedAddresses.sol...


            TestMyTest
                ✓ testmultiply (83ms)


            1 passing (548ms)
            ```
