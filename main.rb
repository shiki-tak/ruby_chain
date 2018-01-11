require_relative 'ruby_chain/block_chain'
require_relative 'ruby_chain/miner'

## blockchain simulator
$receive_block_chain = BlockChain.new

def create_miner args
  Thread.new {
    miner = Miner.new args
    3.times do
      sleep [1, 2, 3].sample
      miner.accept $receive_block_chain
      [1, 2, 3].sample.times.each do |i|
        miner.add_new_block
      end
      broadcast miner
    end
  }
end

def broadcast miner
  puts "#{miner.name} broadcasted"
  $receive_block_chain = miner.block_chain
end

puts "start"
th1 = create_miner name: "miner1"
th2 = create_miner name: "miner2"
th3 = create_miner name: "miner3"
[th1, th2, th3].each{|t| t.join}

puts "block chain result"

$receive_block_chain.blocks.each do |block|
  puts "*** Block #{block.height} ***"
  puts "hash: #{block.hash}"
  puts "previous_hash: #{block.previous_hash}"
  puts "timestamp: #{block.timestamp}"
  # TODO: merkle root
  # puts "transactions_hash: #{block.transactions_hash}"
  puts "transactions: #{block.transactions}"
  puts "nonce: #{block.nonce}"
  puts "*************************"
end
