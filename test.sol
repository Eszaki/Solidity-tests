pragma solidity ^0.4.0;

contract mortal {
    address owner;
    function mortal() public {
        owner = msg.sender;
    }
    function kill() public {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }
}

contract test is mortal {
    string testing;
    function tester(string _testing) public {
        testing = _testing;
    }
    function test() public constant returns (string) {
        return testing;
    }
}
