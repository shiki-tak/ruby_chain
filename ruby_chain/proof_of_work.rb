require 'digest/sha2'
require 'json'

class ProofOfWork
  attr_reader :timestamp, :transactions, :previous_hash

  def initialize args
    @timestamp = args[:timestamp]
    @transactions = args[:transactions]
    @previous_hash = args[:previous_hash]
  end

  def calc_hash_with_nonce(nonce=0)
    sha = Digest::SHA256.hexdigest({
      timestamp: @timestamp,
      transactions: @transactions,
      previous_hash: @previous_hash,
      nonce: nonce
    }.to_json)
    sha
  end

  # TODO: difficulty
  def do_proof_of_work(difficulty = '0000')
    nonce = 0

    loop do
      hash = calc_hash_with_nonce nonce
      if hash.start_with? difficulty
        return [nonce, hash]
      else
        nonce += 1
      end
    end
  end
end
