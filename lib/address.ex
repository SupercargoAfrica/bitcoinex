defmodule Bitcoinex.Address do
  @moduledoc """
  Base58, Bech32 address support.
  Bitcoin Address Validation
  reference of p2sh p2pkh validation: https://rosettacode.org/wiki/Bitcoin/address_validation#Erlang
  """
  alias Bitcoinex.{Segwit, Base58Check}
  @type address_type :: :p2pkh | :p2sh | :p2wpkh | :p2wsh
  @address_type ~w(p2pkh p2sh p2wpkh p2wsh)a


  def encode(_pubkey, _network_name, :p2pkh) do
    # TODO
  end

  def encode(_script_hash, _network_name, :p2sh) do
    # TODO
  end

  @spec is_valid?(String.t(), Bitcoinex.Network.network_name()) :: boolean
  def is_valid?(address, network_name) do
    Enum.any?(@address_type, &is_valid?(address, network_name, &1))
  end

  @spec is_valid?(String.t(), Bitcoinex.Network.network_name(), address_type) :: boolean
  def is_valid?(address, network_name, :p2pkh) do
    network = apply(Bitcoinex.Network, network_name, [])
    is_valid_base58_check_address?(address, network.p2pkh_version_decimal_prefix)
  end

  def is_valid?(address, network_name, :p2sh) do
    network = apply(Bitcoinex.Network, network_name, [])
    is_valid_base58_check_address?(address, network.p2sh_version_decimal_prefix)
  end

  def is_valid?(address, network_name, address_type) when address_type in [:p2wpkh, :p2wsh] do
    case Segwit.decode_address(address) do
      {:ok, {^network_name, _, _}} ->
        true

      # network is not same as network set in config
      {:ok, {_network_name, _, _}} ->
        false

      {:error, _error} ->
        false
    end
  end


  def supported_address_types() do
    @address_type
  end

  defp is_valid_base58_check_address?(address, valid_prefix) do
    IO.inspect address
    case Base58Check.decode(address) do
      {:ok, <<^valid_prefix::8, _::binary>>} ->
        true
      _ ->
        false
    end
  end
end
