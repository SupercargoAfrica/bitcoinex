defmodule Bitcoinex.LightningNetwork.HopHint do
  @enforce_keys [
    :node_id,
    :channel_id,
    :fee_base_m_sat,
    :fee_proportional_millionths,
    :cltv_expiry_delta
  ]
  defstruct [
    :node_id,
    :channel_id,
    :fee_base_m_sat,
    :fee_proportional_millionths,
    :cltv_expiry_delta
  ]

  @type t() :: %__MODULE__{
          node_id: String.t(),
          channel_id: non_neg_integer,
          fee_base_m_sat: non_neg_integer,
          fee_proportional_millionths: non_neg_integer,
          cltv_expiry_delta: non_neg_integer
        }
end
