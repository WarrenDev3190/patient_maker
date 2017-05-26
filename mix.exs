defmodule PatientMaker.Mixfile do
  use Mix.Project

  def project do
    [app: :patient_maker,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end


  def application do
    [applications: [:logger, :faker]]
  end

  defp deps do
    [{:faker, "~> 0.8"},
     {:uuid, "~> 1.1" },
     {:poison, "~> 3.1.0"}]
  end
end
