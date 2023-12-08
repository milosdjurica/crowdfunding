// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract Crowdfunding {
    error Crowdfunding__DeadlineShouldBeInFuture();

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
    uint public numberOfCampaigns = 0;

    constructor() {}

    function createCampaign(
        address _owner,
        string memory _title,
        string memory _description,
        uint _target,
        uint _deadline,
        string memory _image
    ) public returns (uint) {
        Campaign storage campaign = campaigns[numberOfCampaigns];
        if (campaign.deadline < block.timestamp)
            revert Crowdfunding__DeadlineShouldBeInFuture();

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;
        return numberOfCampaigns - 1;
    }

    function donateCampaign(uint _id) public payable {
        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(msg.value);

        (bool success, ) = payable(campaign.owner).call{value: msg.value}("");
        if (success) campaign.amountCollected += msg.value;
    }

    function getDonators(
        uint _id
    ) public view returns (address[] memory, uint[] memory) {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for (uint i = 0; i < numberOfCampaigns; i++) {
            allCampaigns[i] = campaigns[i];
        }
        return allCampaigns;
    }
}
