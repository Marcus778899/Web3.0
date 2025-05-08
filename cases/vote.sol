// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Vote {
    address private owner;
    uint8 constant MAX_VOTES_PER_PERSON = 2;

    mapping(address => uint8) private votesUsed;
    mapping(bytes32 => uint) private receivedVotes;
    mapping(address => mapping(bytes32 => bool)) private hasVotedFor;
    mapping(bytes32 => bool) private isValidCandidate;
    bytes32[] private candidates;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        bytes32 candidateKey = stringToBytes32(_name);
        require(!isValidCandidate[candidateKey], "Already exists");

        isValidCandidate[candidateKey] = true;
        candidates.push(candidateKey);
    }

    function vote(string memory _name) public {
        bytes32 candidateKey = stringToBytes32(_name);
        require(isValidCandidate[candidateKey], "Invalid candidate");
        require(!hasVotedFor[msg.sender][candidateKey], "Already voted for this candidate");
        require(votesUsed[msg.sender] < MAX_VOTES_PER_PERSON, "Exceeds vote limit");

        hasVotedFor[msg.sender][candidateKey] = true;
        votesUsed[msg.sender]++;
        receivedVotes[candidateKey]++;
    }

    function getAllVotes() public view returns (string[] memory names, uint[] memory counts) {
        uint len = candidates.length;
        names = new string[](len);
        counts = new uint[](len);

        for (uint i = 0; i < len; i++) {
            bytes32 key = candidates[i];
            names[i] = bytes32ToString(key);
            counts[i] = receivedVotes[key];
        }
    }

    function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
        bytes memory temp = bytes(source);
        require(temp.length <= 32, "Name too long");
        assembly {
            result := mload(add(source, 32))
        }
    }

    function bytes32ToString(bytes32 _bytes32) internal pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0){
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for(uint8 j = 0; j < i; j++){
            bytesArray[j] = _bytes32[j];
        }
        return string(bytesArray);
    }
}
