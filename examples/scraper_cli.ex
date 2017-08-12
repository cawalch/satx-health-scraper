defmodule ScraperCli do
  @moduledoc """
  ScraperCli
  """
  use Application

  def main(args) do
    {opts, _, _} = OptionParser.parse(args, 
                                    switches: [url: :string], 
                                    aliases: [u: :url])

    with \
         {:ok,  total} <- Scraper.get_total_records("#{opts[:url]}search.cfm")
    do
      # Round total number of pages / 10 per page
      pages = round( Float.ceil(total / 10) )
      for n <- 1..pages do
        get_facilities(opts[:url], n)
      end
    end
  end

  def get_facilities(url, page) do
    with \
         {:ok, ids} <- Scraper.get_facility_ids("#{url}search.cfm?start=#{page}")
    do
      for f <- ids do
        {:ok, result} = Scraper.get_facility("#{url}estab.cfm?licenseID=#{f}")
                     Process.sleep(1000)
      end
    end
  end

end