%%
%% simplepaper.cls -- 学生向けのシンプルな和文2段組論文クラス
%%
%% jarticle を派生させた，学会スタイルに依存しない論文クラスです．
%% 研究会予稿・ゼミ資料・卒論／修論の下書きなど，「2段組の論文らしい体裁」が
%% 必要な場面で使うことを想定しています．
%%
%% 版面と文字の大きさは，情報処理学会論文誌の投稿スタイル（ipsj.cls の submit
%% モード）に近い値に合わせてあります．
%%   本文     9.61pt / 行送り 14.94pt
%%   見出し   11.83pt ボールド（和文はゴシック）
%%   タイトル 19.2pt ゴシック
%%   版面     176.8mm x 249.5mm，段間 8mm
%%
%% 使い方（詳細は paper.tex を参照）:
%%   \documentclass{simplepaper}             % A4，2段組
%%   \documentclass[onecolumn]{simplepaper}  % 1段組（卒論・修論向け）
%%   \documentclass[linenumber]{simplepaper} % 行番号つき（添削してもらうとき）
%%
%% エンジンは pLaTeX + dvipdfmx を想定しています（latexmkrc の設定どおり）．
%%
%% This file is free to use, modify and redistribute without restriction.
%%
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{simplepaper}[2026/08/03 v1.1 Simple two-column Japanese paper class]

%% 任意の大きさの Computer Modern を使えるようにする（本文 9.61pt などのため）．
%% クラス本体の読み込みより前に置く必要がある．
\RequirePackage{fix-cm}


%% ============================================================
%% クラスオプション
%% ============================================================
\newif\if@sptwocolumn \@sptwocolumntrue
\DeclareOption{twocolumn}{\@sptwocolumntrue}
\DeclareOption{onecolumn}{\@sptwocolumnfalse}

\newif\if@splineno \@splinenofalse
\DeclareOption{linenumber}{\@splinenotrue}

%% 上記以外のオプション（draft など）は jarticle に渡す
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{jarticle}}
\ProcessOptions\relax

\if@sptwocolumn
  \LoadClass[a4paper,10pt,twocolumn]{jarticle}
\else
  \LoadClass[a4paper,10pt,onecolumn]{jarticle}
\fi

%% pLaTeX + dvipdfmx で使うため，ドライバ依存のパッケージに dvipdfmx を渡しておく．
%% （これがないと hyperref が図やリンクを正しく出力できない）
\PassOptionsToPackage{dvipdfmx}{graphicx}
\PassOptionsToPackage{dvipdfmx}{color}
\PassOptionsToPackage{dvipdfmx}{xcolor}
\PassOptionsToPackage{dvipdfmx}{hyperref}


%% ============================================================
%% 版面
%% ============================================================
\RequirePackage[a4paper,
  textwidth=176.8mm, textheight=249.5mm, centering,
  columnsep=8mm]{geometry}

\if@splineno
  \RequirePackage{lineno}
  \AtBeginDocument{\linenumbers}
\fi

\setlength{\parindent}{1zw}
\setlength{\columnseprule}{0pt}


%% ============================================================
%% 文字の大きさ
%% ============================================================
%% 情報処理学会論文誌（投稿スタイル）の指定に合わせた値．
\renewcommand{\normalsize}{%
  \@setfontsize\normalsize{9.61pt}{14.94pt}%
  \abovedisplayskip 9\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2.5\p@
  \belowdisplayshortskip 5\p@ \@plus2\p@ \@minus2\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}

\renewcommand{\small}{%
  \@setfontsize\small{8.87pt}{12.80pt}%
  \abovedisplayskip 7\p@ \@plus2\p@ \@minus3\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \belowdisplayskip \abovedisplayskip}

\renewcommand{\footnotesize}{%
  \@setfontsize\footnotesize{8.13pt}{11.50pt}%
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus3\p@
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
  \belowdisplayskip \abovedisplayskip}

\renewcommand{\scriptsize}{\@setfontsize\scriptsize{7.40pt}{10.00pt}}
\renewcommand{\tiny}{\@setfontsize\tiny{6.20pt}{8.00pt}}
\renewcommand{\large}{\@setfontsize\large{11.83pt}{14.94pt}}
\renewcommand{\Large}{\@setfontsize\Large{13.31pt}{18.00pt}}
\renewcommand{\LARGE}{\@setfontsize\LARGE{16.26pt}{21.00pt}}
\renewcommand{\huge}{\@setfontsize\huge{19.22pt}{24.19pt}}
\renewcommand{\Huge}{\@setfontsize\Huge{22.18pt}{28.00pt}}

\AtBeginDocument{\normalsize}

%% 見出しの書体
%% pLaTeX では \bfseries が和文をゴシックに切り替えるため，
%% 欧文は Computer Modern のボールド，和文はゴシックになる（IPSJ と同じ）．
\newcommand{\sp@headfont}{\bfseries}
\newcommand{\sp@titlefont}{\fontsize{19.22pt}{24.19pt}\bfseries\selectfont}
\newcommand{\sp@authorfont}{\fontsize{11.83pt}{15.65pt}\selectfont}
\newcommand{\sp@abstfont}{\fontsize{8.87pt}{12.80pt}\selectfont}


%% ============================================================
%% 表題まわりの宣言コマンド
%% ============================================================
%% \title{タイトル}         必須
%% \author{著者名}           必須．複数人は \and で区切る
%% \affiliation{所属}        任意
%% \email{連絡先}            任意
%% \date{日付}               任意（既定では表示しない）
%%
%% \begin{abstract} ... \end{abstract}   アブストラクト
%% \keyword{キーワード，...}              キーワード
%%
%% いずれも \maketitle より前に書いてください．

\let\sp@affiliation\@empty
\newcommand{\affiliation}[1]{\gdef\sp@affiliation{#1}}

\let\sp@email\@empty
\newcommand{\email}[1]{\gdef\sp@email{#1}}

\let\sp@keyword\@empty
\newcommand{\keyword}[1]{\gdef\sp@keyword{#1}}

%% 日付は既定では出さない（出したいときは \date{\today} と書く）
\date{}

%% 複数著者の区切り
\renewcommand{\and}{\hskip 1.5zw}


%% ============================================================
%% アブストラクトの取り込み
%% ============================================================
%% 表題の下に組むため，本文より先に箱へ詰めておく．
\newbox\sp@abstractbox
\newdimen\sp@abstwidth

\AtBeginDocument{\sp@abstwidth=.8\textwidth}

%% 見出し語（概要）は本文の1文目に続けて組む．
%% \input するファイルの冒頭にコメント行や空行があっても見出し語が
%% 単独行にならないよう，最初の段落が始まった時点で挿入する．
\newcommand{\sp@runinlabel}[1]{%
  \everypar{{\setbox\z@\lastbox}\everypar{}%
    \noindent{\sp@headfont #1}\hskip 1zw}%
}

\renewenvironment{abstract}{%
  \global\setbox\sp@abstractbox=\vbox\bgroup
    \hsize=\sp@abstwidth \linewidth=\hsize
    \parindent=1zw
    \sp@abstfont
    \sp@runinlabel{概要}\ignorespaces
}{%
  \par\egroup
}

%% キーワード行（アブストラクトと同じ幅で組む）
\newcommand{\sp@putkeyword}[2]{%
  \vbox{%
    \hsize=\sp@abstwidth \linewidth=\hsize
    \sp@abstfont\noindent
    \hangindent=6zw \hangafter=1
    {\sp@headfont #1}\hskip 1zw #2\par}%
}


%% ============================================================
%% \maketitle
%% ============================================================
\newcommand{\sp@titleblock}{%
  \begin{center}%
    {\sp@titlefont \@title \par}%
    \vskip 6mm
    {\sp@authorfont \@author \par}%
    \ifx\sp@affiliation\@empty\else
      \vskip 2mm {\normalsize \sp@affiliation \par}%
    \fi
    \ifx\sp@email\@empty\else
      \vskip 1mm {\small \texttt{\sp@email} \par}%
    \fi
    \ifx\@date\@empty\else
      \vskip 2mm {\small \@date \par}%
    \fi
  \end{center}%
  \ifvoid\sp@abstractbox\else
    \vskip 4mm
    \noindent\hbox to \textwidth{\hfil\box\sp@abstractbox\hfil}%
  \fi
  \ifx\sp@keyword\@empty\else
    \vskip 5mm
    \noindent\hbox to \textwidth{\hfil\sp@putkeyword{キーワード}{\sp@keyword}\hfil}%
  \fi
  \vskip 10mm
}

\renewcommand{\maketitle}{%
  \if@sptwocolumn
    \twocolumn[\sp@titleblock]%
  \else
    \sp@titleblock
  \fi
  \thispagestyle{plain}%
  \setcounter{footnote}{0}%
  \global\let\maketitle\relax
  \global\let\@title\@empty
}


%% ============================================================
%% 見出し
%% ============================================================
%% 「1. はじめに」「1.1 背景」の形式にする．
%% \ref で参照したときは「1」「1.1」（末尾のピリオドなし）になる．
\def\@seccntformat#1{%
  \@ifundefined{sp@cnt@#1}%
    {\csname the#1\endcsname\hskip 1zw}%
    {\csname sp@cnt@#1\endcsname}%
}
\expandafter\def\csname sp@cnt@section\endcsname{\thesection.\hskip 1zw}

\renewcommand{\section}{%
  \@startsection{section}{1}{\z@}%
    {1.1\baselineskip \@plus .3\baselineskip \@minus .2\baselineskip}%
    {.35\baselineskip \@plus .1\baselineskip}%
    {\reset@font\large\sp@headfont}}

\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
    {.9\baselineskip \@plus .3\baselineskip \@minus .2\baselineskip}%
    {.3\baselineskip \@plus .1\baselineskip}%
    {\reset@font\normalsize\sp@headfont}}

\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
    {.8\baselineskip \@plus .3\baselineskip \@minus .2\baselineskip}%
    {.25\baselineskip \@plus .1\baselineskip}%
    {\reset@font\normalsize\sp@headfont}}

%% 番号を振るのは subsubsection まで
\setcounter{secnumdepth}{3}


%% ============================================================
%% 図表のキャプション
%% ============================================================
%% 「図 1 キャプション」の形式．1行に収まるときは中央揃え．
\setlength{\abovecaptionskip}{5pt}
\setlength{\belowcaptionskip}{2pt}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \footnotesize
  \sbox\@tempboxa{{\sp@headfont #1}\hskip 1zw #2}%
  \ifdim \wd\@tempboxa >\hsize
    \noindent{\sp@headfont #1}\hskip 1zw #2\par
  \else
    \global\@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%% 図表は原則としてページ／カラム上部に置く
\setcounter{topnumber}{3}
\renewcommand{\topfraction}{0.9}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.8}


%% ============================================================
%% 参考文献
%% ============================================================
\renewcommand{\refname}{参考文献}

\let\sp@orig@thebibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \sp@orig@thebibliography{#1}%
  \small
  \setlength{\itemsep}{0\p@}%
  \setlength{\parsep}{0\p@}%
}


%% ============================================================
%% その他
%% ============================================================
%% ページ番号は下中央
\pagestyle{plain}

%% 脚注
\setlength{\footnotesep}{0.7\baselineskip}

\endinput
