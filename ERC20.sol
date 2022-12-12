pragma solidity ^0.8.13;

contract ERC20{
    event Approval(address  tokenOwner, address  spender, uint tokens);
    event Transfer(address  from, address  to, uint tokens);
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    
    string private name = "TestCoin";
    string private symbol = "TC";
    uint8 private decimals = 8;
    uint256 public total = 0;

    
     
    function getName() public view returns (string memory){
        return name;
    }
    function getSymbol() public view returns (string memory){
        return symbol;
    }
    function getDecimals() public view returns (uint8){
        return decimals;
    }

    function totalSupply() public view returns (uint256){
        return total;
    }
    function mint(address receiver, uint amount) public {
            balances[receiver] +=amount;
            total +=amount;
    }
    function reward(address receiver, uint trongSo,  uint amount) public {
            if(trongSo !=0){
            balances[receiver] +=amount;
            total +=amount;}
    }
    function burn(address sender, uint amount) public {
            balances[sender] -=amount;
            total -=amount;
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
// 6 quy tắc bắt buộc
// TotalSupply: Hiển thị thông tin về nguồn cung, tổng số lượng Token có thể được tạo ra.
// BalanceOf: Hiển thị số dư tài khoản Token mà chủ sở hữu đang có.
// Transfer: Giao dịch chuyển một số lượng Token nhất định từ ví của người dùng này sang người dùng khác.
// TransferFrom: Chuyển từ tài khoản này sang tài khoản khác một số lượng token được chỉ định từ một địa chỉ nhất định.
// Approve: Cho phép người dùng được quyền rút một số lượng Token từ một tài khoản được chỉ định. 
//Ngoài ra còn giúp đối chiếu giao dịch, giới hạn số lượng Token được rút ra từ ví để tránh bị đánh cắp.
// Allowance: Cho phép kiểm tra số dư của người dùng đồng thời trả về một số lượng Token 
//được thiết lập sẵn từ ví của người dùng.

// 3 quy tắc tùy chỉnh
// Token Name: Tên token.
// Symbol: Mã token.
// Decimal (up to 18): Số thập phân nhỏ nhất.

//https://link.springer.com/content/pdf/10.1007/s00500-021-06496-5.pdf?pdf=button
