var Quiz = artifacts.require('Quiz')
var assert = require('assert')

let contractCall
   contract('Quiz',  (accounts) => {
    var n = new Array()
    for(i = 0; i < 15; i++) {
        n[i] = accounts[i];
    }
    for(l = 0; l < 2; l++) {
        const z = l;
    it('Check if the user is getting registered', async() => {
        contractCall = await Quiz.deployed()
        var count1 = await contractCall.get_player()
        await contractCall.register({from: n[z], value: web3.toWei(0.000000000001,'ether')});
        var count2 = await contractCall.get_player()
        assert.equal(count1.c[0] + 1, count2.c[0], 'User registration is unsuccessful')
    })
    }
    
    it('Check if the requested questions are being given', async() => {
        function fun(){
            for(time = 0; time < 1000000000; time++);
        }
        await fun();

        // var count1 = await contractCall.requestquestions();
        await contractCall.requestquestions({from: n[1]});
        //var count2 = await contractCall.get_player()
        // assert.equal(count1.c[0], "Name", 'User registration is unsuccessful')
    })

    it('Check if the string is being converted to lowercase', async() => {
        //contractCall = await Quiz.deployed()
        var str = "SaHiL"
        var lstr = await contractCall.get_lower();
        assert.equal(lstr, "sahil", 'String is not being converted to lowercase')
    })

    it('Check if submit answer 1 is working properly', async() => {
        var usr = 1
        var cusr = await contractCall.get_answer();
        assert.equal(cusr, 1, 'Submit answer function is not working properly')
    })

    it('Check if submit answer 2 is working properly', async() => {
        var usr = 1
        var cusr = await contractCall.get_answer1();
        assert.equal(cusr, 1, 'Submit answer function is not working properly')
    })

    it('Check if submit answer 3 is working properly', async() => {
        var usr = 1
        var cusr = await contractCall.get_answer2();
        assert.equal(cusr, 1, 'Submit answer function is not working properly')
    })

    it('Check if submit answer 4 is working properly', async() => {
        var usr = 1
        var cusr = await contractCall.get_answer3();
        assert.equal(cusr, 1, 'Submit answer function is not working properly')
    })

    it('Check if winner is being decided properly', async() => {
        var p = 4
        var win = await contractCall.get_winner();
        assert.equal(win, p, 'Winner is not being decided correctly')
    })

    it('Check if winner index is being incremented properly', async() => {
        var p = 2
        var win = await contractCall.get_winner1();
        assert.equal(win, p, 'Winner is not being decided correctly')
    })

    it('Check if withdraw function is able to transfer pending returns', async() => {
        var check = 0
        var returns = await contractCall.get_withdraw();
        assert.equal(check, returns, 'Withdraw is not working correctly')
    })
})
