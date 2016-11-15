\ProvidesClass{UoAthesis}

%%% Class options
\newif\if@doublesided
\@doublesidedfalse
\DeclareOption{doublesided}
{\@doublesidedtrue}

\ExecuteOptions{}
\ProcessOptions

\if@doublesided
\LoadClass[UKenglish,a4paper,12pt,twoside]{report}
\else
\LoadClass[UKenglish,a4paper,12pt]{report}
\fi

%%%%%%%%%%%%%% Settable variables
\makeatletter%
\newcommand{\thesisabstract}[1]{\def \@abstract {#1}}
\newcommand{\thesistitle}[1]{\def \@thesistitle {#1}}
\newcommand{\thesisauthor}[1]{\def \@thesisauthor {#1}}
\newcommand{\thesispdfkeywords}[1]{\def \@thesispdfkeywords {#1}}
\newcommand{\thesisyear}[1]{\def \@thesisyear {#1}}
\newcommand{\thesisschool}[1]{\def \@school {#1}}
\newcommand{\thesisfaculty}[1]{\def \@college {#1}}
\newcommand{\thesisuniversity}[1]{\def \@university {#1}}
\newcommand{\acknowledgements}[1]{\def \@acknowledgements {#1}}
%%% Clear the variables at global scope
\global\let\@abstract\@empty
\global\let\@school\@empty
\global\let\@college\@empty
\global\let\@university\@empty
\global\let\@thesisyear\@empty
\global\let\@thesispdfkeywords\@empty
\global\let\@thesisauthor\@empty
\global\let\@thesistitle\@empty
\makeatother

%%% Set the default values
\thesisschool{School of Engineering}
\thesisfaculty{College of Physical Sciences}
\thesisuniversity{Univ.~of Aberdeen}
\thesispdfkeywords{}

%%% Other details
\newcommand{\docspacing}{\onehalfspacing}
%%% The university guidelines state 25mm top and bottom margins, and
%%% 30mm left and right margins. We add a binding edge indent too.
\newlength{\bindingedgeindent}\setlength{\bindingedgeindent}{15mm}
\newlength{\sideMargin}\setlength{\sideMargin}{15mm}
\newlength{\topMargin}\setlength{\topMargin}{15mm}
\newlength{\bottomMargin}\setlength{\bottomMargin}{15mm}
\RequirePackage[a4paper,bindingoffset=\bindingedgeindent,%
hdivide={\sideMargin,*,\sideMargin},%
vdivide={\topMargin,*,\bottomMargin}]{geometry}

%%% Chapter Formatting
\RequirePackage[Bjarne]{fncychap} %% Chapter style

%%% Reference sections
\RequirePackage[style=numeric-comp,bibstyle=numeric,hyperref=true,%
backref=false,sorting=none,abbreviate=true]{biblatex}
\defbibheading{thesisChapterBib}{\chapter{References}}

%%% Standard latex packages
\RequirePackage{amsmath}
\RequirePackage{bm}
\RequirePackage[makeroom]{cancel}
\RequirePackage{url}
\RequirePackage[T1]{fontenc} %Better fonts
\RequirePackage{indentfirst} %indent first line of sections
\RequirePackage{pdfpages} %% Allows insertion of pdfs as pages
\RequirePackage{setspace} % Document spacing
\RequirePackage{times}

%%% Header/Footer Format
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[RO]{\slshape \rightmark}
\fancyhead[LE]{\slshape \leftmark}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\addtolength{\headheight}{2.5pt}
\RequirePackage[bottom,perpage]{footmisc} %% Footnotes at bottom of page

%%% Tables
\RequirePackage{multirow} %% Allows multiple row items in tables

%%% Make equations numbered by section
\numberwithin{equation}{section}

%%% Image manipulation
\RequirePackage{graphicx}
\RequirePackage{lettrine}
\RequirePackage{rotating}
\RequirePackage[absolute]{textpos} %for the cover image
\setlength{\TPHorizModule}{1mm} %sets the textpos unit
\setlength{\TPVertModule}{\TPHorizModule} 
\RequirePackage{subfig} %for multi image file floats
%%% This command lets figures fill 85 percent of the top of a
%%% page without placing it on its own
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
%%% Makes sure a page with 75
\renewcommand{\floatpagefraction}{0.75}

%%% This makes clear double page not print headers or footers
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace{\fill}
\thispagestyle{plain}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother

%%% Keep floats in the chapter in which they were placed
\RequirePackage{placeins}
\let\oldchap=\chapter
\renewcommand*{\chapter}{%
  \secdef{\Chap}{\ChapS}% whether there's a star or not...
}
\newcommand\ChapS[1]{\FloatBarrier\singlespacing\cleardoublepage\oldchap*{{\uppercase{#1}}}\markboth{{\uppercase{#1}}}{{\uppercase{#1}}}\docspacing}
\newcommand\Chap[2][]{\FloatBarrier\singlespacing\cleardoublepage\oldchap[#1]{{\uppercase{#2}}}\docspacing}

%% Epigraphs for stating where chapters were from
\RequirePackage{epigraph}
\setlength{\epigraphwidth}{0.9\columnwidth}
\setlength{\epigraphrule}{0pt}
\setlength{\beforeepigraphskip}{-\baselineskip}
\setlength{\afterepigraphskip}{\baselineskip}
\renewcommand{\textflush}{flushright}
\renewcommand{\epigraphsize}{\footnotesize}

%%% Nomenclature
\RequirePackage[noprefix,columns,refpage]{nomencl} %My version of the Nomencl package
\setlength{\nomitemsep}{-\parsep} %single line spacing nomencl
\RequirePackage{color}
%%% Stop links being colored in the pdf, place
\definecolor{Navy}{rgb}{0.1,0.1,0.45}
\makeatletter
\RequirePackage[pdftex,%
pdftitle={\@thesistitle},
plainpages=false,
pdfpagelabels,
hypertexnames=true,
naturalnames,
pdfauthor={\@thesisauthor},
pdfsubject={PhD Thesis},
pdfkeywords={\@thesispdfkeywords},
pdfproducer={Latex},
pdfcreator={pdflatex},
bookmarks,bookmarksnumbered,
%pagebackref,
colorlinks,
linkcolor=black,
citecolor=black,
filecolor=black,
urlcolor=black,
breaklinks=true
]{hyperref}
\makeatother

%%% Allow hooking into the start of the document
\RequirePackage{etoolbox}

%%% Makes page numbers hyperlinked
\renewcommand*{\pagedeclaration}[1]{\unskip, \hyperpage{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Fix the colours of transparent images
\pdfpageattr {/Group << /S /Transparency /I true /CS /DeviceRGB>>}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Make it look like a book in acroread
\makeatletter
\if@doublesided
\pdfcatalog{/PageLayout /TwoPageRight}
\fi
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Command to collect nomenclature data
\makenomenclature
\makeatletter
\AfterEndPreamble{%
  \singlespacing
  %%% Title page
  \ifpdf\phantomsection\pdfbookmark[0]{Front Cover}{FrontCover}\fi
  \begin{titlepage}
    \begin{textblock}{63}(25,30)
      \includegraphics[clip,width=\textwidth]{figures/UoALogo}
    \end{textblock}
    \mbox{}\vskip50mm%
    \begin{center}
      \Large\expandafter\textsc\expandafter{\@thesistitle}
    \end{center}
    \vfill
    \begin{center}
      \rm \textbf{\textsc\@thesisauthor}\\
      \@thesisyear
    \end{center}
    \vskip1.5in%
    \begin{center}
      \large \textsc{ This thesis was submitted as part of the
        requirement for the MEng.~degree in Engineering.}
    \end{center}
    \vfill
    \begin{center}
      \@school\hfill\@thesisyear\hfill\@university
    \end{center}
  \end{titlepage}

  %%% Abstract
  \setcounter{page}{2}
  \chapter*{Abstract}
  \addcontentsline{toc}{chapter}{Abstract}%
  \@abstract
  \cleardoublepage

  %%% Table of Contents
  \cleardoublepage
  \ifpdf\phantomsection\pdfbookmark[0]{Contents}{Contents}\fi
  \tableofcontents
  \vfill
  \cleardoublepage
  \ifpdf\phantomsection\pdfbookmark[0]{List of Figures}{TableoffiguresPg}\fi
  \listoffigures
  \cleardoublepage
  \ifpdf\phantomsection\pdfbookmark[0]{List of Tables}{TableoftablesPg}\fi
  \listoftables
  \cleardoublepage
  \phantomsection\addcontentsline{toc}{chapter}{Nomenclature}
  \printnomenclature
  \chapter*{Acknowledgements}
  \addcontentsline{toc}{chapter}{Acknowledgements}
  \@acknowledgements
  \cleardoublepage
  \docspacing
}
\makeatother