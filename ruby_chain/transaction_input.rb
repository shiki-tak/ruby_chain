class Input
  attr_reader :tx_id, :v_out, :script_sig

  def initialize args
    # tx_id: 前の出力の参照
    # v_out: トランザクション内の出力のインデックスを格納
    # script_sig: ScriptPubKeyで使われるデータを提供するスクリプト（今は任意のユーザのアドレス）
    @tx_id = args[:tx_id]
    @v_out = args[:v_out]
    @script_sig = args[:script_sig]
  end

  def uses_key script_sig_hash
    locking_hash = hash160 @script_sig
    if locking_hash == script_sig_hash
      return true
    else
      return false
    end
  end
end
