require "./Working_with_data/DataPrepareHelper.rb"

dataPrepareHelper = DataPrepareHelper.new
dataPrepareHelper.list_of_rappers
dataPrepareHelper.get_rounds_texts
dataPrepareHelper.get_words_per_round
dataPrepareHelper.clear_text
dataPrepareHelper.get_words_list
dataPrepareHelper.bad_words_count
dataPrepareHelper.save("./Working_with_data/rappers_statistic.yml")
dataPrepareHelper.words_count
