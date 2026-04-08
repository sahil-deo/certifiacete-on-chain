// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CertificateOnChain} from "../src/CertificateOnChain.sol";

contract CertificateOnChainScript is Script {
    CertificateOnChain public certificateOnChain;

    
    function run() public {
        vm.startBroadcast();

        certificateOnChain = new CertificateOnChain();

        vm.stopBroadcast();
    }
}
