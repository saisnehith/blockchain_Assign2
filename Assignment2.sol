pragma solidity ^0.4.25;
contract Quiz{
    address QuizOwner;
    uint timelimit;
    uint numberOfUsers = 0;
    uint pfee;
    uint tfee = 0;
    string q1;
    string q2;
    string q3;
    string q4;
    string a1;
    string a2;
    string a3;
    string a4;
    mapping(address => bool) userRegistered;
    mapping(uint => address ) userWon; // The address of the user who first answered the question will be stored here.
    address[] public userAddresses;
    
    constructor(uint _fee, uint _duration,string _a,string _e,string _b,string _f,string _c,string _g,string _d,string _h){
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
    function askquestions() public returns(string,string,string,string) {
        address _userAddress=msg.sender;
        require(userRegistered[_userAddress]==true && now>timelimit);
        return (q1,q2,q3,q4);
    }
}
