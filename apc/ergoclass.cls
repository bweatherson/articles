%
%	This is a class file for typesetting Ergo articles.
%
%
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ergoclass}
[2016/08/14 v0.8 Template for Ergo articles]
% Version v0.8 - April 2, 2018 (includes the optional author note for the title)
% Version v0.7 - August 14, 2017
% Version v0.6 - January 22, 2017
% Version v0.4 - March 6, 2016
% Version v0.2 - September 6, 2015
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt, twoside, english]{article}
\RequirePackage[english]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{amsmath} % August 2017 - something down the line requires this, but who knows what?
\RequirePackage{fancyhdr}
\RequirePackage[osf]{mathpazo}
%\RequirePackage{kpfonts}
%\RequirePackage[authoryear]{natbib}
\RequirePackage[authoryear, sort, longnamesfirst]{natbib}% August 18, 2017
  %  the longnamesfirst option automatically uses the full list of author names rather than "Smith et al." for
  %  the first instance of a given citation. We inherit this rule from the APA Style guidelines.  However, APA
  %  also says that we should simply use "et al." from the beginning if there are more than five authors. In order
  %  to do this, we can include the bib keys in the command \shortcites{}. 
\RequirePackage{lettrine}
	\renewcommand{\DefaultLoversize}{0.3}
\RequirePackage{graphicx}
	\newcommand{\headerdot}{\raisebox{-1.5pt}[0pt][0pt]{\resizebox{6pt}{9pt}{$\cdot$}}}
	\newcommand{\footerdot}{\raisebox{-3pt}[0pt][0pt]{\resizebox{6pt}{9pt}{$\cdot$}}}
\RequirePackage[hyperfootnotes=false]{hyperref}
	\urlstyle{rm}
    
%% This sets up the layout of the document
%% headsep determines how far above the body text the header sits
%% top, bottom, left, and right determine the page margins.
%%
\RequirePackage[twoside=true, headsep=.25in, headheight=1in, footskip=.35in, papersize={7in,10in}, top=1in, bottom=1in, inner=.8in, outer=.8in]{geometry}

% Sept. 6, 2015 - Adapted from http://tex.stackexchange.com/questions/97697/different-styles-for-citet-and-citep-in-regards-of-the-and-or-between-au
% This replaces "and" in parenthetical citations with 
\RequirePackage{xstring}
\let\origNAT@nmfmt\NAT@nmfmt
\def\NAT@nmfmt#1{%
  \ifNAT@swa
    \exploregroups\expandarg
    \StrSubstitute{#1}{ and }{ \& }[\mynatfmttemp]%
  \else
    \def\mynatfmttemp{#1}%
  \fi
  \origNAT@nmfmt{\mynatfmttemp}%
}
%\RequirePackage[babel = true, tracking=alltext, letterspace=20]{microtype}
%\DeclareMicrotypeBabelHook{english}


%% These are the commands that collect additional information for the title page, headers, and footers.
\newcommand*{\affiliation}[1]{\gdef\@affiliation{#1}}
\affiliation{}
\newcommand*{\articledoi}[1]{\gdef\@doi{#1}}
\articledoi{}
\newcommand*{\volumeissueyear}[3]{\gdef\@volume{#1}\gdef\@issue{#2}\gdef\@year{#3}}
\volumeissueyear{}{}{}
\newcommand*{\contact}[1]{\gdef\@contact{#1}}
\contact{}
\author{}
\newcommand{\textofabstract}[1]{\gdef\@textofabstract{#1}}
\textofabstract{}
\gdef\@authornote{}
\newcommand{\authornote}[1]{\gdef\@authornote{\** #1}}

%\newcommand*{\abbreviations}[1]{\gdef\@abbreviation{#1}}
%\abbreviations{}

%% This changes some of the functionality of the \maketitle command.
%%
\renewcommand\maketitle{
  \begingroup
  \@makingtitletrue
    \setlength{\parskip}{0pt plus 0pt minus 0pt}
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
               \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  	\newpage
  	\null
	\noindent{}\begin{minipage}[l]{4in}
		\vskip 53.3pt plus 0pt minus 0pt
		{\LARGE \textsc{\@title}\par}%			% This sets the text of the title.
	\vskip 15pt plus 0pt minus 0pt
	\if@multiauthor{
		{\Huge\MakeUppercase{\@author
        \ifx\@authornote\empty
        \else
            \ifx\@authortwo\@empty
                \ifx\authorthree\@empty 
                    \**
                \else
                \fi
            \else
            \fi
        \fi
        }\par}
		{\normalsize\textit{\@affiliation}\par}
		\vskip 14pt plus 0pt minus 0pt
		{\Huge\MakeUppercase{\@authortwo
        \ifx\@authornote\empty
        \else
            \ifx\@authorthree\@empty 
                \**
            \else
            \fi
        \fi
        }\par}
		{\normalsize\textit{\@affiliationtwo}\par}
		\ifx\@authorthree\@empty\else{
		\vskip 14pt plus 0pt minus 0pt
		{\Huge\MakeUppercase{\@authorthree\ifx\@authornote\empty\else\**\fi}\par}
		{\normalsize\textit{\@affiliationthree}\par}
		}\fi}
	\else{
		{\Huge\MakeUppercase{\@author\ifx\@authornote\empty\else\**\fi}\par	}
		{\normalsize\textit{\@affiliation}\par}
	}\fi
\end{minipage}
	\if@multiauthor{%
		\ifx\@multiauthorcontact\@empty
            \ifx\@authornote\@empty
            \else\contactnote{
                \begin{flushleft}
                \@authornote
                \end{flushleft}}
            \fi
        \else\contactnote{
				\begin{flushleft}		% Jan 22 2017
				\ifx\@authornote\@empty\else{\@authornote \\}\fi
                \@multiauthorcontact
				\end{flushleft}		% Jan 22 2017
			}
        \fi
		}
	\else{
		\ifx\@contact\@empty
            \ifx\@authornote\@empty
            \else\contactnote{
                \begin{flushleft}
                \@authornote
                \end{flushleft}}
            \fi
        \else	% does nothing if it is empty
			\contactnote{%
				\begin{flushleft}		% Jan 22 2017
                \ifx\@authornote\@empty\else{\@authornote \\}\fi
				\textbf{Contact: }\@author~<\@contact>
				\end{flushleft}			% Jan 22 2017
			}
		\fi
%		\ifx\@abbreviation\@empty\else	% does nothing if it is empty
%			\abbreviationnote{%
%				\textbf{Abbreviations:}\@abbreviation
%			}
%		\fi
		
	}\fi
\vskip 30pt plus 0pt minus 0pt




\thispagestyle{plain}%\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
%  \global\let\maketitle\relax
%  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
%  \global\let\@author\@empty
  \global\let\@date\@empty
%  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
 
 \begin{abstract}\@textofabstract\end{abstract}
}

%% This redefines the abstract environment to look how we want
\renewenvironment{abstract}
 {\list{}{
    \setlength{\leftmargin}{.25in}				% The size of the margin is adjusted here
    \setlength{\rightmargin}{\leftmargin}			%
  }
  \item\relax
  \small}							% The font size category is determined here, although what that size is is determined below
 %{\par\normalsize\endlist}
 {\vskip -12pt plus 0pt minus 0pt\null\endlist}			% This line returns the font size to normal and
								% determines the spacing between the abstract and
								% the beginning of the body text
% This sizes the line above the footnotes
\renewcommand{\footnoterule}{%			
  \kern -3pt
  \hrule width 1in height .4pt
  \kern 2.6pt
}

%% This defines the unnumbered footnote for the contact information
\def\contactnote{%					
  \xdef\@thefnmark{}\@footnotetext
}
%%% This defines the unnumbered footnote for abbreviations, if they are included.
%\def\abbreviationnote{%
%	\xdef\@thefnmark{}\@footnotetext
%}

%% Non-superscript numerals for footnote text numbering
\renewcommand\@makefntext[1]{% 
    \parindent .25in%
    \@thefnmark.~#1}%

%% Resize footnote markers in the body text
\renewcommand{\@makefnmark}{\hbox{\textsuperscript{\scriptsize{\@thefnmark}}}}

%% Header and footer for the title page
\fancypagestyle{plain}{%
\fancyhf{} 
%\fancyhead[L]{Ergo: An Open Access Journal of Philosophy}
\fancyhead[L]{\raisebox{-.425in}[0pt][0pt]\ergo}		% The raisebox value determines the placement of the logo,
\fancyfoot[R]{\thepage}						% although this is also affected by headsep in the
\fancyfoot[L]{\url{\@doi}}						% geometry package
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}

\newcommand{\@authorheader}{%
	\if@multiauthor{
		\ifx\@authorthree\@empty{\@author{} and \@authortwo{}}
		\else{\@author{}, \@authortwo{}, and \@authorthree{}}
		\fi}
	\else{\@author}
	\fi}
%% Header and footer for the non-title pages
\pagestyle{fancy}
\fancyhead{}
\fancyhead[LE]{\raisebox{-3pt}[0pt][0pt]{\thepage\quad$\headerdot$\quad\textit{\@authorheader}}}
\fancyhead[RO]{\raisebox{-3pt}[0pt][0pt]{\textit{\@title}\quad$\headerdot$\quad\thepage}}
\cfoot{\textit{Ergo} $\footerdot$ \textit{vol. \@volume, no. \@issue} $\footerdot$ \textit{\@year}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

%% The logo in the header of the title page
\newcommand{\ergo}{%
{\huge{\textbf{Ergo}}}
{\tiny JOURNAL OF PHILOSOPHY \kern-76.8pt \raisebox{5.9pt}{AN OPEN ACCESS}}
%{\tiny \kern-1pt JOURNAL OF PHILOSOPHY \kern-74pt \raisebox{6pt}{AN OPEN ACCESS}}
}


%% Periods at the end of (sub(sub))section numbers in the headigs, but not in references
%% this also sets the space between the (sub(sub))section number and the title of that section.
\renewcommand*{\@seccntformat}[1]{%
  \csname the#1\endcsname.$\:$%			
}

%% Font sizes
\renewcommand\normalsize{\@setfontsize\normalsize{10.5pt}{14pt}}	% body text, affiliation, figures 
									% header and footer text.
\renewcommand\tiny{\@setfontsize\tiny{5.5pt}{6pt}}				% small logo font
\renewcommand\scriptsize{\@setfontsize\scriptsize{7pt}{8.5pt}}			% nothing? (NB: Ripley's paper uses this command)
\renewcommand\footnotesize{\@setfontsize\footnotesize{9pt}{11.5pt}}		% footnotes
\renewcommand\small{\@setfontsize\small{9pt}{13pt}}				% abstract (easily changed - defined in this class)
\renewcommand\large{\@setfontsize\large{11.5pt}{12pt}}				% subsection and subsubsection headings
\renewcommand\Large{\@setfontsize\Large{12pt}{14pt}}			% section headings
\renewcommand\LARGE{\@setfontsize\LARGE{18pt}{22pt}}			% title
%\renewcommand\huge{\@setfontsize\huge{10pt}{13pt}}			% The Ergo logo uses the default size of huge
\renewcommand\Huge{\@setfontsize\Huge{9.5pt}{13.5pt}}			% This is used for the author name

%% The section styles
%\renewcommand\section{\@startsection {section}{1}{\z@}%			% For all of these, we remove \bfseries from the 
%                                   {-4.6ex \@plus -1ex \@minus -.2ex}%			% style argument.
%                                   {2.3ex \@plus.2ex}%
%                                   {\normalfont\Large\bfseries}}
%\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%		% Here, we include \itshape (which might render 
%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%			% \normalfont obsolete).
%                                     {1.5ex \@plus .2ex}%
%                                     {\normalfont\large\itshape}}
%\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
%                                     {1.5ex \@plus .2ex}%
%                                     {\normalfont\large}}
\renewcommand\section{\@startsection {section}{1}{\z@}%			% For all of these, we remove \bfseries from the 
                                   {-4.6ex \@plus 0ex \@minus 0ex}%			% style argument.
                                   {2.3ex \@plus 0ex}%
                                   {\normalfont\Large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%		% Here, we include \itshape (which might render 
				     {-2.3ex \@plus 0ex \@minus 0ex}				% \normalfont obsolete).
                                     %{-3.25ex\@plus 0ex \@minus 0ex}%			
				     {2.3ex \@plus 0ex \@minus 0ex}
                                     %{1ex \@plus 0ex}%
                                     {\normalfont\large\itshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
				     {-2.3ex \@plus 0ex \@minus 0ex}
                                     %{-3.25ex\@plus 0ex \@minus 0ex}%
				     {2.3ex \@plus 0ex \@minus 0ex}
                                     %{1.5ex \@plus 0ex}%
                                     {\normalfont\large}}						% Some changes to section spacing on Sept. 2, 2015


\setlength{\bibhang}{.25in}% This determines the length of the hanging indent in the bibliography.
\setlength{\bibsep}{0pt}%

%% We alter the captions of figures and tabels to use a period rather than a comma
\renewcommand\@makecaption[2]{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1. #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\newenvironment{ergodescription}[1][]%
               {
		\ifx#1\@empty\else
			\null\par\textbf{#1}
		\fi
		\list{}{%
			\setlength{\leftmargin}{.25in}
			\setlength{\rightmargin}{\leftmargin}
			\labelwidth\z@
			%\itemindent\z@
			\let\makelabel\ergolabel
			}}
               {\endlist}
\newcommand*\ergolabel[1]{\hspace\labelsep
                                \normalfont\itshape #1}

\setlength\parindent{.25in}

\newif\if@makingtitle\@makingtitlefalse
\newcommand\titlelinebreak{
\leavevmode\unskip
\if@makingtitle%
\\
\ignorespaces
\else\fi
}

\newif\if@multiauthor\@multiauthorfalse

\newcommand{\multiauthor}[9]{%
\@multiauthortrue
\gdef\@author{#1}	
\gdef\@affiliation{#2}	
\gdef\@contact{#3}	
\gdef\@authortwo{#4}
\gdef\@affiliationtwo{#5}
\gdef\@contacttwo{#6}
\gdef\@authorthree{#7}
\gdef\@affiliationthree{#8}
\gdef\@contactthree{#9}
\gdef\@contact@one{\@author~<\@contact>}
\gdef\@contact@two{\@authortwo~<\@contacttwo>}
\gdef\@contact@three{\@authorthree~<\@contactthree>}

\newcommand\@contactbuild[1]{
\g@addto@macro\@multiauthorcontact{##1}
}

\gdef\@multiauthorcontact{\textbf{Contact: }}
\ifx\@contact\@empty{
	\ifx\@contacttwo\@empty{
		\ifx\@contactthree\@empty{\gdef\@multiauthorcontact{}}%all empty
		\else{\@contactbuild{\@contact@three}}	% three full
		\fi}
	\else{\@contactbuild{\@contact@two}
		\ifx\@contactthree\@empty{}
		\else{\@contactbuild{, \@contact@three}}% 
		\fi}
	\fi}
\else{\@contactbuild{\@contact@one}
	\ifx\@contacttwo\@empty{
		\ifx\@contactthree\@empty{}% one full
		\else{\@contactbuild{, \@contact@three}}	% one full, three full
		\fi}
	\else{\@contactbuild{, \@contact@two}
		\ifx\@contactthree\@empty{}			%one, two
		\else{\@contactbuild{, \@contact@three}}  	%one, two, three
		\fi}
	\fi}
\fi
}

\setlength{\parskip}{0pt plus 0pt minus 0pt} % September  2 2015

\setcitestyle{aysep={},yysep={;},notesep={: }} % September 12, 2015

\newcommand*\ergoitemlabel[1]{\rlap \hss (#1)} % September 6, 2015

\newenvironment{ergoitemize}[1][]{%
		\ifx#1\@empty\else
		\null\par\hspace{.25in}\textbf{#1}
		\fi
	\begin{list}{}{
		\setlength{\leftmargin}{.5in}
		\setlength{\rightmargin}{\leftmargin}
		\setlength{\labelwidth}{.4in}
		\setlength{\labelsep}{.1in}
		\setlength{\listparindent}{.25in}
		\setlength{\parsep}{0pt plus 1pt minus 1pt}
		\let\makelabel\ergoitemlabel
	}}
	{\end{list}}

\renewenvironment{quotation} % September 12, 2015
               {\list{}{
			\setlength{\listparindent}{.25in}%
			\setlength{\leftmargin}{.25in}
			\setlength{\rightmargin}{\leftmargin}
                        \setlength{\parsep}{0in plus 0in minus 0in}
		\item\relax
		\let\item\relax}
                }
               {\endlist}

\renewenvironment{quote}	% September 8, 2015
               {\list{}{
			\setlength{\listparindent}{.25in}
                        \setlength{\leftmargin}{.25in}
			\setlength{\rightmargin}{\leftmargin}
			\setlength{\parsep}{0in plus 0in minus 0in}
			}
                \item\relax
		\let\item\relax}
               {\endlist}

\newcommand*\abbrevlabel[1]{\textbf{#1 = }} % Feb 22 2016
\newenvironment{abbreviations}
     {\section*{Abbreviations}%
         \list{}%
           {\setlength\labelwidth{.25in}%
            \setlength\leftmargin{.25in}
	\setlength\labelsep{0in}
            %\advance\leftmargin\labelsep
	\let\makelabel\abbrevlabel
            }%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {%
      \endlist}

\renewenvironment{description}
               {\list{}{\setlength\leftmargin{0.25in}
			\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}

\RequirePackage[babel = true, tracking=alltext, letterspace=20]{microtype} % Leave this at the very end. It doesn't play nice if it comes before some of the other declarations
%
% Nothing below this!
%     |    |    |      
%     V    V    V
% ___________________