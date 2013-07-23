
class Account
  attr_reader :balance

  def balance=(new_balance)
    @balance = new_balance
    @cleared_balance = @balance
  end

  def initialize(balance)
    @balance = balance
    @cleared_balance = balance
  end

  attr_reader :cleared_balance
  protected :cleared_balance
  # accessor method 'cleared_balance'
  # but make it protected
  def greater_balance_than?(other)
    @cleared_balance > other.cleared_balance
  end

end
#______________________________________________________________
class Transaction
  def initialize(account_a, account_b)
    @account_a = account_a
    @account_b = account_b
  end

private

  def debit(account, amount)
    account.balance -= amount
  end
  def credit(account, amount)
    account.balance += amount
  end

public
  #..
  def transfer(amount)
    debit(@account_a, amount)
    credit(@account_b, amount)
  end
  #..
end


savings = Account.new(1000)
checking = Account.new(200)
trans = Transaction.new(checking, savings)
trans.transfer(50)
p savings
p checking
p savings.greater_balance_than?(checking)

