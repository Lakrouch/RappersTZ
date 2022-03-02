params = []
circle_counter = 0
for arg in ARGV
  counter = 0
  if arg.index("=") != nil
    if arg[0..arg.index("=")-1] == "--top_bad_words"
      counter+=1
      file = open "./Working_with_data/rappers_statistic.yml"
      file.each do |line|
        puts line
        circle_counter += 1
        if circle_counter == arg[arg.index("=")+1..].to_i
          break
        end
      end
    end
    if arg[0..arg.index("=")-1] == "--top_words"
      counter+=1
      name = arg[arg.index("=")+1..]
      files = Dir.entries("./Working_with_data/Data/WordsStatistic/")[2..]
      if files.index(name+".yml") == nil
        rnd_array = []
        rnd = Random.new()
        circle_counter = 0
        for circle_counter in 0..3
          rnd_array.append(files[rnd.rand(50)])
        end
        puts "Я не знаю рэпера с ником #{name}, но я знаю #{rnd_array[0][0..rnd_array[0].rindex(".")-1]}, #{rnd_array[1][0..rnd_array[1].rindex(".")-1]}, #{rnd_array[2][0..rnd_array[2].rindex(".")-1]}"
      else
        circle_counter = 0
        file = open "./Working_with_data/Data/WordsStatistic/#{name}.yml"
        file.each do |line|
          puts line
          circle_counter += 1
          if circle_counter == 29
            break
          end
      end
    end
end
if counter == 0
  puts "Я не знаю что делать с параметром #{arg}"
end
end
end
