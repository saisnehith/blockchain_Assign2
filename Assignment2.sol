pragma solidity ^0.4.24;
contract Quiz{
    address QuizOwner;
    uint timelimit;
    uint numberOfUsers = 0;
    uint pfee;
    uint index = 0;
    uint tfee = 0;
    uint perf = 0;
    string q1;
    string q2;
    string q3;
    string q4;
    string a1;
    string a2;
    string a3;
    string a4;
    string str;
    mapping(address => bool) userRegistered;
    mapping(address => string) answeredcorrectlyq1;
    mapping(address => string) answeredcorrectlyq2;
    mapping(address => string) answeredcorrectlyq3;
    mapping(address => string) answeredcorrectlyq4;
    mapping(uint => address ) userWon; // The address of the user who first answered the question will be stored here.
    mapping(address => uint) pendingReturns;
    mapping(uint => uint) usercount;
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
    
    function test1() returns (uint)
    {
        address _userAddress = msg.sender;
        return pendingReturns[_userAddress];
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
        address _userAddress = msg.sender;
        //answercount[_userAddress] = 0;
        require(userRegistered[_userAddress] == true, "Sorry not registered");     //Security Measure
        if(compareStrings(_toLower(a),_toLower(a1)) == true)
        {
            //answercount[_userAddress] += 1;
            //index[0] += 1;
            usercount[0] += 1;
            answeredcorrectlyq1[_userAddress] = "YES";
        }
        
        else
        {
            answeredcorrectlyq1[_userAddress] = "NO";   
            usercount[0] = 1;
        }
        
        if(compareStrings(_toLower(b),_toLower(a2)) == true)
        {
            //answercount[_userAddress] += 1;
            usercount[1] += 1;
            //index[1] += 1;
            answeredcorrectlyq2[_userAddress] = "YES";
        }
        
        else
        {
            answeredcorrectlyq2[_userAddress] = "NO";
            usercount[1] = 1;
        }
        
        if(compareStrings(_toLower(c),_toLower(a3)) == true)
        {
            //answercount[_userAddress] += 1;
            usercount[2] += 1;
            //index[2] += 2;
            answeredcorrectlyq3[_userAddress] = "YES";
        }
        
        else
        {
            answeredcorrectlyq3[_userAddress] = "NO";
            usercount[2] = 1;
        }
        
        if(compareStrings(_toLower(d),_toLower(a4)) == true)
        {
            //answercount[_userAddress] += 1;
            usercount[3] += 1;
            //index[3] += 1;
            answeredcorrectlyq4[_userAddress] = "YES";
        }
        
        else
        {
            answeredcorrectlyq4[_userAddress] = "NO";
            usercount[3] = 1;
        }
    }
    
    function decideWinnerandPayRest()
    {   
        require(msg.sender == QuizOwner);
        
        for(uint i = 0; i < userAddresses.length; i++)   //To pay the pending returns for every participant
        {
            if(compareStrings(answeredcorrectlyq1[userAddresses[i]],"YES"))
            {
                pendingReturns[userAddresses[i]] += (3 * tfee) / (16 * usercount[0]);
            
                perf++;
            }
            
            if(compareStrings(answeredcorrectlyq2[userAddresses[i]],"YES"))
            {
                pendingReturns[userAddresses[i]] += (3 * tfee) / (16 * usercount[1]);
            
                perf++;
            }
            
            if(compareStrings(answeredcorrectlyq3[userAddresses[i]],"YES"))
            {
                pendingReturns[userAddresses[i]] += (3 * tfee) / (16 * usercount[2]);
                
                perf++;
            }
            
            if(compareStrings(answeredcorrectlyq4[userAddresses[i]],"YES"))
            {
                pendingReturns[userAddresses[i]] += (3 * tfee) / (16 * usercount[3]);
                
                perf++;
            }
            
            if(perf == 4)
            {
                userWon[index++] = userAddresses[i];
            }
            
        }
    }
    
    function withdraw() public returns(bool)
    {
        uint amount = pendingReturns[msg.sender];
        
        if(amount > 0)
        {
            pendingReturns[msg.sender] = 0;
            
            msg.sender.transfer(amount);
        }
        
        return true;
    }
    
    function test() public returns(uint)
    {
        address _userAddress = msg.sender;
        
        return pendingReturns[_userAddress];
    }
    
    function get_player()
    public view returns(uint a){
        return numberOfUsers;
    }

    function get_question()
    public view returns(string a, string b, string c, string d){
        return (a,b,c,d);
    }

    function get_lower()
    public view returns(string a){
        str = _toLower("SaHiL");
        return (str);
    }

    function get_answer()
    public view returns(uint a){
        submitAnswer("Max", "22", "Male", "No");
        return usercount[0];
    }
    function get_answer1()
    public view returns(uint a){
        submitAnswer("Max", "22", "Male", "No");
        return usercount[1];
    }
    function get_answer2()
    public view returns(uint a){
        submitAnswer("Max", "22", "Male", "No");
        return usercount[2];
    }
    function get_answer3()
    public view returns(uint a){
        submitAnswer("Max", "22", "Male", "No");
        return usercount[3];
    }

    function get_winner()
    public view returns(uint a){
        submitAnswer("Max", "22", "Male", "No");
        decideWinnerandPayRest();
        return perf;
    }
    function get_winner1()
    public view returns(uint a){
        submitAnswer("Max", "22", "Male", "No");
        decideWinnerandPayRest();
        return index;
    }

    function get_withdraw()
    public view returns(uint a){
        withdraw();
        return pendingReturns[msg.sender];
    }
}
