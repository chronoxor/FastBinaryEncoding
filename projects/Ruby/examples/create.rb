require_relative '../proto/proto'

# Create a new account using FBE model
account = Proto::AccountModel.new(FBE::WriteBuffer.new)
model_begin = account.create_begin
account_begin = account.model.set_begin
account.model.id.set(1)
account.model.name.set('Test')
account.model.state.set(Proto::State.good)
wallet_begin = account.model.wallet.set_begin
account.model.wallet.currency.set('USD')
account.model.wallet.amount.set(1000.0)
account.model.wallet.set_end(wallet_begin)
account.model.set_end(account_begin)
account.create_end(model_begin)
raise "Verify error!" unless account.verify

# Show the serialized FBE size
puts "FBE size: #{account.buffer.size}"

# Access the account using the FBE model
access = Proto::AccountModel.new(FBE::ReadBuffer.new)
access.attach_buffer(account.buffer)
raise "Verify error!" unless access.verify

account_begin = access.model.get_begin
id = access.model.id.get
name = access.model.name.get
state = access.model.state.get
wallet_begin = access.model.wallet.get_begin
wallet_currency = access.model.wallet.currency.get
wallet_amount = access.model.wallet.amount.get
access.model.wallet.get_end(wallet_begin)
access.model.get_end(account_begin)

# Show account content
puts
puts "account.id = #{id}"
puts "account.name = #{name}"
puts "account.state = #{state}"
puts "account.wallet.currency = #{wallet_currency}"
puts "account.wallet.amount = #{wallet_amount}"
