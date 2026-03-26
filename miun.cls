%% miun.cls — LaTeX class for Mid Sweden University (MIUN) reports
%% Mimics the corporate Word report template.
%% Usage: \documentclass{miun}
%%
%% Structure (expand each section incrementally):
%%   1. Class declaration
%%   2. Required packages
%%   3. Page geometry
%%   4. Fonts
%%   5. Title / metadata commands
%%   6. Heading styles
%%   7. Header and footer
%%   8. Paragraph / spacing settings
%%   9. Title page
%%  10. Miscellaneous helpers

% ============================================================
% 1. CLASS DECLARATION
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{miun}[2026/03/26 v0.1 MIUN report class]

%% Pass unknown options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% Build on the standard article class
\LoadClass[12pt,a4paper]{article}


% ============================================================
% 2. REQUIRED PACKAGES
% ============================================================
\RequirePackage[T1]{fontenc}          % Proper output encoding
\RequirePackage[utf8]{inputenc}       % UTF-8 input
\RequirePackage{geometry}             % Page layout
\RequirePackage{graphicx}             % Images (e.g. logo)
\RequirePackage{xcolor}               % Colour support
\RequirePackage{titlesec}             % Custom heading styles
\RequirePackage{fancyhdr}             % Headers and footers
\RequirePackage{setspace}             % Line spacing
\RequirePackage{parskip}              % Space between paragraphs
\RequirePackage{hyperref}             % Clickable links / PDF metadata
\RequirePackage{helvet}               % Helvetica (Arial substitute)
\RequirePackage{microtype}            % Improved text rendering


% ============================================================
% 3. PAGE GEOMETRY  (Word-compatible A4 layout)
% ============================================================
\geometry{
  a4paper,
  top    = 2.5cm,
  bottom = 2.5cm,
  left   = 3.0cm,
  right  = 3.0cm,
  headheight = 15pt,
}


% ============================================================
% 4. FONTS  (sans-serif body to match Word/Arial feel)
% ============================================================
\renewcommand{\familydefault}{\sfdefault}   % Switch body font to sans-serif


% ============================================================
% 5. TITLE / METADATA COMMANDS
% ============================================================
%% Standard \title and \author are inherited from article.
%% Extra metadata fields that appear on the MIUN title page:

\newcommand{\miunsubtitle}[1]{\gdef\@miunsubtitle{#1}}
\newcommand{\miuncourse}[1]{\gdef\@miuncourse{#1}}
\newcommand{\miundate}[1]{\gdef\@miundate{#1}}
\newcommand{\miunversion}[1]{\gdef\@miunversion{#1}}

%% Safe defaults (empty)
\gdef\@miunsubtitle{}
\gdef\@miuncourse{}
\gdef\@miundate{\today}
\gdef\@miunversion{}


% ============================================================
% 6. HEADING STYLES
% ============================================================
%% MIUN brand colour — a dark red/crimson (adjust to match logo)
\definecolor{miunred}{RGB}{167,26,26}

%% Heading 1 — large, coloured, with a bottom rule
\titleformat{\section}
  {\large\bfseries\color{miunred}}
  {\thesection}{1em}{}
  [\titlerule]

%% Heading 2 — medium, bold
\titleformat{\subsection}
  {\normalsize\bfseries}
  {\thesubsection}{1em}{}

%% Heading 3 — normal size, bold italic
\titleformat{\subsubsection}
  {\normalsize\bfseries\itshape}
  {\thesubsubsection}{1em}{}

%% Vertical spacing around headings
\titlespacing*{\section}      {0pt}{1.5ex plus .2ex}{.8ex plus .2ex}
\titlespacing*{\subsection}   {0pt}{1.2ex plus .2ex}{.5ex plus .2ex}
\titlespacing*{\subsubsection}{0pt}{1.0ex plus .2ex}{.3ex plus .2ex}


% ============================================================
% 7. HEADER AND FOOTER
% ============================================================
\pagestyle{fancy}
\fancyhf{}   % clear all header/footer fields

%% Header: document title on the left, optional logo on the right
\fancyhead[L]{\small\nouppercase{\@title}}
\fancyhead[R]{\includegraphics[height=0.8cm]{Miun_logotyp_CMYK}}

%% Footer: author on the left, page number on the right
\fancyfoot[L]{\small\@author}
\fancyfoot[R]{\small\thepage}

%% Thin rule only under the header
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

%% Plain page style used by \maketitle — no header rule
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[R]{\small\thepage}
  \renewcommand{\headrulewidth}{0pt}
}


% ============================================================
% 8. PARAGRAPH / SPACING SETTINGS
% ============================================================
\setstretch{1.15}                   % Slight line-spacing (≈ Word "1.15")
% \parskip is handled by parskip package (adds space between paragraphs)
% \parindent is set to 0 by parskip; uncomment below to restore indents:
% \setlength{\parindent}{1.5em}


% ============================================================
% 9. TITLE PAGE  (\maketitle override)
% ============================================================
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \raggedright
    \vspace*{2cm}

    \includegraphics[width=5cm]{Miun_logotyp_CMYK}\\[1cm]

    {\Huge\bfseries\color{miunred}\@title\par}
    \vspace{0.4cm}

    \ifx\@miunsubtitle\@empty\else
      {\large\itshape\@miunsubtitle\par}
      \vspace{0.4cm}
    \fi

    \ifx\@miuncourse\@empty\else
      {\normalsize\@miuncourse\par}
      \vspace{0.2cm}
    \fi

    \vspace{1cm}
    {\large\@author\par}
    \vspace{0.4cm}
    {\normalsize\@miundate\par}

    \ifx\@miunversion\@empty\else
      \vspace{0.2cm}
      {\small Version: \@miunversion\par}
    \fi

    \vfill
    {\small Mid Sweden University (MIUN)\par}
  \end{titlepage}
  \setcounter{page}{2}   % Title page is unnumbered; body starts at 2
}


% ============================================================
% 10. MISCELLANEOUS HELPERS
% ============================================================
%% Convenience command for an abstract / executive summary box
\renewenvironment{abstract}{%
  \begin{center}
    \begin{minipage}{0.85\textwidth}
      \small\itshape
}{%
    \end{minipage}
  \end{center}
  \vspace{1em}
}

%% hyperref setup — fill in PDF metadata automatically
\AtBeginDocument{%
  \hypersetup{
    pdftitle  = {\@title},
    pdfauthor = {\@author},
    colorlinks = true,
    linkcolor  = miunred,
    urlcolor   = miunred,
    citecolor  = miunred,
  }%
}

\endinput
