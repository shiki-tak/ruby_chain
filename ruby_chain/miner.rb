require 'openssl'

require_relative 'block_chain'

class Miner
  attr_reader :name, :block_chain
  def initialize args
    @name = args[:name]
    @rsa = OpenSSL::PKey::RSA.generate(2048)
    @block_chain = BlockChain.new
  end

  def accept receive_block_chain
    puts "#{@name} checks received block chain. Size: #{@block_chain.size}"
    if receive_block_chain.size > @block_chain.size
      if BlockChain.is_valid_chain? receive_block_chain
        puts "#{@name} accepted received blockchain"
        @block_chain = receive_block_chain.clone
      else
        puts "Received blockchain invalid"
      end
    end
  end

  def add_new_block
    next_block = @block_chain.next_block []
    @block_chain.add_block(next_block)
    puts "#{@name} add new block: #{next_block.hash}"
  end
end
