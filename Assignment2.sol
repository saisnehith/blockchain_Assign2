pragma solidity ^0.4.25;
contract Quiz{
    address QuizOwner;
    uint timelimit;
    uint numberOfUsers = 0;
    uint pfee;
    uint tfee = 0;
    bytes q1;
    bytes q2;
    bytes q3;
    bytes q4;
    mapping(address => bool) userRegistered;
    mapping(uint => address ) userWon; // The address of the user who first answered the question will be stored here.
    address[] public userAddresses;
    
    constructor(uint _fee, uint _duration,bytes _a,bytes _b,bytes _c,bytes _d){
    timelimit = now + _duration * 1 minutes;
    pfee = _fee;
    QuizOwner=msg.sender;
    q1=_a;
    q2=_b;
    q3=_c;
    q4=_d;
    }
    
    function register() public payable {
        address _userAddress = msg.sender;
        require(userRegistered[_userAddress]==false && now<=timelimit && msg.value>=pfee);
        userRegistered[_userAddress]=true;
        userAddresses.push(_userAddress);
        numberOfUsers++;
        tfee += msg.value;
    }
    
    //time limit - Questions
    function askquestions() public returns(bytes,bytes,bytes,bytes) {
        address _userAddress=msg.sender;
        require(userRegistered[_userAddress]==true && now>timelimit);
        return (q1,q2,q3,q4);
    }
}
