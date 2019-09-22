defmodule Zettel.CLI do

  def run(args) do
    parse_args(args)
    |> process
  end

  defp parse_args(args) do
    OptionParser.parse(args, strict: [create: :string, force: :boolean])
    |> elem(0)
  end

  defp process([create: path, force: force?]) do
    case Zetel.Site.create(path, force?) do
      {:error, error} -> abort(error)
      {:ok, nil} -> IO.puts "Site created at #{path}"
    end
  end

  defp process([create: path]) do
    process([create: path, force: false])
  end

  defp abort(msg) do
    IO.puts msg
    System.halt(0)
  end
  
end
