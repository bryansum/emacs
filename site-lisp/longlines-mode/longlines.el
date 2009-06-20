<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: longlines.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=longlines.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: longlines.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=longlines.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for longlines.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=longlines.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22longlines.el%22">longlines.el</a></h1></div><div class="wrapper"><div class="content browse"><p><p><a href="http://www.emacswiki.org/cgi-bin/emacs/download/longlines.el">Download</a></p><pre class="source"><pre class="code"><span class="linecomment">;;; longlines.el --- automatically wrap long lines</span>

<span class="linecomment">;; Copyright (C) 2000, 2001, 2004, 2005 Free Software Foundation, Inc.</span>

<span class="linecomment">;; Authors:    Kai Grossjohann &lt;Kai.Grossjohann@CS.Uni-Dortmund.DE&gt;</span>
<span class="linecomment">;;             Alex Schroeder &lt;alex@gnu.org&gt;</span>
<span class="linecomment">;;             Chong Yidong &lt;cyd@stupidchicken.com&gt;</span>
<span class="linecomment">;; Maintainer: Chong Yidong &lt;cyd@stupidchicken.com&gt;</span>
<span class="linecomment">;; Version: 2.3.4</span>
<span class="linecomment">;; Keywords: convenience, wp</span>

<span class="linecomment">;; This file is free software; you can redistribute it and/or modify</span>
<span class="linecomment">;; it under the terms of the GNU General Public License as published by</span>
<span class="linecomment">;; the Free Software Foundation; either version 2, or (at your option)</span>
<span class="linecomment">;; any later version.</span>

<span class="linecomment">;; This file is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="linecomment">;; GNU General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with GNU Emacs; see the file COPYING.  If not, write to the</span>
<span class="linecomment">;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,</span>
<span class="linecomment">;; Boston, MA 02110-1301, USA.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; Some text editors save text files with long lines, and they</span>
<span class="linecomment">;; automatically break these lines at whitespace, without actually</span>
<span class="linecomment">;; inserting any newline characters.  When doing `M-q' in Emacs, you</span>
<span class="linecomment">;; are inserting newline characters.  Longlines mode provides a file</span>
<span class="linecomment">;; format which wraps the long lines when reading a file and unwraps</span>
<span class="linecomment">;; the lines when saving the file.  It can also wrap and unwrap</span>
<span class="linecomment">;; automatically as editing takes place.</span>

<span class="linecomment">;; Special thanks to Rod Smith for many useful bug reports.</span>

<span class="linecomment">;;; Installation:</span>

<span class="linecomment">;; Save longlines.el in a convenient directory, preferably in</span>
<span class="linecomment">;; your `load-path'. Add the following to your `user-init-file':</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   (autoload 'longlines-mode</span>
<span class="linecomment">;;     "longlines.el"</span>
<span class="linecomment">;;     "Minor mode for automatically wrapping long lines." t)</span>

<span class="linecomment">;;; Todo:</span>

<span class="linecomment">;; Investigate ^M characters showing up in relation to auto-save-file,</span>
<span class="linecomment">;; at least for NTEmacs.</span>

<span class="linecomment">;;; Code:</span>

(require 'easy-mmode)

(if (featurep 'xemacs)
    (eval-and-compile
      (require 'overlay)
      (defvar fill-nobreak-predicate nil)
      (defvar undo-in-progress nil)
      (defvar longlines-mode-hook nil)
      (defvar longlines-mode-on-hook nil)
      (defvar longlines-mode-off-hook nil)
      (unless (functionp 'line-end-position)
	(defun line-end-position ()
	  (save-excursion (end-of-line) (point))))
      (unless (functionp 'line-beginning-position)
	(defun line-beginning-position (&optional n)
	  (save-excursion
	    (if n (forward-line n))
	    (beginning-of-line)
	    (point))))))

(defgroup longlines nil
  "<span class="quote">Automatic wrapping of long lines when loading files.</span>"
  :group 'fill)

(defcustom longlines-auto-wrap t
  "<span class="quote">*Non-nil means long lines are automatically wrapped after each command.
Otherwise, you can perform filling using `fill-paragraph' or
`auto-fill-mode'.  In any case, the soft newlines will be removed
when the file is saved to disk.</span>"
  :group 'longlines
  :type 'boolean)

(defcustom longlines-wrap-follows-window-size nil
  "<span class="quote">*Non-nil means wrapping and filling happen at the edge of the window.
Otherwise, `fill-column' is used, regardless of the window size.  This
does not work well when the buffer is displayed in multiple windows
with differing widths.</span>"
  :group 'longlines
  :type 'boolean)

(defcustom longlines-show-hard-newlines nil
  "<span class="quote">*Non-nil means each hard newline is marked on the screen.
\(The variable `longlines-show-effect' controls what they look like.)
You can also enable the display temporarily, using the command
`longlines-show-hard-newlines'</span>"
  :group 'longlines
  :type 'boolean)

(defface longlines-visible-face
  '((t (:foreground "<span class="quote">cyan</span>")))
  "<span class="quote">Face used to make hard newlines visible in `longlines-mode'.</span>")

(defcustom longlines-show-effect (propertize "<span class="quote">|</span>" 'face 'longlines-visible-face)
  "<span class="quote">*A string to display when showing hard newlines.
This is used when `longlines-show-hard-newlines' is on.</span>"
  :group 'longlines
  :type 'string)

<span class="linecomment">;; Internal variables</span>

(defvar longlines-wrap-beg nil)
(defvar longlines-wrap-end nil)
(defvar longlines-wrap-point nil)
(defvar longlines-showing nil)

(make-variable-buffer-local 'longlines-wrap-beg)
(make-variable-buffer-local 'longlines-wrap-end)
(make-variable-buffer-local 'longlines-wrap-point)
(make-variable-buffer-local 'longlines-showing)

<span class="linecomment">;; Mode</span>

<span class="linecomment">;;;###autoload</span>
(define-minor-mode longlines-mode
  "<span class="quote">Toggle Long Lines mode.
In Long Lines mode, long lines are wrapped if they extend beyond
`fill-column'.  The soft newlines used for line wrapping will not
show up when the text is yanked or saved to disk.

If the variable `longlines-auto-wrap' is non-nil, lines are automatically
wrapped whenever the buffer is changed.  You can always call
`fill-paragraph' to fill individual paragraphs.

If the variable `longlines-show-hard-newlines' is non-nil, hard newlines
are indicated with a symbol.</span>"
  :group 'longlines :lighter "<span class="quote"> ll</span>"
  (if longlines-mode
      <span class="linecomment">;; Turn on longlines mode</span>
      (progn
        (use-hard-newlines 1 'never)
        (add-to-list 'buffer-file-format 'longlines)
        (add-hook 'change-major-mode-hook 'longlines-mode-off nil t)
	(add-hook 'before-revert-hook 'longlines-before-revert-hook nil t)
        (when longlines-wrap-follows-window-size
          (set (make-local-variable 'fill-column)
               (- (window-width) window-min-width))
          (add-hook 'window-configuration-change-hook
                    'longlines-window-change-function nil t))
        (let ((buffer-undo-list t)
              (inhibit-read-only t)
	      (after-change-functions nil)
              (mod (buffer-modified-p)))
          <span class="linecomment">;; Turning off undo is OK since (spaces + newlines) is</span>
          <span class="linecomment">;; conserved, except for a corner case in</span>
          <span class="linecomment">;; longlines-wrap-lines that we'll never encounter from here</span>
	  (save-restriction
	    (widen)
	    (longlines-decode-buffer)
	    (longlines-wrap-region (point-min) (point-max)))
          (set-buffer-modified-p mod))
        (when (and longlines-show-hard-newlines
                   (not longlines-showing))
          (longlines-show-hard-newlines))
        (when longlines-auto-wrap
          (auto-fill-mode 0)
          (add-hook 'after-change-functions
                    'longlines-after-change-function nil t)
          (add-hook 'post-command-hook
                    'longlines-post-command-function nil t)))
    <span class="linecomment">;; Turn off longlines mode</span>
    (setq buffer-file-format (delete 'longlines buffer-file-format))
    (if longlines-showing
        (longlines-unshow-hard-newlines))
    (let ((buffer-undo-list t)
	  (after-change-functions nil)
          (inhibit-read-only t))
      (save-restriction
	(widen)
	(longlines-encode-region (point-min) (point-max))))
    (remove-hook 'change-major-mode-hook 'longlines-mode-off t)
    (remove-hook 'after-change-functions 'longlines-after-change-function t)
    (remove-hook 'post-command-hook 'longlines-post-command-function t)
    (remove-hook 'before-revert-hook 'longlines-before-revert-hook t)
    (remove-hook 'window-configuration-change-hook
                 'longlines-window-change-function t)
    (when longlines-wrap-follows-window-size
      (kill-local-variable 'fill-column))
    (kill-local-variable 'use-hard-newlines)))

(defun longlines-mode-off ()
  "<span class="quote">Turn off longlines mode.
This function exists to be called by `change-major-mode-hook' when the
major mode changes.</span>"
  (longlines-mode 0))

<span class="linecomment">;; Showing the effect of hard newlines in the buffer</span>

(defun longlines-show-hard-newlines (&optional arg)
  "<span class="quote">Make hard newlines visible by adding a face.
With optional argument ARG, make the hard newlines invisible again
by calling `longlines-unshow-hard-newlines'.</span>"
  (interactive "<span class="quote">P</span>")
  (if arg
      (longlines-unshow-hard-newlines)
    (save-excursion
      (setq longlines-showing t)
      <span class="linecomment">;; We want to show every single newline.  Therefore every single</span>
      <span class="linecomment">;; newline must get its own overlay.  No spanning of multiple</span>
      <span class="linecomment">;; newlines with one overlay.</span>
      (let ((pos (text-property-any (point-min) (point-max) 'hard t)))
	(while pos
	  (longlines-show-region pos (1+ pos))
	  (setq pos (text-property-any (1+ pos) (point-max) 'hard t)))))))

(defun longlines-show-region (start end)
  "<span class="quote">Make region between START and END visible.</span>"
  (unless (let ((os (overlays-in start end))
		o exists)
	    (while (and os (not exists))
	      (setq o (car os)
		    os (cdr os))
	      (when (overlay-get o 'longlines)
		(setq exists t)))
	    exists)
    (let ((o (make-overlay start end nil t)))
      (if (consp longlines-show-effect)
	  (overlay-put o (car longlines-show-effect) (cdr longlines-show-effect))
	(overlay-put o 'before-string longlines-show-effect))
      (overlay-put o 'longlines t)
      (overlay-put o 'evaporate t))))

(defun longlines-unshow-hard-newlines ()
  "<span class="quote">Make hard newlines invisible again.</span>"
  (interactive)
  (setq longlines-showing nil)
  (let ((os (overlays-in (point-min) (point-max)))
	o)
    (while os
      (setq o (car os)
	    os (cdr os))
      (when (overlay-get o 'longlines)
	(delete-overlay o)))))

<span class="linecomment">;; Wrapping the paragraphs.</span>

(defun longlines-wrap-region (beg end)
  "<span class="quote">Wrap each successive line, starting with the line before BEG.
Stop when we reach lines after END that don't need wrapping, or the
end of the buffer.</span>"
  (setq longlines-wrap-point (point))
  (goto-char beg)
  (forward-line -1)
  <span class="linecomment">;; Two successful longlines-wrap-line's in a row mean successive</span>
  <span class="linecomment">;; lines don't need wrapping.</span>
  (while (null (and (longlines-wrap-line)
                    (or (eobp)
                        (and (&gt;= (point) end)
                             (longlines-wrap-line))))))
  (goto-char longlines-wrap-point))

(defun longlines-wrap-line ()
  "<span class="quote">If the current line needs to be wrapped, wrap it and return nil.
If wrapping is performed, point remains on the line.  If the line does
not need to be wrapped, move point to the next line and return t.</span>"
  (if (longlines-set-breakpoint)
      (progn (insert-before-markers ?\n)
	     (backward-char 1)
             (delete-char -1)
	     (forward-char 1)
             nil)
    (if (longlines-merge-lines-p)
        (progn (end-of-line)
     <span class="linecomment">;; After certain commands (e.g. kill-line), there may be two</span>
     <span class="linecomment">;; successive soft newlines in the buffer.  In this case, we</span>
     <span class="linecomment">;; replace these two newlines by a single space.  Unfortunately,</span>
     <span class="linecomment">;; this breaks the conservation of (spaces + newlines), so we</span>
     <span class="linecomment">;; have to fiddle with longlines-wrap-point.</span>
	       (if (or (prog1 (bolp) (forward-char 1)) (eolp))
		   (progn
		     (delete-char -1)
		     (if (&gt; longlines-wrap-point (point))
			 (setq longlines-wrap-point
			       (1- longlines-wrap-point))))
		 (insert-before-markers-and-inherit ?\ )
		 (backward-char 1)
		 (delete-char -1)
		 (forward-char 1))
               nil)
      (forward-line 1)
      t)))

(defun longlines-set-breakpoint ()
  "<span class="quote">Place point where we should break the current line, and return t.
If the line should not be broken, return nil; point remains on the
line.</span>"
  (move-to-column fill-column)
  (if (and (re-search-forward "<span class="quote">[^ ]</span>" (line-end-position) 1)
           (&gt; (current-column) fill-column))
      <span class="linecomment">;; This line is too long.  Can we break it?</span>
      (or (longlines-find-break-backward)
          (progn (move-to-column fill-column)
                 (longlines-find-break-forward)))))

(defun longlines-find-break-backward ()
  "<span class="quote">Move point backward to the first available breakpoint and return t.
If no breakpoint is found, return nil.</span>"
  (and (search-backward "<span class="quote"> </span>" (line-beginning-position) 1)
       (save-excursion
         (skip-chars-backward "<span class="quote"> </span>" (line-beginning-position))
         (null (bolp)))
       (progn (forward-char 1)
              (if (and fill-nobreak-predicate
                       (run-hook-with-args-until-success
                        'fill-nobreak-predicate))
                  (progn (skip-chars-backward "<span class="quote"> </span>" (line-beginning-position))
                         (longlines-find-break-backward))
                t))))

(defun longlines-find-break-forward ()
  "<span class="quote">Move point forward to the first available breakpoint and return t.
If no break point is found, return nil.</span>"
  (and (search-forward "<span class="quote"> </span>" (line-end-position) 1)
       (progn (skip-chars-forward "<span class="quote"> </span>" (line-end-position))
              (null (eolp)))
       (if (and fill-nobreak-predicate
                (run-hook-with-args-until-success
                 'fill-nobreak-predicate))
           (longlines-find-break-forward)
         t)))

(defun longlines-merge-lines-p ()
  "<span class="quote">Return t if part of the next line can fit onto the current line.
Otherwise, return nil.  Text cannot be moved across hard newlines.</span>"
  (save-excursion
    (end-of-line)
    (and (null (eobp))
         (null (get-text-property (point) 'hard))
         (let ((space (- fill-column (current-column))))
           (forward-line 1)
           (if (eq (char-after) ? )
               t <span class="linecomment">; We can always merge some spaces</span>
             (&lt;= (if (search-forward "<span class="quote"> </span>" (line-end-position) 1)
                     (current-column)
                   (1+ (current-column)))
                 space))))))

(defun longlines-decode-region (&optional beg end)
  "<span class="quote">Turn all newlines between BEG and END into hard newlines.
If BEG and END are nil, the point and mark are used.</span>"
  (if (null beg) (setq beg (point)))
  (if (null end) (setq end (mark t)))
  (save-excursion
    (let ((reg-max (max beg end)))
      (goto-char (min beg end))
      (while (search-forward "<span class="quote">\n</span>" reg-max t)
	(set-hard-newline-properties
	 (match-beginning 0) (match-end 0))))))

(defun longlines-decode-buffer ()
  "<span class="quote">Turn all newlines in the buffer into hard newlines.</span>"
  (longlines-decode-region (point-min) (point-max)))

(defun longlines-encode-region (beg end &optional buffer)
  "<span class="quote">Replace each soft newline between BEG and END with exactly one space.
Hard newlines are left intact.  The optional argument BUFFER exists for
compatibility with `format-alist', and is ignored.</span>"
  (save-excursion
    (let ((reg-max (max beg end))
	  (mod (buffer-modified-p)))
      (goto-char (min beg end))
      (while (search-forward "<span class="quote">\n</span>" reg-max t)
        (unless (get-text-property (match-beginning 0) 'hard)
          (replace-match "<span class="quote"> </span>")))
      (set-buffer-modified-p mod)
      end)))

<span class="linecomment">;; Auto wrap</span>

(defun longlines-auto-wrap (&optional arg)
  "<span class="quote">Turn on automatic line wrapping, and wrap the entire buffer.
With optional argument ARG, turn off line wrapping.</span>"
  (interactive "<span class="quote">P</span>")
  (remove-hook 'after-change-functions 'longlines-after-change-function t)
  (remove-hook 'post-command-hook 'longlines-post-command-function t)
  (if arg
      (progn (setq longlines-auto-wrap nil)
             (message "<span class="quote">Auto wrap disabled.</span>"))
    (setq longlines-auto-wrap t)
    (add-hook 'after-change-functions
              'longlines-after-change-function nil t)
    (add-hook 'post-command-hook
              'longlines-post-command-function nil t)
    (let ((mod (buffer-modified-p)))
      (longlines-wrap-region (point-min) (point-max))
      (set-buffer-modified-p mod))
    (message "<span class="quote">Auto wrap enabled.</span>")))

(defun longlines-after-change-function (beg end len)
  "<span class="quote">Update `longlines-wrap-beg' and `longlines-wrap-end'.
This is called by `after-change-functions' to keep track of the region
that has changed.</span>"
  (unless undo-in-progress
    (setq longlines-wrap-beg
          (if longlines-wrap-beg (min longlines-wrap-beg beg) beg))
    (setq longlines-wrap-end
          (if longlines-wrap-end (max longlines-wrap-end end) end))))

(defun longlines-post-command-function ()
  "<span class="quote">Perform line wrapping on the parts of the buffer that have changed.
This is called by `post-command-hook' after each command.</span>"
  (when longlines-wrap-beg
    (cond ((or (eq this-command 'yank)
               (eq this-command 'yank-pop))
           (longlines-decode-region (point) (mark t))
           (if longlines-showing
               (longlines-show-region (point) (mark t))))
	  (longlines-showing
	   (cond ((eq this-command 'newline)
		  (save-excursion
		    (if (search-backward "<span class="quote">\n</span>" nil t)
			(longlines-show-region
			 (match-beginning 0) (match-end 0)))))
		 ((eq this-command 'open-line)
		  (save-excursion
		    (if (search-forward "<span class="quote">\n</span>" nil t)
			(longlines-show-region
			 (match-beginning 0) (match-end 0))))))))
    (unless (or (eq this-command 'fill-paragraph)
                (eq this-command 'fill-region))
      (longlines-wrap-region longlines-wrap-beg longlines-wrap-end))
    (setq longlines-wrap-beg nil)
    (setq longlines-wrap-end nil)))

(defun longlines-window-change-function ()
  "<span class="quote">Re-wrap the buffer if the window width has changed.
This is called by `window-size-change-functions'.</span>"
  (when (/= fill-column (- (window-width) window-min-width))
    (setq fill-column (- (window-width) window-min-width))
    (let ((mod (buffer-modified-p)))
      (longlines-wrap-region (point-min) (point-max))
      (set-buffer-modified-p mod))))

<span class="linecomment">;; Advice for editing functions</span>

(defadvice kill-region (before longlines-encode-kill activate)
  "<span class="quote">If the buffer is in `longlines-mode', remove all soft newlines.</span>"
  (when longlines-mode
    (longlines-encode-region (ad-get-arg 0) (ad-get-arg 1))))

(defadvice copy-region-as-kill (around longlines-encode-kill activate)
  "<span class="quote">If the buffer is in `longlines-mode', remove all soft newlines.</span>"
  (if longlines-mode
      (let ((string (buffer-substring beg end)))
        (with-temp-buffer
          (insert string)
          (longlines-encode-region (point-min) (point-max))
          (ad-set-arg 0 (point-min))
          (ad-set-arg 1 (point-max))
          ad-do-it))
    ad-do-it))

<span class="linecomment">;; Loading and saving</span>

(defun longlines-before-revert-hook ()
  (add-hook 'after-revert-hook 'longlines-after-revert-hook nil t)
  (longlines-mode 0))

(defun longlines-after-revert-hook ()
  (remove-hook 'after-revert-hook 'longlines-after-revert-hook t)
  (longlines-mode 1))

(add-to-list
 'format-alist
 (list 'longlines "<span class="quote">Automatically wrap long lines.</span>" nil nil
       'longlines-encode-region t nil))

(provide 'longlines)

<span class="linecomment">;;; longlines.el ends here</span></span></pre></pre></p></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=longlines.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=longlines.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=longlines.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=longlines.el">Administration</a></span><span class="time"><br /> Last edited 2006-07-12 23:49 UTC by <a class="author" title="from SYDNEYPACIFIC-FOUR-SIXTY.MIT.EDU" href="http://www.emacswiki.org/emacs/ChongYidong">ChongYidong</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=longlines.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
