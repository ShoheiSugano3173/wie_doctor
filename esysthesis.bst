%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% このjBiBTeXのスタイルファイルは、人工知能学会用の bst ファイルを修正する
% ことによって作成しました．阪大の萩平哲さんが公開しているbstファイルの修正
% 方法 http://www.med.osaka-u.ac.jp/pub/anes/www/latex/bibliography.html
% を参考にさせていただきました．
%
% コメントも無いですし、勝手に編集していますし、コピーライトも消して
% しまいました．そして何よりやっつけで変更作業しましたので外に出ると
% 恥ずかしい．ということで、エンジニアリングシステム研究室外への
% 公開および配布を禁止いたします．
% 
% 動作は、article と incollection でしか確認していませんので、不具合を
% 見つけたら uta@luce.aoyama.ac.jp まで連絡してください．
% 
%                                宮治 裕（uta） July 1/2003
%								  菅野 翔平(すがっち) June 21/2012　modified
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Dr.Tが参加提出する学会のスタイルに準拠しているはずです．
%
% 英語のタイトルの後のカンマがクオートの内側に来るのは、英語の決まり
% だそうなので、そうしています．日本語のタイトルでは、括弧の外にカンマ
% を置いています．
%
% 最初に英語の文献が birthname-year 順にソートされて並びます．
% 次に日本語の文献が 苗字-year 順にソートされて並びます．
% 日本語の文献をソートさせるには、 bib ファイル内に yomi レコードを
% 「ひらがな」で記述する必要があります．以下のサンプルを参照ください．
% 同じ年に同じ人によって公開された文章を参照した場合、自動的に a,b,cといった
% 具合に添え字がつきますが、その順番を変えたい場合には yomi レコードを細工
% してください．例えば「みやじ ゆたかz」「みやじ ゆたかx」とすれば、xをつけた
% 方の添え字番号が若くなります．
%
% 英語文献の言語が日本語である場合には、note レコードに (In Japanese)を
% 記述してください． また、本を参照した場合には、ISBN ナンバーを note 
% に記述してください．
%
%%%%%%%%%%%%%%%
% bibfile sample
%%%%%%%%%%%%%%%
% @incollection{WelfareJapan,
%  editor	= "Shin Ohara",
%  author	= "Ken Tomiyama and Yutaka Miyaji",
%  title = "{Towards Realization of Care Worker Support Robot}",
%  booktitle = "{Current Status of Welfare in Japan}",
%  publisher = "IBUNSYA",
%  pages = "301-329",
%  note = "(ISBN4-7531-0217-3:In Japanese)",
%  year = "2001",
% }
% 
% @article{Miyaji2001,
%  author = "Yutaka Miyaji and Ken Tomiyama",
%  title = "{Virtual KANSEI, It's Concept and Structure}",
%  journal = "Proceedings of The Third Annual Conference of JSKE 2001",
%  memo = "C14",
%  pages = "83",
%  note = "(In Japanese)",
%  year = "2001",
% }
% 
% @article{miyaji,
% author  = "宮治 裕 and 富山 健",
% title   = "疑似感性の概念とその構造の提案",
% yomi = "みやじ ゆたか and とみやま けん",
% journal = "第3回日本感性工学会大会予稿集",
% year    = "2001",
% volume  = "",
% number  = "",
% pages   = "83",}
% 
% @article{takata1,
% author  = "高田 和豊 and 富山 健 and 宮治 裕",
% yomi = "たかた かずとよ and とみやま けん and みやじ ゆたか ",
% title   = "福祉工学における疑似感性の構成手法",
% journal = "第3回日本感性工学会大会予稿集",
% year    = "2001",
% volume  = "",
% number  = "",
% pages   = "82",
% }
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    yomi
  }
  {is.kanji.entry}
  { label extra.label sort.label }
%  { label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block
           after.author }
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #4 'after.author :=
}
STRINGS { s t }
% added by uta --begin-- refer to hagihira's homepage
STRINGS { separator pre pre2 post post2 str }
% added by uta --end-- refer to hagihira's homepage

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

% added by uta --begin-- refer to hagihira's homepage
FUNCTION {pinit}
{
  ", " 'separator :=
  "" 'pre :=
  "" 'post :=
  "" 'pre2 :=
  "" 'post2 :=
  "" 'str :=
}
% added by uta --end-- refer to hagihira's homepage

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { separator * write$ }
    { output.state after.block =
	{ 
          add.period$ write$
	  newline$
	  "\newblock " write$
	}
	{ output.state after.author =
	    { author empty$ editor empty$ and organization empty$ and
		{write$}
		{ author field.or.null is.kanji.str$ 
		  editor field.or.null is.kanji.str$ or
		  organization field.or.null is.kanji.str$ or
% modified by uta --begin--
		   % {"：" * write$}
		   % {": " * write$}
		    {". " * write$}
		    {". " * write$}
% modified by uta --end--
		  if$
		}
	      if$
	      mid.sentence 'output.state :=
	    }
	    'write$
	  if$
	}
      if$
      mid.sentence 'output.state :=
    }
  if$
% added by uta --begin-- refer to hagihira's homepage
  pinit
% added by uta --end-- refer to hagihira's homepage
  s
}
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}
FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}
FUNCTION {output.bibitem}
{ newline$
%  "\bibitem{" write$
%  cite$ write$
%  "}" write$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
FUNCTION {fin.entry}
{ 
%%  add.period$ 2002.12.13 by kamisima
% readded by uta --begin--
  add.period$
% readded by uta --end--
  write$
  newline$
}
FUNCTION {new.block}
{ output.state before.all =
    { after.author 'output.state := }
    'skip$
  if$
}
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
	'skip$
	{ after.sentence 'output.state := }
      if$
    }
  if$
}
FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}
FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}
FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}
FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}
FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { duplicate$ is.kanji.str$
	'skip$
	{ "{\em " swap$ * "}" * }
      if$
    }
  if$
}

INTEGERS { nameptr namesleft numnames }
%FUNCTION {format.names}
%{ 's :=
%  #1 'nameptr :=
%  s num.names$ 'numnames :=
%  numnames 'namesleft :=
%    { namesleft #0 > }
%    { s nameptr "{ff}{ll}" format.name$ is.kanji.str$
%%%    { s nameptr "{ff }{ll }" format.name$ is.kanji.str$
%	{s nameptr "{ff}{ll}" format.name$ 't :=}
% 	{s nameptr "{ll,~~}{vv~}{f.}{, jj}" format.name$ 't :=}
%      if$
%      nameptr #1 >
%	{ namesleft #1 >
%	    {", " * t * }
%	    { t "others" = t "others,~" = or
% 		{ s is.kanji.str$
% 			{"他" * }
% 			{", et~al." * }
% 		  if$
% 		}
% 		{ s is.kanji.str$
%		    {", " * t * }
% 		    {" and " * t * }
% 		   if$
% 		}
%	      if$
%	    }
%	  if$
%	}
%	't
%      if$
%      nameptr #1 + 'nameptr :=
%      namesleft #1 - 'namesleft :=
%    }
%  while$
%}
FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
%% added by uta
%   numnames #4 >
%   {
%   #3 'namesleft :=
%% end uta.
    { namesleft #0 > }

%% 2002.12.09-begin by kamisima 
    { s nameptr "{ff}{ll}" format.name$ is.kanji.str$
      {s nameptr "{ff~~}{ll}" format.name$ 't :=
        t empty$
 	      { s nameptr "{ll}" format.name$ 't :=
	        t " には，姓と名の間に空白がないよ？ in " * cite$ * warning$
          }
 	      'skip$
 	    if$
 	  }
%%%% 2002.12.09-end by kamisima 
%%      {s nameptr "{ll,~~}{vv~}{f.}{, jj}" format.name$ 't :=}  %%
%% modified by uta --begin--
%   { nameptr #1 >  
%        { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=  } %２人目以降のときの出力
%        { s nameptr "{vv~}{ll}{, jj}{, f.}" format.name$ 't :=} %1人目の出力
%      if$}
%%%% 2012.06.21-begin modified by sugano
   { nameptr #1 >
		{s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=}  %$
		{s nameptr "{vv~}{ll}{,~jj}{ff}" format.name$ 't :=}
		if$}
		%{s nameptr "{vv~}{ll}{,~jj}{,~ff}" format.name$ 't :=} %modified Dec. 5, 2012 by sugano
%% 2012.06.21-end modified by sugano	
%% modified by uta --end--
    if$
    nameptr #1 >
	{ namesleft #1 >
            {", " * t * }
            { t "others,~" =
   	    { s is.kanji.str$
        	  {"~~他" * }
      	          {", et~al." * }
      	if$
      	}
        { s is.kanji.str$
      	  {", " * t * }
      	  { numnames #2 =
     	    {" and " * t * }
      	    {", and " * t * }
      	  if$
      	  }
      	if$
        }
	  if$
	  }
	if$
	}
	't
    if$
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
    }
  while$
%% added by uta
% }
%%
}
FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}
FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
 	{ editor is.kanji.str$
 		{"（編）" * } {" eds." * } if$
 	}
 	{ editor is.kanji.str$
 		{"（編）" *} {" ed." * } if$
 	}
      if$
    }
  if$
}

FUNCTION {format.title}
{ after.author 'output.state :=
  title empty$
    { "" }
% modified by uta --begin--
 	{ title is.kanji.str$
        { "「" title * "」" * "," * }
        { " ``" title * "," * "''" * } 
        if$
 	}
%    'title
%    { "{\em " title "t" change.case$ * "\/}" * }
% modified by uta --end--
  if$
}
FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
	{ t #1 #2 substring$ "--" = not
	    { "--" *
	      t #2 global.max$ substring$ 't :=
	    }
	    {   { t #1 #1 substring$ "-" = }
		{ "-" *
		  t #2 global.max$ substring$ 't :=
		}
	      while$
	    }
	  if$
	}
	{ t #1 #1 substring$ *
	  t #2 global.max$ substring$ 't :=
	}
      if$
    }
  while$
}
FUNCTION {format.date}
{ before.all 'output.state :=
  year empty$
     { "there's no year in " cite$ * warning$
       ""
     }
%     {" (" year * ")" * }
% modified by uta
     {", " year * }
%     {" "  year * "." }
   if$
}

FUNCTION {format.btitle}
{after.author 'output.state :=
title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}
FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}
FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { volume is.kanji.str$
	{ volume }
	{ is.kanji.entry
	    {"第" volume * "巻" *}
	    {"Vol." volume tie.or.space.connect}
	  if$
	}
      if$
      series empty$
	'skip$
	{ series is.kanji.str$
	    { volume empty$
		{series swap$ * }
		{series ", " * swap$ * }
	      if$
	    }
	    { " of " * series emphasize * }
	  if$
	}
      if$
      "volume and number" number either.or.check
    }
  if$
}
FUNCTION {format.number.series}
{ volume empty$
    { number empty$
	{ series field.or.null }
	{ number is.kanji.str$ 
	    { number }
	    {"No." number tie.or.space.connect}
	  if$
	  series empty$
	    { "there's a number but no series in " cite$ * warning$ }
	    { series is.kanji.str$
	        { series ", " * swap$ * }
	        { " in " * series * }
	      if$
	    }
	  if$
	}
      if$
    }
    { "" }
  if$
}
FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition is.kanji.str$
	{ edition }
        { is.kanji.entry
	    {"第" edition * "版" *}
	    { output.state mid.sentence =
	      { edition "l" change.case$ " edition" * }
	      { edition "t" change.case$ " edition" * }
              if$
	    }
	  if$
        }
      if$
    }
  if$
}
INTEGERS { multiresult }
FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
	{ #1 'multiresult := }
	{ t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}
FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
 	{ "pp." pages n.dashify tie.or.space.connect }
	{ "p." pages tie.or.space.connect }
      if$
    }
  if$
}
FUNCTION {format.vol.num.pages}
{ volume empty$
     {""}
     { volume is.kanji.str$
        {volume  ", " * }
        {"Vol." volume tie.or.space.connect ", " * }
       if$
     }
  if$
  number empty$
    'skip$
    { number is.kanji.str$
        {number *}
        {"No." number tie.or.space.connect *}
      if$
      volume empty$
	{ "there's a number but no volume in " cite$ * warning$ }
	'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
	{ pop$ format.pages }
	{ number empty$
 	    { format.pages * }
 	    { ", " * format.pages * }
	  if$
	}
      if$
    }
  if$
}
FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
	{ chapter is.kanji.str$
	    { "" }
	    { is.kanji.entry
		{"章"}
		{"chapter"}
	      if$
	    }
	  if$
	}
	{ type "l" change.case$ }
      if$
      chapter is.kanji.str$ not is.kanji.entry and
          {"第" chapter * swap$ *}
          { chapter is.kanji.str$
		{chapter *}
		{chapter tie.or.space.connect}
	    if$
	  }
      if$
      pages empty$
	'skip$
	{ ", " * format.pages * }
      if$
    }
  if$
}
FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
 	{ booktitle is.kanji.str$
 	    { " " booktitle emphasize * }
 	    { "in " booktitle emphasize * }
 	  if$
 	}
 	{ booktitle is.kanji.str$
 	    { " " format.editors * ", " * booktitle * }
 	    { "in " format.editors * ", " * booktitle emphasize * }
 	  if$
 	}
      if$
    }
  if$
}
FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and %%add
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}
FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}
FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}
FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
	{ "need key or journal for " cite$ * " to crossref " * crossref *
	  warning$
	  ""
	}
 	{ title is.kanji.str$
 	    { " " journal *  }
  	    { "in {\em " journal * "\/}" * }
          if$
	}
      if$
    }
    { title is.kanji.str$
 	{ " " key * }
  	{ "in " key * }
      if$
    }
  if$
  " \cite{" * crossref * "}" *
}
FUNCTION {format.crossref.editor}
{ editor is.kanji.str$
     {editor #1 "{ff}" format.name$ duplicate$
      empty$
 	{pop$ editor #1 "{ll}" format.name$}
 	'skip$
      if$
      }
      {editor #1 "{vv~}{ll}" format.name$}
  if$
  editor num.names$ duplicate$
  #2 >
    { editor is.kanji.str$
	  {pop$ "他" *} {pop$ ", et~al." * } if$
    }
    { #2 <
	'skip$
	{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
 	    { editor is.kanji.str$
 		{"他" *} {", et~al." * } if$
 	    }
 	    { editor is.kanji.str$
		{
		  ", " *
 		   editor #2 "{ff}" format.name$ duplicate$
 		   empty$
 			{pop$ editor #2 "{ll}" format.name$}
 			'skip$
 		   if$
 		 *
 		}
 		{" and " * editor #2 "{vv~}{ll}" format.name$ * }
 	      if$
 	    }
	  if$
	}
      if$
    }
  if$
}
FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
       title is.kanji.str$
 	{"  "} {"in "} if$
    }
    { volume is.kanji.str$
	{ volume }
	{ is.kanji.entry
	    {"第" volume * "巻" *}
	    {"Vol." volume tie.or.space.connect " of " *  }
	  if$
	}
      if$
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ series empty$
	    { "need editor, key, or series for " cite$ * " to crossref " *
	      crossref * warning$
	      "" *
	    }
	    { series is.kanji.str$
		{ series ", " * swap$ * }
	        { "{\em " * series * "\/}" * }
	      if$
	    }
	  if$
	}
	{ key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}
FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ booktitle empty$
	    { "need editor, key, or booktitle for " cite$ * " to crossref " *
	      crossref * warning$
	      ""
	    }
 	    { booktitle is.kanji.str$
 		{ booktitle }
 		{"in {\em " booktitle * "\/}" * }
 	       if$
 	    }
	  if$
	}
	{ "in " key * }
      if$
    }
    { title is.kanji.str$
 	{" " format.crossref.editor * }
 	{"in " format.crossref.editor * }
      if$
    }
  if$
  " \cite{" * crossref * "}" *
}
FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
}
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

%FUNCTION {format.book.pages}
%{ pages empty$
%    { "" }
%    { pages " pp." *}
%  if$
%}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.block
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  new.block
  note output
  fin.entry
}
FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.block
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.block
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  note output
  fin.entry
}
FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      new.block
      address empty$
	{ organization publisher new.sentence.checkb
          new.block
	  organization output
% added by uta --begin-- 
", " write$
% added by uta --end-- 
	  mid.sentence 'output.state :=
          new.block
	  publisher output
	  format.date "year" output.check
	}
	{ address output.nonnull
	  format.date "year" output.check
          new.block
	  organization output
	  mid.sentence 'output.state :=
          new.block
	  publisher output
	}
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$

  new.block
  note output
  fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
	'skip$
	{ organization output.nonnull
	  address output
	}
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  author empty$
    { organization empty$
	{ address new.block.checka
	  address output
	}
	'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output

  new.block
  note output
  fin.entry
}
FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title output
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  howpublished new.block.checka
  howpublished output
  format.date output
  new.block
  note output
  fin.entry
  empty.misc.check
}
FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  "PhD thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
	{ publisher new.sentence.checka }
	{ organization publisher new.sentence.checkb
	  organization output
	}
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.block
      editor empty$
	'skip$
	{ organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  fin.entry
}
FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
% added by uta --begin-- refer to hagihira's homepage
  " " 'separator :=
% added by uta --end-- refer to hagihira's homepage
  new.block
  note "note" output.check
  format.date output
  fin.entry
}
FUNCTION {default.type} { misc }

MACRO {jan} {"Jan."}
MACRO {feb} {"Feb."}
MACRO {mar} {"Mar."}
MACRO {apr} {"Apr."}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"Aug."}
MACRO {sep} {"Sept."}
MACRO {oct} {"Oct."}
MACRO {nov} {"Nov."}
MACRO {dec} {"Dec."}
MACRO {acmcs} {"ACM Comput. Surv."}
MACRO {acta} {"Acta Inf."}
MACRO {cacm} {"Commun. ACM"}
MACRO {ibmjrd} {"IBM J. Res. Dev."}
MACRO {ibmsj} {"IBM Syst.~J."}
MACRO {ieeese} {"IEEE Trans. Softw. Eng."}
MACRO {ieeetc} {"IEEE Trans. Comput."}
MACRO {ieeetcad}
 {"IEEE Trans. Comput.-Aided Design Integrated Circuits"}
MACRO {ipl} {"Inf. Process. Lett."}
MACRO {jacm} {"J.~ACM"}
MACRO {jcss} {"J.~Comput. Syst. Sci."}
MACRO {scp} {"Sci. Comput. Programming"}
MACRO {sicomp} {"SIAM J. Comput."}
MACRO {tocs} {"ACM Trans. Comput. Syst."}
MACRO {tods} {"ACM Trans. Database Syst."}
MACRO {tog} {"ACM Trans. Gr."}
MACRO {toms} {"ACM Trans. Math. Softw."}
MACRO {toois} {"ACM Trans. Office Inf. Syst."}
MACRO {toplas} {"ACM Trans. Prog. Lang. Syst."}
MACRO {tcs} {"Theoretical Comput. Sci."}
MACRO {tieice} {"信学論"}
MACRO {tipsj}  {"情報処理学会論文誌"}
MACRO {jsai} {"人工知能学会誌"}
MACRO {jipsj}  {"J.~Info. Proc. Soc. of Japan"}
MACRO {jorsj}  {"Journal of the O. R. Society of Japan"}

READ
FUNCTION {set.is.kanji.entry}
{
  author    field.or.null is.kanji.str$
  title     field.or.null is.kanji.str$ or
  editor    field.or.null is.kanji.str$ or
  journal   field.or.null is.kanji.str$ or
  booktitle field.or.null is.kanji.str$ or
  series    field.or.null is.kanji.str$ or
  'is.kanji.entry :=
}
ITERATE {set.is.kanji.entry}

FUNCTION {sortify}
{ purify$
  "l" change.case$
}
INTEGERS { len }
FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

INTEGERS { et.al.char.used }
FUNCTION {initialize.et.al.char.used}
{ #0 'et.al.char.used :=
}
EXECUTE {initialize.et.al.char.used}

%FUNCTION {format.lab.names}
%{ 's :=
%  yomi empty$
%     'skip$
%     { yomi 's :=}
%  if$
%  s  is.kanji.str$
%    { s #1 "{ff}" format.name$ #4 text.prefix$ duplicate$ empty$
%	{pop$ s #1 "{ll}" format.name$ #4 text.prefix$}
%	'skip$
%     if$
%    }
%    {
%      s num.names$ 'numnames :=
%      numnames #1 >
%	{ numnames #4 >
%	    { #3 'namesleft := }
%	    { numnames 'namesleft := }
%	  if$
%	  #1 'nameptr :=
%	  ""
%	    { namesleft #0 > }
%	    { nameptr numnames =
%		{ s nameptr "{ff }{vv }{ll}{ jj}" format.name$ "others" =
%		    { "{\etalchar{+}}" *
%		      #1 'et.al.char.used :=
%		    }
%		    { s nameptr "{v{}}{l{}}" format.name$ * }
%		  if$
%		}
%		{ s nameptr "{v{}}{l{}}" format.name$ * }
%	      if$
%	      nameptr #1 + 'nameptr :=
%	      namesleft #1 - 'namesleft :=
%	    }
%	  while$
%	  numnames #4 >
%	    { "{\etalchar{+}}" *
%	      #1 'et.al.char.used :=
%	    }
%	    'skip$
%	  if$
%	}
%	{ s #1 "{vv }{ll }" format.name$ %%full letters
%%	{ s #1 "{v{}}{l{}}" format.name$ %%2 letters
%	  duplicate$ text.length$ #2 <
%	    { pop$ s #1 "{ll}" format.name$ #3 text.prefix$ }
%	     'skip$
%	  if$
%	}
%      if$
%    }
%  if$
%}

FUNCTION {format.lab.names}
{ 's :=
  s  is.kanji.str$
    { s #1 "{ff}" format.name$ duplicate$ empty$
	{ pop$ s #1 "{ll}" format.name$ #4 text.prefix$
	  s #1 "{ll}" format.name$ " には，姓と名の間に空白がないよ？ in " *
             cite$ * warning$
        }
	'skip$
     if$
    }
    { s #1 "{ll}" format.name$ }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
	{ cite$ #1 #3 substring$ }
	{ key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
	{ key empty$
	    { cite$ #1 #3 substring$ }
	    { key #3 text.prefix$ }
	  if$
	}
	{ editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
	{ key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
	{ key #3 text.prefix$ }
      if$
    }
    { editor format.lab.names }
  if$
}

%%add
FUNCTION {format.lab.names.sort}
{ 's :=
  yomi empty$
     'skip$
     { yomi 's :=}
  if$
  s  is.kanji.str$
    { s #1 "{ff}" format.name$ duplicate$ empty$
	{ pop$ s #1 "{ll}" format.name$ #4 text.prefix$
	  s #1 "{ll}" format.name$ " には，姓と名の間に空白がないよ？ in " *
             cite$ * warning$
        }
	'skip$
     if$
    }
    { s #1 "{ll}" format.name$ }
  if$

}
FUNCTION {author.key.sort.label}
{ author empty$
    { key empty$

	{ cite$ #1 #3 substring$ }

	{ key #3 text.prefix$ }
      if$
    }
    { author format.lab.names.sort }
  if$
}

FUNCTION {author.editor.key.sort.label}
{ author empty$
    { editor empty$
	{ key empty$
	    { cite$ #1 #3 substring$ }
	    { key #3 text.prefix$ }
	  if$
	}
	{ editor format.lab.names.sort }
      if$
    }
    { author format.lab.names.sort }
  if$
}

FUNCTION {author.key.organization.sort.label}
{ author empty$
    { key empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
	{ key #3 text.prefix$ }
      if$
    }
    { author format.lab.names.sort }
  if$
}

FUNCTION {editor.key.organization.sort.label}
{ editor empty$
    { key empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
	{ key #3 text.prefix$ }
      if$
    }
    { editor format.lab.names.sort }
  if$
}
%%add

%FUNCTION {calc.label}
%{ type$ "book" =
%  type$ "inbook" =
%  or
%    'author.editor.key.label
%    { type$ "proceedings" =
%	'editor.key.organization.label
%	{ type$ "manual" =
%	    'author.key.organization.label
%	    'author.key.label
%	  if$
%	}
%      if$
%    }
%  if$
%  duplicate$
%  year field.or.null purify$ #-1 #2 substring$ %%%1999 --> 99
%%  year field.or.null sortify                  %%%1999 --> 1999
%  *
%  'label :=
%  year field.or.null purify$ #-1 #4 substring$
%  *
%  sortify 'sort.label :=
%}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
	'editor.key.organization.label
	{ type$ "manual" =
	    'author.key.organization.label
	    'author.key.label
	  if$
	}
      if$
    }
  if$
    year field.or.null purify$ #-1 #2 substring$
  duplicate$ empty$
    { pop$ "" }
    { " " swap$ * }
  if$
  *
  'label :=
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.sort.label
    { type$ "proceedings" =
	'editor.key.organization.sort.label
	{ type$ "manual" =
	    'author.key.organization.sort.label
	    'author.key.sort.label
	  if$
	}
      if$
    }
  if$
  year field.or.null purify$ #-1 #4 substring$
  *
  sortify 'sort.label :=
}

FUNCTION {sort.format.names}
{ 's :=
  yomi empty$
     'skip$
     { yomi 's := }
  if$
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
	{ ", " * }
	'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
 	{ s is.kanji.str$
 		{"他" * }
 		{"et~al." *}
	  if$
 	}
	{ t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
	{ "to sort, need author or key in " cite$ * warning$
	  ""
	}
	{ key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
	{ key empty$
	    { "to sort, need author, editor, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
	{ key empty$
	    { "to sort, need author, organization, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

%%add
FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
	{ key empty$
	    { "to sort, need editor, organization, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ calc.label
  sort.label
  "    "
  *
  type$ "book" =

  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
	'editor.organization.sort
	{ type$ "manual" =
	    'author.organization.sort
	    'author.sort
	  if$
	}
      if$
    }
  if$
  *
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}
ITERATE {presort}
SORT

STRINGS { longest.label last.sort.label next.extra }
INTEGERS { longest.label.width last.extra.num }
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.sort.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
}
FUNCTION {forward.pass}
{ last.sort.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.sort.label :=
    }
  if$
}
FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
  extra.label 'next.extra :=
}
EXECUTE {initialize.longest.label}
ITERATE {forward.pass}
REVERSE {reverse.pass}
FUNCTION {begin.bib}
{ et.al.char.used
    { "\newcommand{\etalchar}[1]{$^{#1}$}" write$ newline$ }
    'skip$
  if$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
%%%% 2002.12.13-begin by kamisima
%%  "\begin{thebibliography}{}" write$ newline$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
%% 2002.12.13-end by kamisima
%  "\begin{thebibliography}{\quad}" write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}
