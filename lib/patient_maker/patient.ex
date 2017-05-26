defmodule PatientMaker.Patient do
  @tiers [0,1,2,3]
  @age 20..90
  @gender ["M", "F"]
  @status ["active","snoozed","on_list","acknowledged"]
  @chief_complaint ["Collapsed Lung", "Leg Is Warm", "Fake Tough"]

  defstruct [
    pid: UUID.uuid1(),
    tier: Enum.random(@tiers),
    age: Enum.random(@age),
    activity: [],
    chief_complaint: Enum.random(@chief_complaint)
  ]

  def generate do
      %PatientMaker.Patient{}
      |> Map.put(:pid, UUID.uuid1())
      |> Map.put(:tier, Enum.random(@tiers))
      |> Map.put(:name, Faker.Name.name())
      |> Map.put(:gender, Enum.random(@gender))
      |> Map.put(:age, Enum.random(@age))
      |> Map.put(:chief_complaint, Enum.random(@chief_complaint))
      |> Map.put(:activity, create_activity())
  end

  def create_activity do
    activity = []
    for _x <- 1..Enum.random(2..20)  do
      [%{status: Enum.random(@status), ts: Faker.NaiveDateTime.between(~N[2016-12-20 00:00:00], ~N[2016-12-25 00:00:00])} | activity]
    end
  end

  def encode(patient), do: Poison.encode!(patient)

  def generate_many(num \\ 1) do
    patients = []
    case num do
      1 ->
        [generate() | patients]
      _ ->
        1..num
        |> Enum.map(fn _ -> Task.async(fn -> generate() end) end)
        |> Enum.map(&Task.await(&1))
        |> Enum.into(patients)
    end
  end

end
