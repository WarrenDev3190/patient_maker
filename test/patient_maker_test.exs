defmodule PatientMakerTest do
  use ExUnit.Case

  test "it can generate a fake patient map" do
    assert is_map(PatientMaker.generate()) == true
  end
end
