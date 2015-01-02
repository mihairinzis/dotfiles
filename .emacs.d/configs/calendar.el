;;; calendar.el --- Calendar config

;;; Commentary:
;;;

;;; Code:

(setq romanian-holidays
      '((holiday-fixed 1 1 "Anul nou")
        (holiday-fixed 1 2 "A doua zi de anul nou")
        (holiday-greek-orthodox-easter)
        ;; (holiday-fixed 4 12 "Prima zi de Pasti")
        ;; (holiday-fixed 4 13 "A doua zi de Pasti")
        (holiday-fixed 5 1 "Ziua muncii")
        (holiday-fixed 5 31 "Prima zi de Rusalii")
        (holiday-fixed 6 1 "A doua zi de Rusalii")
        (holiday-fixed 8 15 "Adormirea Maicii Domnului")
        (holiday-fixed 11 30 "Sfantul apostol Andrei")
        (holiday-fixed 12 1 "Ziua nationala")
        (holiday-fixed 12 25 "Prima zi de Craciun")
        (holiday-fixed 12 26 "A doua zi de Craciun")
        ))

(setq calendar-holidays
      (append romanian-holidays
              ;; holiday-general-holidays
              ;; holiday-other-holidays
              ;; holiday-local-holidays
              ))

(setq calendar-date-style 'european
      calendar-mark-holidays-flag t
      calendar-week-start-day 1
      calendar-mark-diary-entries-flag nil
      calendar-day-name-array
      ["luni" "marți" "miercuri" "joi"
       "vineri" "sâmbătă" "duminică"]
      calendar-month-name-array
      ["ianuarie" "februarie" "martie" "aprilie" "mai"
       "iunie" "iulie" "august" "septembrie"
       "octombie" "noiembrie" "decembrie"])

(setq diary-file "~/.diary.gpg"
      view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;;; calendar.el ends here
