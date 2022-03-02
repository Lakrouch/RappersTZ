class FileWorker

  def get_dir(path, start=0)
    return Dir.entries(path)[start..]
  end

  def write_file(path, data)
    File.open(path, "a"){|file| file.puts(data)}
  end

  def read_file(path)
    File.read(path)
  end

end
