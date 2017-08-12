defmodule ScraperTest do
  use ExUnit.Case, async: true

  setup_all do
    IO.puts "Starting ScraperTest"
    {:ok, raw} = File.read("test/fixtures/search.cfm")
    [search_cfm: Floki.parse(raw)]
  end

  test "parses total number of records", context do
    total = Scraper.parse_total(context[:search_cfm])
    assert({:ok, 8140} = total)
  end

  test "parses links", context do
    links = Scraper.parse_links(context[:search_cfm])
    assert({:ok, _} = links)
  end
end
