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
    bytes a1;
    bytes a2;
    bytes a3;
    bytes a4;
    mapping(address => bool) userRegistered;
    mapping(uint => address ) userWon; // The address of the user who first answered the question will be stored here.
    address[] public userAddresses;
    
    constructor(uint _fee, uint _duration,bytes _a,bytes _e,bytes _b,bytes _f,bytes _c,bytes _g,bytes _d,bytes _h){
    timelimit = now + _duration * 1 minutes;
    pfee = _fee;
    QuizOwner=msg.sender;
    q1=_a;
    q2=_b;
    q3=_c;
    q4=_d;
    a1=_e;
    a2=_f;
    a3=_g;
    a4=_h;
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
