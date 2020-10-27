defmodule FleetWeb.TokenView do
  use JSONAPI.View, type: "tokens"

  def id(_data), do: nil

  def type(), do: "tokens"

  def fields do
    [:token, :user_id]
  end

  def links do
    nil
  end
end
