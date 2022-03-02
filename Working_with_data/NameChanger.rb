require "./Working_with_data/FileWorker.rb"

class NameChanger

  attr_accessor :index

  def initialize()
    @fileWorker = FileWorker.new()
    @index = 0
    @files = fileWorker.get_dir("./Working_with_data/Data/Texts", 2)
    rename(@files)
  end

  def renamer(no_name, name, file)
    if file[(file.index("_")+1)..] == no_name
      File.rename("./Working_with_data/Data/Texts/"+file, "./Working_with_data/Data/Texts/"+file[0..file.index("_")]+name)
    end
  end

  def make_short(file, separator)
    if file.index(separator) != nil
      File.rename("./Working_with_data/Data/Texts/"+file, "./Working_with_data/Data/Texts/"+@index.to_s+"_"+file[0..file.index(separator)-1].strip)
      @index += 1
      return true
    else
      return false
    end
  end

  def rename(files)
    separators = ["против", "VS", "vs"]
    for file in files
      for separator in separators
        if make_short(file, separator)
          break
        end
      end
    end
    files_shorts = fileWorker.get_dir("./Working_with_data/Data/Texts", 2)
    for file in files_shorts
          renamer("Chet'а", "Chet", file)
          renamer("СД", "ST", file)
          renamer("Гнойный",
            "Гнойный aka Слава КПСС aka Соня Мармеладова", file)
          renamer("Соня Мармеладова aka Гнойный",
            "Гнойный aka Слава КПСС aka Соня Мармеладова", file)
            renamer("Гнойный aka Слава КПСС",
              "Гнойный aka Слава КПСС aka Соня Мармеладова", file)
          renamer("Замая", "Замай", file)
          renamer("Ильи Мирного", "Илья Мирный", file)
          renamer("Ларина", "Ларин", file)
          renamer("Johnyboy'а", "Johnyboy", file)
          renamer("MoonStara", "MC MoonStar", file)
          renamer("Moonstar", "MC MoonStar", file)
          renamer("Oxxxymirona", "Oxxxymiron", file)
          renamer("Oxxxymiron'a", "Oxxxymiron", file)
          renamer("Sin'а", "Sin", file)
          renamer("tvoigreh", "Tvoigreh", file)
          renamer("Артема Лоика", "Артём Лоик", file)
          renamer("Лоика", "Артём Лоик", file)
          renamer("Артема Татищевского", "Артём Татищевский", file)
          renamer("Басоты", "Басота", file)
          renamer("Браги", "Брага", file)
          renamer("Букера", "Букер", file)
          renamer("Вити Classic'a", "Витя Classic", file)
          renamer("Витя CLassic", "Витя Classic", file)
          renamer("Галата", "Галат", file)
          renamer("Galat", "Галат", file)
          renamer("Гарри Топора", "Гарри Топор", file)
          renamer("Дуни", "Дуня", file)
          renamer("Леши GS", "Леша GS", file)
          renamer("Марины Кацубы", "Марина Кацуба", file)
          renamer("Млечного", "Млечный", file)
          renamer("Сявы", "Сява", file)
          renamer("Типси Типа", "Типси Тип", file)
          renamer("Хайда", "Хайд", file)
          renamer("Хованского", "Хованский", file)
          renamer("Хохла", "Хохол", file)
          renamer("Billy Milligan'а", "Billy Milligan", file)
    end
  end
end
