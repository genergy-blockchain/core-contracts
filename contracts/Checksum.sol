// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CensusSystem {
    struct Checksum {
        uint256 id;
        string verificationHash;
        string entityId;
        string createdAt;
    }

    address public owner;

    mapping(uint256 => Checksum) public checksums;
    
    event NewChecksumAdded(uint256 indexed id, string verificationHash, string entityId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addChecksum(uint256 _id, string memory _verificationHash, string memory _entityId) public onlyOwner {
        require(checksums[_id].id == 0, "Checksum with the provided ID already exists.");
        
        Checksum storage newChecksum = checksums[_id];
        newChecksum.id = _id;
        newChecksum.verificationHash = _verificationHash;
        newChecksum.entityId = _entityId;
        
        emit NewChecksumAdded(_id, _verificationHash, _entityId);
    }
    
    function getChecksumById(uint256 _id) public view returns (uint256, string memory, string memory, string memory) {
        require(checksums[_id].id != 0, "Checksum with the provided ID does not exist.");
        
        Checksum storage retrievedChecksum = checksums[_id];
        
        return (retrievedChecksum.id, retrievedChecksum.verificationHash, retrievedChecksum.entityId, retrievedChecksum.createdAt);
    }
}


