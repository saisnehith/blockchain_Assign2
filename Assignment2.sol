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
    mapping(address => uint) pendingReturns;
    mapping(address => uint) answercount;
    address[] public userAddresses;
    
    constructor(uint _fee, uint _duration,string _a,string _e,string _b,string _f,string _c,string _g,string _d,string _h){
    timelimit = now + _duration * 10 seconds;
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
    
    function register() public payable
    {
        address _userAddress = msg.sender;
        require(userRegistered[_userAddress]==false && now<=timelimit && msg.value>=pfee);
        userRegistered[_userAddress]=true;
        userAddresses.push(_userAddress);
        numberOfUsers++;
        tfee += pfee;
        pendingReturns[_userAddress] = msg.value - pfee;
    }
    
    //time limit - Questions
    function requestquestions() public returns(string,string,string,string) {
        address _userAddress=msg.sender;
        require(userRegistered[_userAddress]==true && now>timelimit, "ERROR");
        return (q1,q2,q3,q4);
    }
    
    function _toLower(string str) internal returns (string) {
		bytes memory bStr = bytes(str);
		bytes memory bLower = new bytes(bStr.length);
		for (uint i = 0; i < bStr.length; i++) {
			// Uppercase character...
			if ((bStr[i] >= 65) && (bStr[i] <= 90)) {
				// So we add 32 to make it lowercase
				bLower[i] = bytes1(int(bStr[i]) + 32);
			} else {
				bLower[i] = bStr[i];
			}
		}
		return string(bLower);
    }
    
    function compareStrings (string a, string b) view returns (bool){
       return keccak256(a) == keccak256(b);
   }
    
    function submitAnswer(string a, string b, string c, string d){
        answercount[_userAddress] = 0;
        address _userAddress = msg.sender;
        require(userRegistered[_userAddress] == true, "Sorry not registered");     //Security Measure
        if(compareStrings(_toLower(a),_toLower(a1)) == true)
        {
            //pendingReturns[_userAddress] += (uint(3) / uint(16)) * tfee;
            
            answercount[_userAddress] += 1;
        }
        
        else if(compareStrings(_toLower(b),_toLower(a2)) == true)
        {
            //pendingReturns[_userAddress] += (uint(3) / uint(16)) * tfee;
            
            answercount[_userAddress] += 1;
        }
        
        else if(compareStrings(_toLower(c),_toLower(a3)) == true)
        {
            //pendingReturns[_userAddress] += (uint(3) / uint(16)) * tfee;
            
            answercount[_userAddress] += 1;
        }
        
        else if(compareStrings(_toLower(d),_toLower(a4)) == true)
        {
            //pendingReturns[_userAddress] += (uint(3) / uint(16)) * tfee;
            
            answercount[_userAddress] += 1;
        }
    }
    
    function decideWinnerandPayRest() 
    {
        for(uint i = 0; i < userAddresses.length; i++)   //To pay the pending returns for every participant
        {
            if(answercount[userAddresses[i]] == 1)
            {
                pendingReturns[userAddresses[i]] += (uint(3) / uint(16)) * tfee;
            }
            
            else if(answercount[userAddresses[i]] == 2)
            {
                pendingReturns[userAddresses[i]] += (uint(3) / uint(8)) * tfee;
            }
            
            else if(answercount[userAddresses[i]] == 3)
            {
                pendingReturns[userAddresses[i]] += (uint(9) / uint(16)) * tfee;
            }
            
            else if(answercount[userAddresses[i]] == 4)
            {
                pendingReturns[userAddresses[i]] += (uint(3) / uint(4)) * tfee;
                
                userWon[answercount[userAddresses[i]]] = userAddresses[i];
            }
        }
        
        uint max = 0;
        
        for(uint j = 0; j < userAddresses.length; j++)
        {
            max = answercount[userAddresses[j]];
            
            for(uint k = j + 1; k < userAddresses.length; k++)
            {
                if(answercount[userAddresses[k]] > max)
                {
                    max = answercount[userAddresses[k]];
                }
            }
        }
    }
}
