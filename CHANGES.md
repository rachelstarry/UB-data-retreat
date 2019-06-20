# Changelog for UB Data Retreat .Rproj

## Martin Collection - Raw Data

### .pdf
* "710f83a7e4e448af0389277b6a005f51.pdf" = original download 2019-06-18 from https://digital.lib.buffalo.edu/items/show/80062, Transcription of A Line a Day Diary, Cora Herrick, 1911-1915
* "8373157c0e9a722abc3e3537975d3427.pdf" = original download 2019-06-18 from https://digital.lib.buffalo.edu/items/show/80063, Transcription of A Line a Day Diary, Cora Herrick, 1916, 1922, 1946
* "f54c693af511dc1b86be7f910847ab63.pdf" = original download 2019-06-18 from https://digital.lib.buffalo.edu/items/show/80060, Transcription of Memoranda of Events in the Life of Darwin D. and Isabelle R. Martin, 1865-1934
* "HerrickDiary1911-1915.pdf" = 2019-06-18 copied and renamed original pdf of Transcription of A Line a Day Diary, Cora Herrick, 1911-1915
* "HerrickDiary1916-1946.pdf" = 2019-06-18 copied and renamed original pdf of Transcription of A Line a Day Diary, Cora Herrick, 1916, 1922, 1946
* "MartinDiary1865-1934.pdf" = 2019-06-18 copied and renamed original pdf of Transcription of Memoranda of Events in the Life of Darwin D. and Isabelle R. Martin, 1865-1934

### .txt
* "HerrickDiary1911-1915.txt" = saved "HerrickDiary1911-1915.pdf" as text 2019-06-18
* "HerrickDiary1916-1946.txt" = saved "HerrickDiary1916-1946.pdf" as text 2019-06-18
* "MartinDiary1865-1934.txt" = saved "MartinDiary1865-1934.pdf" as text 2019-06-18

## Martin Collection - Processed Data

### .txt
* "sample1911OriginalEncoding.txt" = 2019-06-18 cut out lines from "HerrickDiary1911-1915.txt" for Jan-Dec 1911 entries; realized text was encoded as Western, converted sample to UTF-8 using https://subtitletools.com/convert-text-files-to-utf8-online and saved as "sample1911.txt"
* "sample1911.txt" = see above
* "sample1915OriginalEncoding.txt" = 2019-06-18 same process as above for Jan-Dec 1915 entries, saved UTF-8 version as "sample1915.txt"
* "sample1915.txt" = see above

### .csv
* "word_frequency.csv" = 2019-06-20 downloaded from https://programminghistorian.org/assets/basic-text-processing-in-r/word_frequency.csv, dataset of English word frequencies created by Peter Norvig using the Google Web Trillion Word Corpus

## Inaugural Speeches

### .txt
* 59 .txt documents for all US Presidential inaugural speeches, downloaded from https://en.wikisource.org/wiki/Portal:Inaugural_Speeches_by_United_States_Presidents

### .csv
* "inaugural_metadata.csv" = created 2019-06-20 from data scraped from https://en.wikisource.org/wiki/Portal:Inaugural_Speeches_by_United_States_Presidents and processed into .csv form with OpenRefine; added party affiliations using data from https://en.wikipedia.org/wiki/List_of_Presidents_of_the_United_States

## Scripts

* "processTranscripts.R"
* ... 