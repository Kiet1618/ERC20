    pragma solidity ^0.8.13;

    contract ERC20{
        event Approval(address  tokenOwner, address  spender, uint tokens);
        event Transfer(address  from, address  to, uint tokens);
        mapping(address => uint256) balances;
        mapping(address => mapping (address => uint256)) allowed;

        string public name = "Sollasido";
        string public symbol = "Sol";
        uint8 public decimals = 8;

        function totalSupply() public view returns (uint256){
            return 21000;
        }
        function balanceOf(address _owner) public view returns (uint256 balance){
        balance =  balances[_owner];
        return balance;
        }
        function transfer(address _to, uint256 _value) public returns (bool success){
            require(_value <= balances[msg.sender]);
            balances[msg.sender] = balances[msg.sender] - _value;
            balances[_to] = balances[_to] + _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
            require(_value <= balances[_from]);
            require(_value <= allowed[_from][msg.sender]);
            balances[_from] = balances[_from] - _value;
            allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
            balances[_to] = balances[_to] + _value;
            emit Transfer(_from, _to, _value);
            return true;
        }
        function approve(address _spender, uint256 _value) public returns (bool success){
            allowed[msg.sender][_spender] = _value;
            emit Approval(msg.sender, _spender, _value);
            return true;
        }
        function allowance(address _owner, address _spender) public view returns (uint256 remaining){
            return allowed[_owner][_spender];
        }
    }
