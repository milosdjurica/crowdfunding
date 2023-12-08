// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract Crowdfunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint amountCollected;
        string image;
        address[] donators;
        uint[] donations;
    }

    mapping(uint => Campaign) public campaigns;
    uint public numberOfCampaigns;

    constructor() {}
}
