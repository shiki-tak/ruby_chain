require 'digest/sha2'
require 'time'

require_relative 'transaction'
require_relative 'proof_of_work'

class Block
  attr_reader :hash, :height, :transactions, :timestamp, :nonce, :previous_hash

  def initialize args
    @hash = args[:hash]
    @height = args[:height]
    # TODO: merkle root
    @transactions = args[:transactions]
    @timestamp = args[:timestamp]
    @nonce = args[:nonce]
    @previous_hash = args[:previous_hash]
  end

  private
    def calculate_hash args
      Digest::SHA256.hexdigest({
        height: args[:height],
        previous_hash: args[:previous_hash],
        timestamp: args[:timestamp],
        transactions: args[:transactions],
      }.to_json)
    end

  class << self
    def create_genesis_block
      address = "62e907b15cbf27d5425399ebf6f0fb50ebb88f18"
      genesis_coinbase_data = "The Times 03/Jan/2009 Chancellor on brink of second bailout for banks"
      Block.new(
        timestamp: Time.parse("2009/1/3").to_i,
        transactions: [Transaction.new_coinbase_transaction(address, genesis_coinbase_data)],
        previous_hash: '0',
        height: 0
      )
    end
  end
end
