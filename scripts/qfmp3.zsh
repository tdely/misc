#!/bin/zsh

for f in $@
do
  echo "// processing '$f'"
  if [[ $f != *.mp3 ]]; then
    echo "E: not an mp3 file"
    continue
  elif [ ! -f $f ]; then
    echo "E: file does not exist"
    continue
  fi
  # remove any "[asdasd234]" from filename
  nf="${${f%%.mp3*}% \[*}.mp3"
  if [[ $f != $nf ]]; then
    echo "renaming '$f' -> '$nf'"
    mv "$f" "$nf"
  fi
  # artist is anything before " - "
  a="${${nf% - *}%.mp3}"
  echo "I: artist: $a"
  # title is everything after " - " up to .mp3
  t="${${nf#* - }%.mp3}"
  echo "I: title: $t"
  if [[ $a == $t ]]; then
    echo "E: failed to determine artist/title"
    continue
  fi
  id3v2 -a "$a" "$nf"
  id3v2 -t "$t" "$nf"
done
