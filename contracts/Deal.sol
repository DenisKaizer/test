pragma solidity ^0.4.15;

import "./Structures.sol";

contract DealFactoty {

  function createDeal(){
    return new Deal(title, text, attachments, endDate);

  }
}

contract Deal {

  string public title;
  string public description;
  string public attachments;
  string public endDate;

  address customer;
  address executor;

  bool adopted = false;

  uint deposit;

  Acceptations.CustomerAccept customerAccept = Acceptations.CustomerAccept({accepted: _adr, id: _id });
  Acceptations.ExecutorAccept executorAccept = Acceptations.ExecutorAccept({adr: _adr, id: _id });

  modifier depositeniugh {
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

  function Deal(string _title, string _description, string _attachments, string _endDate, address _executor){
    title = _title;
    description = _description;
    attachments = _attachments;
    endDate = _endDate;
    executor = _executor;

  }

  function editDeal(string item, string update){
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

  function adopt() onlyExecutor {
    adopted = true;
  }
}
