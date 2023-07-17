# What's New in the Version 2 GOC Dashboard

## Improvements

1. Many more menu items, particularly data checking items in Version 2.  Version 1 had 97 menu items.  Version 2 has 166.
1. Standard output formatting is used in all reporting and all plots
1. Addition of footnotes in some tables to clarify table contents
1. Speed improvements across all functions.  All functions take 10 seconds or less to complete.  Some have progress bars.
1. Improved menu wording throughout
1. Improved menu organization throughout
1. Introduction of "dictionary functions" to translate between internal codes used in the database, and external values that are more human friendly.  Translations will be completed in Version 3.
1. Checks now deliver single checks.  Previously, several tables and listing were generated when requesting a check.  Now checks are specific.
1. Non-member specific items moved from Members to Productivity
1. Members by City and Members by County provide simple counts of members
1. Check Duplicate Members checks the names of all members against all other members, identifying "nearly identical" and identical names for review and possible merge.
1. Check Duplicate Contacts checks the names of all contacts against all other contacts, identifying "nearly identical" and identical names for review and possible merge.
1. Each of the 10 data tables -- attendance, outreach, members, employment, goals, supports, progress notes, users, contacts, and gifts have 5-10 data checks available in submenus.
1. All data table viewers now have horizontal scroll bars so the entire width of tables can be viewed

## Technical improvements

1. All dashboard results are now produced by R functions.  These functions are maintained in an R library, called `goctools`. `goctools` conforms with all R package requirements, including documentation and testing via R CMD check. This insures consistency in coding and usage across multiple environments, including desktop, R Shiny dashboard deployment, and R Server script and cron job use.  This further enables "pre computation" of intensive results, allowing the results to be computed overnight, to be available when requested.
1. As a result of the new function design, code in the dashboard has been significantly reduced and code reuse significantly increased.  The version 1 dashboard had 4,440 lines of code.  Version 2 has 2,771 lines of code, resulting in less technical debt, and improved consistency of results.
1. Introduction of dictionary functions to translate database codes into human readable values in a consistent manner
1. Adoption of the function design supports use by other clubhouses.  The design is "R standard," meaning R developers can easily used and support `goctools` and the GOC Dashboard.

## Planned for Version 3

1. Read translate information directly from Flourish PHP source files, creating translate functions that accurately reflect internal to external presentation, without coding.
1. Further use of dictionary functions to provide user-friendly display of coded values.
1. Google Docs integration:
    1. GOC staff will be able to update dashboard news using a Google Doc
    1. Links in Flourish to Google Docs will be supported in the dashboard.
