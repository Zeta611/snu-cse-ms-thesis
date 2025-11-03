%%
%% This is file `snu-cse-ms-thesis.cls'.
%%
%% -----------------------------------------------------------------
%% The snu-cse-ms-thesis class --- A class for SNU CSE MS theses
%% Maintained by Jay Lee
%% E-mail: jaeho.lee@snu.ac.kr
%% Released under the MIT License.
%% -----------------------------------------------------------------
%%
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{expl3}
\ProvidesExplClass
  {snu-cse-ms-thesis}
  {2025/11/03}
  {1.0}
  {A class for SNU CSE MS theses}


%%%%%%%%%%%%%%%%%%%%%%%%%
% Options for the class %
%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareKeys {
  en .code = { \bool_set_true:N \l_snu_cse_ms_thesis_en_bool },
  ko .code = { \bool_set_false:N \l_snu_cse_ms_thesis_en_bool },
}
\SetKeys { ko }
\ProcessKeyOptions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XeLaTeX or LuaLaTeX required %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{iftex}
\ifXeTeX\else\ifLuaTeX\else
  \ClassError {snu-cse-ms-thesis}
    { This~class~only~supports~XeLaTeX~and~LuaLaTeX. }
    { Please~use~either~XeLaTeX~or~LuaLaTeX.~If~you~are~on~Overleaf,~go~to~Menu->Settings->Compiler~and~select~XeLaTeX~or~LuaLaTeX.}
\fi\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language-specific settings %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tl_const:Nn \l_snu_cse_ms_thesis_affiliation_ko { 서울대학교~대학원\\컴퓨터공학부 }
\tl_const:Nn \l_snu_cse_ms_thesis_abstractname_ko { 요약 }
\tl_const:Nn \l_snu_cse_ms_thesis_contentsname_ko { 목차 }
\tl_const:Nn \l_snu_cse_ms_thesis_listtablename_ko { 표~목차 }
\tl_const:Nn \l_snu_cse_ms_thesis_listfigurename_ko { 그림~목차 }
\tl_const:Nn \l_snu_cse_ms_thesis_bibname_ko { 참고문헌 }
\tl_const:Nn \l_snu_cse_ms_thesis_affiliation_en { Department~of~Computer~Science~and~Engineering\\Seoul~National~University }
\tl_const:Nn \l_snu_cse_ms_thesis_abstractname_en { Abstract }
\tl_const:Nn \l_snu_cse_ms_thesis_contentsname_en { Contents }
\tl_const:Nn \l_snu_cse_ms_thesis_listtablename_en { List~of~Tables }
\tl_const:Nn \l_snu_cse_ms_thesis_listfigurename_en { List~of~Figures }
\tl_const:Nn \l_snu_cse_ms_thesis_bibname_en { References }

% utility to make spaced author names
\cs_new:Npn \make_spaced:n #1
  { \tl_map_inline:Nn { #1 } { ##1~ } }
\cs_generate_variant:Nn \make_spaced:n { V }

\bool_if:NTF \l_snu_cse_ms_thesis_en_bool
  { % English main
    \LoadClass[11pt, b5paper]{report}
    \RequirePackage{kotex}


    \RequirePackage[doublespacing]{setspace}
    \RequirePackage{caption}
    % If the setspace is used in conjuction with the caption package, the caption
    % will be typeset with single spacing as default.
    \captionsetup[table]{font=onehalfspacing}
    \captionsetup[figure]{font=onehalfspacing}

    \newcommand\@approvalauthor{\@authoralt}
    \let\@affiliation\l_snu_cse_ms_thesis_affiliation_en
    \let\abstractname\l_snu_cse_ms_thesis_abstractname_en
    \let\contentsname\l_snu_cse_ms_thesis_contentsname_en
    \let\listtablename\l_snu_cse_ms_thesis_listtablename_en
    \let\listfigurename\l_snu_cse_ms_thesis_listfigurename_en
    \AddToHook {begindocument/before} {
      \let\oldprintbibliography\printbibliography
      \renewcommand{\printbibliography}{
        \oldprintbibliography[title=\l_snu_cse_ms_thesis_bibname_en]
      }
    }
  }
  { % Korean main
    \LoadClass[11pt, b5paper]{report}
    \RequirePackage[hangul]{kotex}

    \RequirePackage[doublespacing]{setspace}
    \RequirePackage[
      list=off,
      bi-separator=smallskip,
      font=onehalfspacing
    ]{bicaption}
    \bicaptionsetup[table]{name=표}{name=Table}
    \bicaptionsetup[figure]{name=그림}{name=Figure}

    \newcommand\@approvalauthor{\@author}
    \let\@affiliation\l_snu_cse_ms_thesis_affiliation_ko
    \let\abstractname\l_snu_cse_ms_thesis_abstractname_ko
    \let\contentsname\l_snu_cse_ms_thesis_contentsname_ko
    \let\listtablename\l_snu_cse_ms_thesis_listtablename_ko
    \let\listfigurename\l_snu_cse_ms_thesis_listfigurename_ko
    \AddToHook {begindocument/before} {
      \let\oldprintbibliography\printbibliography
      \renewcommand{\printbibliography}{
        \oldprintbibliography[title=\l_snu_cse_ms_thesis_bibname_ko]
      }
    }
  }


%%%%%%%%%%%%%%%%%%%%%%%%
% Package dependencies %
%%%%%%%%%%%%%%%%%%%%%%%%
% Subfigures
\RequirePackage{subcaption}

% Images
\RequirePackage{graphicx}

% Tables
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}

% Math
\RequirePackage{amssymb,amsmath,mathtools} % Before unicode-math
\RequirePackage[
  warnings-off={mathtools-colon, mathtools-overbracket},
]{unicode-math}


% Font
\RequirePackage{microtype}

\RequirePackage[tt=false]{libertine}
\setmathfont{LibertinusMath-Regular.otf}[Scale=MatchUppercase]
\setmathfont{LibertinusMath-Regular.otf}[range={\cup,\cap}, Scale=1.23]
\setmathfont{LibertinusMath-Regular.otf}[range={\vee,\wedge}, Scale=1.1]
\setmathfont{Stix Two Math}[Scale=MatchUppercase, version=Stix2, range={cal,\triangledown,\bigtriangledown}]
\setmonofont{inconsolata}[Scale=MatchLowercase, StylisticSet=3]
\setmainhangulfont{Noto Serif CJK KR}[Scale=MatchUppercase, InterLatinCJK=0.13em]
\setsanshangulfont{Noto Sans CJK KR}[Scale=MatchUppercase, InterLatinCJK=0.13em]

\RequirePackage[dvipsnames]{xcolor}

% Chapter style
\RequirePackage{titlesec}

% Bibliography
\RequirePackage[citestyle=acmauthoryear]{biblatex}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page layout configuration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\paperwidth}{182mm}
\setlength{\paperheight}{257mm}
\setlength{\textwidth}{132mm}
\setlength{\textheight}{192mm}
\addtolength{\hoffset}{-1in}
\addtolength{\voffset}{-1in}
\setlength{\topmargin}{30mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\marginparwidth}{0mm}
\setlength{\marginparsep}{0mm}
\setlength{\oddsidemargin}{25mm}
\setlength{\footskip}{20mm}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter / section style configuration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \titleformat{\chapter}
%   { \centering\normalfont\fontsize{16pt}{19pt}\selectfont\bfseries }
%   { 제\hspace{.2em}\thechapter\hspace{.2em}장 }
%   { .6em }
%   { }
%
% \renewcommand{\thesection}{\arabic{section}}
% \titleformat{\section}
%   { \normalfont\fontsize{14pt}{16pt}\selectfont\bfseries }
%   { 제\hspace{.2em}\thesection\hspace{.2em}절 }
%   { .6em }
%   { }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document metadata fields %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\clist_new:N \l_snu_cse_ms_thesis_keywords_ko_clist
\clist_new:N \l_snu_cse_ms_thesis_keywords_en_clist

\NewDocumentCommand \titlealt { m } { \newcommand*\@titlealt{#1} }
\NewDocumentCommand \authoralt { m } { \newcommand*\@authoralt{#1} }
\NewDocumentCommand \advisor { m } { \newcommand*\@advisor{#1} }
\NewDocumentCommand \committee { m m m }
  {
    \newcommand\@committeechair{#1}
    \newcommand\@committeevchair{#2}
    \newcommand\@committeemember{#3}
  }
\NewDocumentCommand \approvaldate { m } { \newcommand*\@approvaldate{#1} }
\NewDocumentCommand \graduationdate { m } { \newcommand*\@graduationdate{#1} }

\NewDocumentCommand \koreankeywords { m }
  { \clist_set:Nn \l_snu_cse_ms_thesis_keywords_ko_clist { #1 } }
\NewDocumentCommand \englishkeywords { m }
  { \clist_set:Nn \l_snu_cse_ms_thesis_keywords_en_clist { #1 } }

% https://github.com/latex3/hyperref/issues/242#issuecomment-1149845979

\definecolor[named]{ACMPurple}{cmyk}{0.55,1,0,0.15}
\definecolor[named]{ACMDarkBlue}{cmyk}{1,0.58,0,0.21}
\AddToHook {begindocument/before} {
  \hypersetup{
    colorlinks,
    linkcolor=black,
    citecolor=ACMPurple,
    urlcolor=ACMDarkBlue,
    filecolor=ACMDarkBlue,

    pdflang = { \bool_if:NTF \l_snu_cse_ms_thesis_en_bool { en } { ko } },
    pdfsubject = {공학석사~학위논문},
    pdfkeywords = {
      \clist_use:Nnnn \l_snu_cse_ms_thesis_keywords_en_clist { , } { , } { , },
      \clist_use:Nnnn \l_snu_cse_ms_thesis_keywords_ko_clist { , } { , } { , }
    },
  }
}

% Redefine \maketitle
\AtBeginDocument {
  % hyperref package redefines \@maketitle
  \def\HyOrg@maketitle{
    \newpage
    \null

    % 외표지
    \thispagestyle{empty}
    \begin{center}
      \fontsize{18}{21pt}\selectfont
      \textsc{M.S.~Thesis} \\[1cm]
      \fontsize{24pt}{27pt}\selectfont
      \@title \\[0.5cm]
      \fontsize{18pt}{21pt}\selectfont
      \@titlealt \\
      \vfill
      \fontsize{18pt}{21pt}\selectfont
      \@graduationdate \\
      \vfill
      \fontsize{18pt}{21pt}\selectfont
      \@affiliation \\[0.5cm]
      \textsc{\@author}
    \end{center}
    \newpage

    % 내표지
    \thispagestyle{empty}
    \begin{center}
      \fontsize{18}{21pt}\selectfont
      \textsc{M.S.~Thesis} \\[1cm]
      \fontsize{24pt}{27pt}\selectfont
      \@title \\[0.5cm]
      \fontsize{18pt}{21pt}\selectfont
      \@titlealt \\
      \vfill
      \fontsize{18pt}{21pt}\selectfont
      \@graduationdate \\
      \vfill
      \fontsize{18pt}{21pt}\selectfont
      \@affiliation \\[0.5cm]
      \textsc{\@author}
    \end{center}
    \newpage

    % 인준지
    \thispagestyle{empty}
    \begin{center}
      \fontsize{20pt}{23pt}\selectfont
      \@title \\[0.5cm]
      \fontsize{18pt}{21pt}\selectfont
      \@titlealt \\
      \vfill
      \fontsize{16pt}{19pt}\selectfont
      지도교수~~\make_spaced:V \@advisor \\
      \fontsize{18pt}{21pt}\selectfont
      이~논문을~공학석사~학위~논문으로~제출함 \\
      \fontsize{16pt}{19pt}\selectfont
      \@date \\
      \vfill
      \fontsize{18pt}{21pt}\selectfont
      서울대학교~대학원 \\
      \fontsize{16pt}{19pt}\selectfont
      컴퓨터공학부 \\
      \fontsize{18pt}{21pt}\selectfont
      \make_spaced:V \@approvalauthor \\
      \vfill
      \@approvalauthor의~공학석사~학위논문을~인준함 \\
      \fontsize{16pt}{19pt}\selectfont
      \@approvaldate \\
      \vfill
      \begin{tblr}{colspec={c Q[c,8em] c}}
        \makebox[4em][s]{위원장} & \make_spaced:n { \@committeechair } & (인) \\
        \makebox[4em][s]{부위원장} & \make_spaced:n { \@committeevchair } & (인) \\
        \makebox[4em][s]{위원} & \make_spaced:n { \@committeemember } & (인)
      \end{tblr}
    \end{center}
    \newpage
  }
}

% Redefine \baselinestretch for ToCs
\let\@starttoc@orig\@starttoc
\def\@starttoc#1{
  \begin{onehalfspace}
    \@starttoc@orig{#1}
  \end{onehalfspace}
}

\cs_generate_variant:Nn \text_purify:n {V}

\RenewDocumentEnvironment { abstract } { o }
  {
    \IfValueTF { #1 }
      {
        \tl_if_eq:nnTF { #1 } { ko }
          { % Korean abstract
            \chapter*{\l_snu_cse_ms_thesis_abstractname_ko}
            \addcontentsline{toc}{chapter}
              {\text_purify:V\l_snu_cse_ms_thesis_abstractname_ko}
          }
          {
            \tl_if_eq:nnTF { #1 } { en }
              { % English abstract
                \chapter*{\l_snu_cse_ms_thesis_abstractname_en}
                \addcontentsline{toc}{chapter}
                  {\text_purify:V\l_snu_cse_ms_thesis_abstractname_en}
              }
              { % Unrecognized language
                \ClassError { snu-cse-ms-thesis }
                  { Unrecognized~language:~`#1' }
                  { Please~use~either~`ko'~or~`en' }

                \chapter*{\abstractname}
                \addcontentsline{toc}{chapter}{\abstractname}
              }
          }
      }
      { % No language specified
        \chapter*{\abstractname}
        \addcontentsline{toc}{chapter}{\abstractname}
      }
  }
  {
    \vfill
    \IfValueTF { #1 }
      {
        \tl_if_eq:nnTF { #1 } { ko }
          { % Korean abstract
            \noindent 주요어:~\clist_use:Nnnn \l_snu_cse_ms_thesis_keywords_ko_clist { ,~ } { ,~ } { ,~ }
          }
          {
            \tl_if_eq:nnTF { #1 } { en }
              { % English abstract
              \noindent \textbf{Keywords:}~\clist_use:Nnnn \l_snu_cse_ms_thesis_keywords_en_clist { ,~ } { ,~ } { ,~ }
              }
              { % Unrecognized language
                \noindent \textbf{주요어:}~\clist_use:Nnnn \l_snu_cse_ms_thesis_keywords_ko_clist { ,~ } { ,~ } { ,~ }
              }
          }
      }
      { % No language specified
        \bool_if:NTF \l_snu_cse_ms_thesis_en_bool
          { % English main
            \noindent \textbf{Keywords:}~\clist_use:Nnnn
              \l_snu_cse_ms_thesis_keywords_en_clist { ,~ } { ,~ } { ,~ }
          }
          { % Korean main
            \noindent \textbf{주요어:}~\clist_use:Nnnn
              \l_snu_cse_ms_thesis_keywords_ko_clist { ,~ } { ,~ } { ,~ }
          }
      }
  }
