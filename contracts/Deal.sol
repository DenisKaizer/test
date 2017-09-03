pragma solidity ^0.4.15;

import "./Structures.sol";

contract DealFactoty {

  function createDeal(){
    return new Deal(title, text, attachments, endDate);
  }
}

contract Deal {

  mapping (string => bool) executorConfirms;
  mapping (string => bool) customerConfirms;

  string public title;
  string public description;
  string public attachments;
  string public endDate;

  address customer;
  address executor;

  bool accepted = false;
  bool depositEnough = false;

  uint deposit;

  modifier depositenough {
    require(this.balance == deposit);
    _;
  }

  modifier onlyExecutor {
    require(msg.sender == executor);
    _;
  }

  modifier onlyCustomer {
    require(msg.sender == customer);
    _;
  }

  modifier onlyMember {
    require(msg.sender == customer);
    _;
  }

  function () payable {}

  function Deal(string _title, string _description, string _attachments,
  string _endDate, address _executor, address _customer, uint _deposit){
    title = _title;
    description = _description;
    attachments = _attachments;
    endDate = _endDate;
    executor = _executor;
    customer = _customer;
    deposit = _deposit;

  }

  function editDeal(string item, string update) {
    if (item == "title"){
      title = update;
    }
    if (item == "description"){
      description = update;
    }
    if (item == "attachments"){
      attachments = update;
    }
    if (item == "endDate"){
      endDate = update;
    }
  }

  function startDeal() depositenough onlyMember {
    if (msg.sender == customer) {
      required(executorConfirm);
    }
    else{
      required(customerConfirm);
    }
    required(now <= endDate);
  }

  //function editDeposit(uint newDeposit){}

  function() payable{}

  // Executor accepts the terms of deal
  function accept() onlyExecutor {
    accepted = true;
  }

  // customer confirm the execution of the function
  function customerConfirm(string _func, bool answer) onlyCustomer{
    customerConfirms[_func] = answer;
  }

  // executor confirm the execution of the function
  function executorConfirm(string _func, bool answer) onlyExecutor{
    executorConfirms[_func] = answer;
  }

  function checkConfirmation(string _member, string _func) internal{
    if (_member == 'executor'){
      return executorConfirms[_func];
    }
    if (_member == 'customer'){
      return customerConfirms[_func];
    }
  }
}
