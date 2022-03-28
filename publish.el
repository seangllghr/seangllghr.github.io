(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(package-install 'htmlize)

(require 'ox-publish)

(setq user-full-name "Sean Gallagher"
      user-mail-address "seangllghr@gmail.com")

(setq
 dependencies "<link
    href=\"https://cdn.simplecss.org/simple.min.css\"
    rel=\"stylesheet\"
    type=\"text/css\"
/>
<link
    href=\"/styles/styles.css\"
    rel=\"stylesheet\"
    type=\"text/css\"
/>
<script src=\"https://kit.fontawesome.com/5eb8d43980.js\" crossorigin=\"anonymous\"></script>"
 header "<h1>Sean Gallagher</h1>
<nav>
  <a href=\"/\">Home</a>
  <a href=\"/resume.html\">Résumé</a>
  <a href=\"/stocks.html\">The STOCKS Application</a>
  <a href=\"/build.html\">How it's Made</a>
</nav>"
 footer (concat "<p>&copy;&thinsp;2021&ndash;"
                (format-time-string "%Y")
                " %a<br>%e</p>"))

(setq org-html-head dependencies
      org-html-preamble header
      org-html-postamble footer
      org-html-container-element "section"
      org-src-preserve-indentation t)

(if (string= (system-name) "Asgard")
    (setq org-latex-default-packages-alist
          '((""             "graphicx"  t)
            (""             "grffile"   t)
            (""             "longtable" nil)
            (""             "wrapfig"   nil)
            (""             "rotating"  nil)
            ("normalem"     "ulem"      t)
            (""             "amsmath"   t)
            (""             "textcomp"  t)
            (""             "amssymb"   t)
            (""             "capt-of"   nil)
            (""             "titling"   t)
            ("margin=1in"   "geometry"  nil)
            (""             "fontspec"  nil)
            (""             "setspace"  nil)
            ("tiny,compact" "titlesec"  nil)
            ("small"        "caption"   nil)
            (""             "enumitem"  nil)
            (""             "unicode-math" nil)
            ("x11names"     "xcolor"    nil)
            (""             "minted"    nil)
            ("colorlinks=true,allcolors=darkgray" "hyperref" t))
          org-latex-classes
          '(("article"
             "\\documentclass[11pt]{article}
[DEFAULT-PACKAGES]
\\setmainfont{TeX Gyre Pagella}[Ligatures=TeX]
\\setsansfont{TeX Gyre Heros}[Ligatures=TeX]
\\setmonofont{JetBrains Mono}[Scale=0.8]
\\setmathfont{Asana Math}
\\makeatletter
\\def\\@maketitle{%
\\singlespacing
\\begin{center}%
{\\LARGE \\@title \\par}%
\\vskip 1.5em%
{\\large \\@author}%
\\end{center}%
\\par
\\vskip 1.5em}
\\doublespacing
\\makeatother
\\setminted{baselinestretch=1,linenos,numbersep=4pt,obeytabs=true}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
          ))

(setq org-publish-project-alist
      (list
       (list "seangllghr.github.io:content"
             :language "en"
             :base-directory "./src"
             :recursive t
             :base-extension "org"
             :publishing-directory "./public"
             :publishing-function 'org-html-publish-to-html
             :headline-levels 5
             :html-divs '((preamble "header" "header")
                          (content "main" "content")
                          (postamble "footer" "footer"))
             :html-doctype "html5"
             :html-head-include-default-style nil
             :html-head-include-scripts nil
             :html-html5-fancy t
             :html-indent nil
             :html-validation-link nil
             :section-numbers nil
             :with-date nil
             :with-author t
             :with-title nil
             :with-toc nil)
       (list "seangllghr.github.io:static"
             :base-directory "./src"
             :recursive t
             :base-extension "css\\|jpg\\|gif\\|png\\|svg"
             :publishing-directory "./public"
             :publishing-function 'org-publish-attachment)))
(setq latex-publish-alist
      (list
       (list "seangllghr.github.io:archive"
             :base-directory "./src"
             :recursive t
             :base-extension "org"
             :exclude "\\(\\(build\\)\\|\\(^stocks\\)\\).org"
             :publishing-directory "./archive"
             :publishing-function 'org-latex-publish-to-latex
             :headline-levels 5
             :latex-listings 'minted
             :section-numbers nil
             :with-toc nil)
       (list "seangllghr.github.io:archive-static"
             :base-directory "./src"
             :recursive t
             :base-extension "jpg\\|gif\\|png\\|svg"
             :publishing-directory "./archive"
             :publishing-function 'org-publish-attachment)))
(if (string= (system-name) "Asgard")
    (setq org-publish-project-alist
          (append org-publish-project-alist latex-publish-alist)))

(org-publish-all t)
(message "Build complete")
