
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UoYCSproject}[2016/12/05 Jeremy Jacob]

% Koma-script report style
%\PassOptionsToPackage{twoside=false}{typearea}
\LoadClass[fontsize=12pt,a4paper,abstracton,twoside=false,numbers=noenddot]{scrreprt}
\RequirePackage{scrhack}
\RequirePackage[toc,page]{appendix}{
\RequirePackage{graphicx}

\RequirePackage[T1]{fontenc} % prevents < in text mode turning into
\RequirePackage{textcomp}    % ?', etc
\RequirePackage[osf]{mathpazo} % Palatino font
\RequirePackage{courier} % nicer typewriter-style fonts
\RequirePackage[scaled]{helvet} % nice san serif fonts
\RequirePackage{microtype} % micro-typographical extensions for
                           % pdf(e)(la)tex
\RequirePackage[british]{babel} % British hyphenation patterns, etc.
\RequirePackage{ifthen}

\usepackage[scaled]{helvet}
\renewcommand\familydefault{\sfdefault} 
\usepackage[T1]{fontenc}

\pagestyle{headings}
\renewcommand{\partpagestyle}{empty}

% Reference control
\RequirePackage{csquotes}

%\RequirePackage{silence} % To suppress some warning, see below.
%\WarningFilter{biblatex}{File 'british-ieee.lbx'} %The warning is benign and can be ignored (issue since biblatex-ieee version 1.3).
%\WarningFilter{biblatex}{File 'english-ieee.lbx'}%The warning is benign and can be ignored (issue since biblatex-ieee version 1.3).

\RequirePackage[style=ieee,backend=biber]{biblatex}

%\typearea[current]{calc} % force page layout recalculation after
                         % changing all the fonts

\newcommand*{\UoYCSP@mk@degree}[1]{%
  \expandafter\def\csname#1\endcsname{\newcommand*{\UoYCSP@degree}{#1}}%
}
\UoYCSP@mk@degree{BEng}
\UoYCSP@mk@degree{BSc}
\UoYCSP@mk@degree{MEng}
\UoYCSP@mk@degree{MMath}
\newcommand*{\SWE}{\newcommand*{\UoYCSP@degree}{MSc~in~Software~Engineering}}
\newcommand*{\SCSE}{\newcommand*{\UoYCSP@degree}{MSc~in~Safety~Critical~Systems~Engineering}}
\newcommand*{\MIP}{\newcommand*{\UoYCSP@degree}{MSc~in~Information~Processing}}
\newcommand*{\MIT}{\newcommand*{\UoYCSP@degree}{MSc~in~Information~Technology}}
\newcommand*{\MNC}{\newcommand*{\UoYCSP@degree}{MSc~in~Natural~Computation}}
\newcommand*{\GTC}{\newcommand*{\UoYCSP@degree}{MSc~in~Gas~Turbine~Control}}
\newcommand*{\ACS}{\newcommand*{\UoYCSP@degree}{MSc~in~Advanced~Computer~Science}}

\newcommand*{\supervisor}[1]{\newcommand*{\UoYCSP@supervisor}{#1}}

\newenvironment{summary}
    {\addchap{Executive Summary}
    \label{cha:exesummary}
    }
    { 
    \clearpage
	\pagenumbering{arabic}
    }

\usepackage[top=2.5cm, bottom=4cm, left=4cm, right=4cm]{geometry}
\setlength{\parindent}{8pt}
\setlength{\parskip}{8pt}

\date{\fbox{\Huge DRAFT PROCESSED \today}}

\titlehead{ \hfill Department of Computer Science\\\vspace{32pt}
\begin{center}
\includegraphics[height = 1in]{"./UOY-Logo-Stacked-shield-Black"}\\
\vspace{32pt}
  \ifx\UoYCSP@degree\undefined%
    \ClassError{UoYCSproject}%
               {degree scheme not set}
               {Declare the degree scheme in the preamble using
               \protect\BEng, \protect\MEng, etc.}
  \else%
    \large Submitted in part fulfilment for the degree of
    \UoYCSP@degree.%
  \fi%
\end{center}
}

\publishers{%
  \large

  \ifx\UoYCSP@supervisor\undefined%
    \ClassError{UoYCSproject}%
               {supervisor not set}
               {Declare the supervisor in the preamble using \protect\supervisor{Name}}  
  \else%
    Supervisor: \UoYCSP@supervisor%
  \fi%

}
\let\oldtitle\title
\renewcommand{\title}[1]{\oldtitle{ \vspace{-64pt} #1}}

%\let\old@abstract\abstract
%\let\endold@abstract\endabstract
%\renewcommand{\abstract}[1]{\newcommand{\UoYCSP@abstract}{#1}}
%\renewcommand{\endabstract}{}

\let\old@dedication\dedication
\newcommand*{\UoYCSP@dedication}{}
\renewcommand*{\dedication}[1]{\renewcommand*{\UoYCSP@dedication}{#1}}
\newif\ifacknowledgements
\acknowledgementsfalse
\newcommand*{\UoYCSP@acknowledgements}{}
\newcommand{\acknowledgements}[1]{%
  \renewcommand{\UoYCSP@acknowledgements}{#1}%
  \acknowledgementstrue
}

\InputIfFileExists{\jobname.ldf}{}

\RequirePackage[pdfusetitle]{hyperref}% automatic hyperlinks, etc
\RequirePackage[all]{hypcap}% improve link placement in floats
\hypersetup{%
  pdfstartview={Fit}%
}
\urlstyle{sf}
\renewcommand*{\Itemautorefname}{Item}
\renewcommand*{\chapterautorefname}{Chapter}
\renewcommand*{\sectionautorefname}{Section}
\renewcommand*{\subsectionautorefname}{Subsection}
\renewcommand*{\subsubsectionautorefname}{Subsubsection}
\renewcommand*{\paragraphautorefname}{Paragraph}
\renewcommand*{\Hfootnoteautorefname}{Footnote}
%\renewcommand*{\pageautorefname}{Page}

\let\old@maketitle=\maketitle
\renewcommand*{\maketitle}{%
  \old@maketitle%
  % dedication & acknowledgements
  \ifthenelse%
  {\equal{\UoYCSP@dedication}{\@empty}
         \and\equal{\UoYCSP@acknowledgements}{\@empty}}
  {}{
    \cleardoublepage%
    \thispagestyle{empty}
    \vspace*{\fill}%
    %
    \ifthenelse{\equal{\UoYCSP@dedication}{\@empty}}%
    {}%
    { \begin{center}%
        \large\UoYCSP@dedication%
      \end{center}%
    }%
    %
    \ifacknowledgements%
    { \vfill%
      \normalsize%
      \begin{center}%
        \large\bfseries Acknowledgements%
      \end{center}%
      \UoYCSP@acknowledgements%
    }%
    \fi%
    \vspace*{\fill}%
  }%
  \cleardoublepage%
  \microtypesetup{protrusion=false}%
  \tableofcontents%  
  \microtypesetup{protrusion=true}%
}

\AtBeginDocument{%
  \nonfrenchspacing%
}