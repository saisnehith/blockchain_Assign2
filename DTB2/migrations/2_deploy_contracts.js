var Quizzer = artifacts.require("./Quiz.sol");

module.exports = function(deployer) {
  deployer.deploy(Quizzer,100,1,"Name","Max","Age","22","Sex","Male","Family","No");
};
