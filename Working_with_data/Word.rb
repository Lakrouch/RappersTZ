class Word

  def initialize(word, count="0")
    @word = word
    @count = count
  end

  def get_word()
    @word
  end

  def get_count()
    @count
  end

  def set_count(count)
    @count = count
  end
end
