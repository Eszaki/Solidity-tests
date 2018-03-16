pragma solidity ^0.4.0;

contract DNS {

    struct Record {
        string ip;
        address owner;
    }
    
    mapping (string => Record) records;
    
    uint256 public balance;
    uint256 public constant price = 0.01 ether;

    address public owner;
    
    function DNS() public {
        owner = msg.sender;
    }

    function register(string domain, string ip) public payable {
        require(records[domain].owner == address(0x0) ||
                records[domain].owner == msg.sender);
                
        require(msg.value == price);
        
        records[domain] = Record(ip, msg.sender);
        balance += msg.value;
    }
    
    function lookup(string domain) public constant returns (string) {
        return records[domain].ip;
    }
    
    function transfer(string domain, address new_owner) public {
        require(records[domain].owner == msg.sender);
        records[domain].owner = new_owner;
    }
    
    function withdraw() public {
        require(msg.sender == owner);
        uint256 amount = balance;
        balance = 0;
        owner.transfer(amount);
    }
    
}
