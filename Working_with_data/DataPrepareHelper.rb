require "./Working_with_data/NameChanger.rb"
require "./Working_with_data/Rapper.rb"
require "./Working_with_data/FileWorker.rb"
require "./Working_with_data/Word.rb"

class DataPrepareHelper

  def initialize()
    #@nameChanger = NameChanger.new()
    @fileWorker = FileWorker.new()
    @statement = true
    @header = Rapper.new("Name", "Battles", "Bad_words",
      "Bad_words_per_battle", "Words_per_round")
    @rappers = []
    @rappers.append(@header)
    @words_header = Word.new("Word")
    @words_list = []
    @words_list.append(@words_header)
   end

  def get_rounds_texts()
    files = @fileWorker.get_dir("./Working_with_data/Data/Texts", 2)
    for file in files
      counter = 0
      simple = file[file.index("_")+1 ..]
      for rapper in @rappers
        if rapper.get_name() == simple
          text = @fileWorker.read_file("./Working_with_data/Data/Texts/"+file)
          rounds_text = text.split(/Раунд.[\d]/)
          for round in rounds_text
            if round == ""
              next
            end
            @fileWorker.write_file("./Working_with_data/Data/RoundsText/"+file+"_"+counter.to_s+".yml", round)
            counter += 1
          end
          if text.index(/Раунд.[\d]/) != nil
            rounds = text.split(/Раунд.[\d]/).size-1
            rapper.set_rounds((rapper.get_rounds().to_i + rounds).to_s)
          else
            rapper.set_rounds((rapper.get_rounds().to_i + 1).to_s)
          end
        end
      end
    end
  end

  def list_of_rappers()
    files = @fileWorker.get_dir("./Working_with_data/Data/Texts", 2)
    for file in files
      simple = file[file.index("_")+1 ..]
      for rapper in @rappers
        if  simple == rapper.get_name()
          @statement = false
          rapper.set_battles((rapper.get_battles().to_i+1).to_s)
        end
      end
      if @statement
        @rappers.append(Rapper.new(simple))
      end
      @statement = true
    end
  end

  def clear_text()
    files = @fileWorker.get_dir("./Working_with_data/Data/Texts/", 2)
    for file in files
      file_lines = File.new("./Working_with_data/Data/Texts/"+file).readlines
      for line in file_lines
        line = line.delete(".,:!?&quote–")
        if line.index(/Раунд.[\d]/) != nil
          line = " "
        end
        @fileWorker.write_file("./Working_with_data/Data/ClearedTexts/"+file, line)
      end
    end
  end

  def get_words_per_round()
    files = @fileWorker.get_dir("./Working_with_data/Data/RoundsText/", 2)
    for file in files
      simple = file[file.index("_")+1 ..file.rindex("_")-1]
      for rapper in @rappers
        if  simple == rapper.get_name
          text = @fileWorker.read_file("./Working_with_data/Data/RoundsText/"+file)
          rapper.set_words((rapper.get_words.to_i+text.split.size).to_s)
        end
      end
    end
    for rapper in @rappers
      rapper.set_words_per_round((rapper.get_words.to_f/rapper.get_rounds.to_f).round(2).to_s)
    end
  end

  def get_words_list()
    files = @fileWorker.get_dir("./Working_with_data/Data/ClearedTexts", 2)
    for rapper in @rappers[1..]
      for file in files
        simple = file[file.index("_")+1 ..]
        if  simple == rapper.get_name()
          text = @fileWorker.read_file("./Working_with_data/Data/ClearedTexts/"+file).split
          filter = @fileWorker.read_file("./Working_with_data/little_words.yml")
          for word in text
            if word.size == 1 or filter.index(word.downcase)!=nil or word == /\d/
              next
            end
            if word.index("«") != nil or word.index("»") != nil
              word = word.delete("«")
              word = word.delete("»")
            end
            @fileWorker.write_file("./Working_with_data/Data/RappersWords/"+rapper.get_name+".yml", word.downcase)
          end
        end
      end
    end
  end

  def bad_words_count()
    files = @fileWorker.get_dir("./Working_with_data/Data/RappersWords", 2)
    for file in files
      simple = file[0..file.rindex(".")-1]
       for rapper in @rappers
         if simple == rapper.get_name
           text =  @fileWorker.read_file("./Working_with_data/Data/RappersWords/"+rapper.get_name+".yml").split
           filter = @fileWorker.read_file("./Working_with_data/bad words.yml").split
           for word in text
            for bad_word in filter
              if word.index("*") != nil or word.downcase.strip == bad_word
                rapper.set_bad_words((rapper.get_bad_words.to_i+1).to_s)
                break
              end
            end
           end
           break
         end
         rapper.set_bad_words_per_battle((rapper.get_bad_words.to_f/rapper.get_battles.to_f).round(2).to_s)
       end
    end
  end

  def words_count()
    files = @fileWorker.get_dir("./Working_with_data/Data/RappersWords", 2)
    for file in files
      simple = file[0..file.rindex(".")-1]
      for rapper in @rappers
        if rapper.get_name == simple
          hash = {}
          text =  @fileWorker.read_file("./Working_with_data/Data/RappersWords/"+rapper.get_name+".yml").split
          text.each do |word|
            word = word.downcase
          end
          text.each do |word|
            hash[word] = text.count(word)
          end
          sorted_hash= Hash[hash.sort {|a, b| b[1] <=> a[1]}]
          sorted_hash.each {|key, value| @fileWorker.write_file("./Working_with_data/Data/WordsStatistic/"+rapper.get_name+".yml", "#{key} | #{value}")}
        end
      end
    end
  end

  def save(path)
    @rappers.sort! {|a, b| b.get_bad_words.to_i <=> a.get_bad_words.to_i}
    for rapper in @rappers
      if rapper.get_name == "Name"
        next
      end
      rapper.set_battles(rapper.get_battles + " батлов")
      rapper.set_bad_words(rapper.get_bad_words + " нецензурных слов")
      rapper.set_bad_words_per_battle(rapper.get_bad_words_per_battle + " нецензурных слов за батл")
      rapper.set_words_per_round(rapper.get_words_per_round + " слова в раунде")
      @fileWorker.write_file(path, rapper.get_info)
    end
  end

end
