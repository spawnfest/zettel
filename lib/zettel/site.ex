defmodule Zetel.Site do

  @draft_dir "_drafts"
  @pages_dir "_pages"

  @site_dirs [@draft_dir, @pages_dir]

  @site_exists_error """
  The directory already exists.
  Use --force to override.
  """

  def create(path, force \\ false) do
    cond do 
      dir_exists?(path) and not force -> {:error, @site_exists_error}
      true -> create_new(path)
    end
  end

  def create_new(path) do
    try do
      # If we got to this function we are allowed to create a site in
      # specified path so wipe it out if it exists.
      File.rm_rf! path
      Enum.map(get_site_dirs(path), &File.mkdir_p!/1)
    rescue
      e -> {:error, e}
    end
    {:ok, nil}
  end

  defp get_site_dirs(path) do
    Enum.map(@site_dirs, &(Path.join(path, &1)))
  end

  defp dir_exists?(path) do
    File.exists? path
  end
end
