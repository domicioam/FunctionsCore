#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Mastery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      { Mastery.Boundary.QuizManager, [name: Mastery.Boundary.QuizManager] },
      { Registry, [name: Mastery.Registry.QuizSession, keys: :unique] },
      { DynamicSupervisor, [name: Mastery.Supervisor.QuizSession, strategy: :one_for_one] }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mastery.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
