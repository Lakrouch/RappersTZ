class Rapper

  def initialize(name, battles="1", bad_words="0", bad_words_per_battle="0",
  words_per_round="0", rounds="0", words="0")
    @name = name
    @battles = battles
    @bad_words = bad_words
    @bad_words_per_battle = bad_words_per_battle
    @words_per_round = words_per_round
    @info = @name+" | "+@battles+" | "+@bad_words+" | "+@bad_words_per_battle+" | "+@words_per_round
    @rounds = rounds
    @words = words
  end

  def get_name()
    @name
  end

  def get_battles()
    @battles
  end

  def set_battles(battles)
    @battles = battles
    set_info()
  end

  def get_bad_words()
    @bad_words
  end

  def set_bad_words(bad_words)
    @bad_words = bad_words
    set_info()
  end

  def get_bad_words_per_battle()
    @bad_words_per_battle
  end

  def set_bad_words_per_battle(bad_words_per_battle)
    @bad_words_per_battle = bad_words_per_battle
    set_info()
  end

  def get_words_per_battle()
    @words_per_battle
  end

  def set_words_per_round(words_per_round)
    @words_per_round = words_per_round
    set_info()
  end

  def get_words_per_round()
    @words_per_round
  end

  def get_info()
    @info
  end

  def set_info()
    @info = @name+" | "+@battles+" | "+@bad_words+" | "+@bad_words_per_battle+" | "+@words_per_round
  end

  def get_rounds()
    @rounds
  end

  def set_rounds(rounds)
    @rounds = rounds
  end

  def get_words()
    @words
  end

  def set_words(words)
    @words = words
  end
end
