cd /d %~dp0

platex -kanji=sjis main
jbibtex main
mendex main.glo -s esysnomencl.ist -o main.gls
platex -kanji=sjis main
platex -kanji=sjis main
dvipdfmx main
pause