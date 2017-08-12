defmodule Scraper do
  @moduledoc """
  Web scraper for tx.healthinspections.us site
  """

  @doc """
  Get total number of records by scraping the search page

  ## Example

  iex> Scraper.get_total_records()
  [1234, 4034, 2940, 3842]
  """
  def get_total_records(url) do
    case HTTPoison.get(url) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            parse_total(response.body)
          _ -> :error
        end
      _ -> :error
    end
  end

  def get_facility(url) do
    case HTTPoison.get(url) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            with \
                 {:ok, reports} <- parse_reports(response.body),
                 {:ok, info} <- parse_facility_info(response.body)
            do
              {:ok, [facility: info, reports: reports]}
            else
              {:error, reason} -> {:error, reason}
              error -> {:error, "Error facility info - #{inspect error}"}
            end
          _ -> :error
        end
      _ -> :error
    end
  end

  @doc """
  Fetch facility ids
  """
  def get_facility_ids(url) do
    with {:ok, result} <- get_page(url) do
      ids =
        for n <- result do
          href_to_id(n)
        end
      {:ok, ids}
      else
      {:error, result} -> {:error, result}
    end
  end

  @doc """
  Fetch page for parsing
  """
  def get_page(url) do
    case HTTPoison.get(url) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            parse_links(response.body)
          _ -> :error
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
      _ -> :error
    end
  end

  defp parse_facility_info(html) do
    elements =
      html
      |> Floki.find("div#demographic")
      |> Enum.at(0)

    name =
      elements
      |> Floki.find("b")
      |> Floki.text
      |> clean_text

    address =
      elements
      |> Floki.find("i")
      |> Floki.text
      |> clean_text
      |> String.split(" «")
      |> Enum.at(0)
      {:ok, [name: name, address: address]}
  end

  defp parse_reports(html) do
    elements =
      html
      |> Floki.find("html body div table tr td:nth-child(1) > div")

    total = Enum.count(elements)
    if total >= 12 do
      reports =
        elements
        |> Enum.slice(2..total - 10)

        result =
          for n <- reports do
            parse_report(n)
          end
      {:ok, result}
    else
      {:ok, :no_reports}
    end

  end

  defp parse_report(html) do
    with \
         {:ok, score} <- parse_score(html),
         {:ok, demerits} <- parse_demerits(html)
    do
      [inspection: score, demerits: demerits]
    else
      {:error, reason} -> {:error, reason}
      error -> {:error, "Error parsing name/address - #{inspect error}"}
    end
  end

  defp parse_score(html) do
    result =
      html
      |> Floki.find("div div")
      |> Enum.at(2)
      |> Floki.find("div")
      |> Floki.text
      |> clean_text
      |> String.split
    date = Enum.at(result, 1)
    score = 
      result
      |> Enum.at(3)
      |> String.to_integer
    {:ok, [date: date, total: score]}
  end

  defp parse_demerits(html) do
    elements =
      html
      |> Floki.find("div div")
    total = Enum.count(elements) - 2
    if total > 2 do
      result =
        elements
        |> Enum.slice(3..total)
        demerits =
          for n <- result do
            parse_demerit(n)
          end
        {:ok, demerits}
    else
      {:ok, :no_demerits}
    end
  end

  defp parse_demerit(html) do
    demerit =
      html
      |> Floki.find("div")
      |> Floki.text
      |> clean_text

    if demerit == "" do
      :no_demerits
    else
      demerit
    end

  end

  defp parse_facility(html) do
    elements =
      html
      |> Floki.find("html body div table tr td div")
    if Enum.count(elements) == 17 do
      result = Enum.at(elements, 2)
      with \
           {:ok, name} <- parse_name(result),
           {:ok, address} <- parse_address(result),
           {:ok, last_score} <- parse_last_score(result)
      do
        {:ok, [name: name, address: address, score: last_score]}
      else
        {:error, reason} -> {:error, reason}
        error -> {:error, "Error parsing name/address - #{inspect error}"}
      end
    else
      {:error, "Unexpected Number of Elements"}
    end
  end

  
  defp parse_last_score(html) do
    elements =
      html
      |> Floki.find("div div")

    if Enum.count(elements) == 6 do
      result = 
        elements
        |> Enum.at(3)
        |> Floki.find("div")
        |> Floki.text
        |> clean_text
        |> String.split
        date = Enum.at(result, 1)
        score = 
          result
          |> Enum.at(3)
          |> String.to_integer
          {:ok, [date: date, total: score]}
    else
      {:error, "Unexpected number of elements while parsing score"}
    end
  end

  def parse_total(html) do
    result =
      html
      |> Floki.find("html body table tr td > b")
    if Enum.count(result) == 1 do
      total =
        result
        |> Floki.text
        |> String.split(" ")
        |> Enum.at(0)
        |> String.to_integer
        {:ok, total}
    else
      {:error, "Unexpected number of elements for parsing total pages"}
    end
  end

  def parse_links(html) do
    records =
      html
      |> Floki.find("html body table tr td a[href^=\"estab.cfm?licenseID=\"]")
    if Enum.count(records) == 10 do
      ids =
        records
        |> Floki.attribute("href")
        {:ok, ids}
    else
      {:error, "Unexpected number of links found on page - #{Enum.count(records)}"}
    end
  end

  defp href_to_id(href) do
    href
    |> String.split("=")
    |> Enum.at(1)
    |> String.to_integer
  end

  defp clean_text(text) do
    text
    |> String.trim
    |> String.replace(~r/\r|\n|\t/, " ")
    |> String.replace(~r/[ ]{2,}/, " ")
    |> String.replace(" ,", ",")
  end

  defp parse_name(html) do
    result =
      html
      |> Floki.find("div div b")
    if (Enum.count(result) == 3) do
      name =
        result
        |> Enum.at(0)
        |> Floki.text
        {:ok, name}
    else
      {:error, "Unexpected number of elements for parsing name"}
    end
  end

end