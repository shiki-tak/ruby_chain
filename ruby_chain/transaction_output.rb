class Output
  attr_reader :value, :script_pubkey

  def initialize args
    @value = args[:value]
    @script_pubkey = args[:script_pubkey]
  end

  def lock address
    script_pubkey = decode_base58 address
    script_pubkey =
    @script_pubkey = script_pubkey
  end
end
