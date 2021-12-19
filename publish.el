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
 styles "<link
    href=\"https://cdn.simplecss.org/simple.min.css\"
    rel=\"stylesheet\"
    type=\"text/css\"
/>
<link
    href=\"/styles/styles.css\"
    rel=\"stylesheet\"
    type=\"text/css\"
/>"
 header "<h1>Sean Gallagher</h1>
<nav>
  <a href=\"/\">Home</a>
  <a href=\"/stocks.html\">The STOCKS Application</a>
  <a href=\"/build.html\">How it's Made</a>
</nav>")

(setq org-html-head styles
      org-html-preamble header
      org-html-postamble "<p>&copy;&thinsp;2021 %a<br>%e</p>")

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
             :exclude "\\(build\\)\\|\\(index\\).org"
             :publishing-directory "./archive"
             :publishing-function 'org-latex-publish-to-latex)))
(if (string= (system-name) "Asgard")
    (setq org-publish-project-alist
          (append org-publish-project-alist latex-publish-alist)))

(org-publish-all t)
(message "Build complete")
