defmodule CRC do
  @moduledoc """
  This module is used to calculate CRC (Cyclic Redundancy Check) values
  for binary data. It uses NIF functions written in C to interate over
  the given binary calculating the CRC checksum value.
  """

  @on_load {:init, 0}

  @doc """
  Initilizes the module by loading NIFs
  """
  def init do
    path = :filename.join(:code.priv_dir(:crc), 'crc_nif')
    :ok = :erlang.load_nif(path, 0)
  end

  @doc """
  Calculates a 16-bit CCITT CRC with the given seed,
  seed defaults to 0xFFFF if one is not given
  """
  @spec ccitt_16(binary, number) :: number
  def ccitt_16(<<data :: binary>>, seed \\ 0xFFFF) do
    _calc_16_ccitt(data, seed)
  end

  @doc """
  Calculates a 16-bit CCITT XMODEM CRC
  """
  @spec ccitt_16_xmodem(binary) :: number
  def ccitt_16_xmodem(<<data :: binary>>) do
    _calc_16_ccitt(data, 0x0000)
  end

  @doc """
  Calculates a 16-bit CCITT 0x1D0F CRC
  """
  @spec ccitt_16_1D0F(binary) :: number
  def ccitt_16_1D0F(<<data :: binary>>) do
    _calc_16_ccitt(data, 0x1D0F)
  end

  defp _calc_16_ccitt(_data, _seed), do: "CRC16-CCITT NIF not loaded"
end
