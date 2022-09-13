// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {
    mapping (address => uint256) private balances;
    mapping (address => mapping(address=>uint256)) private allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimal;

    constructor() payable public{
        _name = "DREAM";
        _symbol = "DRM";
        _decimal = 18;
        _totalSupply = 100 ether;
        balances[msg.sender] = 100 ether;
    }
    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
       return _symbol;
    }   

    function decimals() public view returns (uint8) {
       return _decimal;
    }

    function totalSupply() public view returns (uint256) {
      return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(msg.sender != address(0), "transfer from the zero address");
        require(_to != address(0), "transfer to the zero address");
        require(balances[msg.sender] >= _value, "value exceeds balance");
        
        if(balances[msg.sender]>= _value && _value > 0){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        }
        else{
            return false;
        }
        
        
        
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) {
        require(msg.sender != address(0), "transfer from the zero address");
        require(_to != address(0), "transfer to the zero address");
        require(balances[_from] >= _value, "value exceeds balance");

        if(balances[_from]>= _value){
            balances[_from] -= _value; 
            balances[_to] += _value;        
            allowances[_from][_to] -= _value; 
            return true;
        }else{
            return false;
        }
    }

    function approve(address _to, uint256 _value) public returns (bool sucess) {
        allowances[msg.sender][_to]=_value;
        return true;
    }

    function allowance(address _from, address _to) public returns (uint256 _value) {
        return allowances[_from][_to];
    }
    function _mint(address _from, uint256 _value) public { //총 발행 토큰량을 증가시키고
        require(_from != address(0), "transfer from the zero address");
        balances[_from] += _value;
        _totalSupply += _value;  
    }
    function _burn(address _from, uint256 _value) public { //총발행 토큰량을 감소시켜라
        balances[_from] -= _value;
        _totalSupply -= _value;   
    }
} //가시성 측면은 최대한 private로 선언하는게 보안상 좋다.(이에대한 강요하는 측면은 없다.)
