# This is goc-dashboard version 2

library(shiny)
library(shinydashboard)
library(DT)
library(goctools)
library(flextable)
library(tidyverse)

dbHeader <- dashboardHeader(title = "GOC Dashboard v2.0")

ui <- dashboardPage(
    dbHeader,
    dashboardSidebar(
        width = 350,
        sidebarMenu(
            dateInput("date", "Date", value = Sys.Date()),
            menuItem("Dashboard",        tabName = "dashboard", icon = icon("dashboard")),
            
            menuItem(
                "Members",
                menuSubItem("Tracking by Members and Staff", tabName = "tracking-by-members-and-staff"),
                menuSubItem("New Members",                   tabName = "new-members"),
                menuSubItem("This month's Birthdays",        tabName = "birthdays"),
                menuSubItem("Members with Allergies",        tabName = "allergies"),
                menuSubItem("Accessibility Restrictions",    tabName = "accessibility"),
                menuSubItem("Veterans",                      tabName = "veterans"),
                menuSubItem("Referral Summary",              tabName = "referral-summary"),
                menuSubItem("Members By City",               tabName = "members-by-city"),
                menuSubItem("Members By County",             tabName = "members-by-county"),
                menuSubItem("Goals by Member and Staff",     tabName = "goals-by-member-and-staff"),
                menuSubItem("Monthly Member Progress Notes", tabName = "monthly-progress-notes"),
                menuSubItem("Monthly Supports by Member",    tabName = "monthly-supports-by-member"),
                menuSubItem("All Supports by Member",        tabName = "all-supports-by-member"),
                menuItem(
                    "Member Graphics",
                    icon = icon("chart-line"),
                    menuSubItem("Daily Supports by Type",      tabName = "daily-supports-by-type"),
                    menuSubItem("Supports by Member and Type", tabName = "supports-by-member-and-type")
                ),
                menuItem(
                    "Member Checks",
                    icon = icon("circle-check"),
                    menuSubItem("Check Duplicate Members",     tabName = "check-duplicate-members"),
                    menuItem(
                      "Active Member Checks",
                      icon = icon("circle-check"),
                      menuSubItem("Check Contact Info",            tabName = "check-contacts"),
                      menuSubItem("Check Emergency Info",          tabName = "check-emergency"),
                      menuSubItem("Check Benefits",                tabName = "check-benefits"),
                      menuSubItem("Check Demographics",            tabName = "check-demographics"),
                      menuSubItem("Check Housing",                 tabName = "check-housing"),
                      menuSubItem("Check Education",               tabName = "check-education"),
                      menuSubItem("Check Employment",              tabName = "check-employment"),
                      menuSubItem("Check Medical",                 tabName = "check-medical"),
                      menuSubItem("Check Referral",                tabName = "check-referral"),
                      menuSubItem("Check Administrative",          tabName = "check-admin"),
                      menuSubItem("Check Attendance",              tabName = "check-attendance")
                    )
                    ),
                    menuItem(
                      "Goal Checks",
                      icon = icon("circle-check"),
                      menuSubItem("Check for Staff",               tabName = "check-goals-staff"),
                      menuSubItem("Check for Member",              tabName = "check-goals-member"),
                      menuSubItem("Check for Text",                tabName = "check-goals-text"),
                      menuSubItem("Check for Lapsed Table",        tabName = "check-goals-lapsed-table"),
                      menuSubItem("Check for Lapsed List",         tabName = "check-goals-lapsed-list")
                    ),
                    menuItem(
                      "Progress Note Checks",
                      icon = icon("circle-check"),
                      menuSubItem("Check for Staff", tabName = "check-pn-staff"),
                      menuSubItem("Check for Member",tabName = "check-pn-member"),
                      menuSubItem("Check for Goal",tabName = "check-pn-goal"),
                      menuSubItem("Check for Text",tabName = "check-pn-text")
                    ),
                    menuItem(
                      "Support Checks",
                      icon = icon("circle-check"),
                      menuSubItem("Check for Staff",               tabName = "check-supports-staff"),
                      menuSubItem("Check for Member",              tabName = "check-supports-member"),
                      menuSubItem("Check for Date",                tabName = "check-supports-date"),
                      menuSubItem("Check for Type",                tabName = "check-supports-type"),
                      menuSubItem("Check for Duration",            tabName = "check-supports-duration"),
                      menuSubItem("Check for Durations",           tabName = "check-supports-durations")
                        
                    )
            ),
            
            menuItem(
                "Attendance and Outreach",
                menuSubItem("Member Sign-In Sheet",                   tabName = "member-sign-in-sheet"),
                menuSubItem("Visitor Sign-In Sheet",                  tabName = "visitor-sign-in-sheet"),
                menuSubItem("Attendance Check List",                  tabName = "attendance-check-list"),
                menuSubItem("Active Member Outreach List",            tabName = "active-member-outreach-list"),
                menuSubItem("All Member Outreach List",               tabName = "all-member-outreach-list"),
                menuSubItem("Newly Absent Member List",               tabName = "newly-absent-member-list"),
                menuSubItem("Monthly Attendance Summary",             tabName = "monthly-attendance-summary"),
                menuItem(
                    "Attendance Graphics",
                    icon = icon("chart-line"),
                    menuSubItem("Attendance by Month",                tabName = "attendance-by-month"),
                    menuSubItem("Attendance by Year and Person Type", tabName = "attendance-by-year-and-person-type"),
                    menuSubItem("Active Members over Time",           tabName = "active-members-over-time")
                ),
                menuItem(
                    "Attendance and Outreach Checks",
                    icon = icon("circle-check"),
                    menuItem(
                        "Attendance Checks",
                        icon = icon("circle-check"),
                        menuSubItem("Check for Attendee",             tabName = "check-attendance-attendee"),
                        menuSubItem("Check for Date",                 tabName = "check-attendance-date"),
                        menuSubItem("Check for Time In",              tabName = "check-attendance-time-in"),
                        menuSubItem("Check for Time Out",             tabName = "check-attendance-time-out"),
                        menuSubItem("Check for Times",                tabName = "check-attendance-times"),
                        menuSubItem("Check for Location",             tabName = "check-attendance-location")
                        
                    ),
                    menuItem(
                        "Outreach Checks",
                        icon = icon("circle-check"),
                        menuSubItem("Check for Member",               tabName = "check-outreach-member"),
                        menuSubItem("Check for Date",                 tabName = "check-outreach-date"),
                        menuSubItem("Check for Type",                 tabName = "check-outreach-type"),
                        menuSubItem("Check for Outcome",              tabName = "check-outreach-outcome")
                    )
                )
            ),    
            
            menuItem(
                "Employment",
                menuSubItem("Current Employment",        tabName = "current-employment"),
                menuSubItem("Employment Supports",       tabName = "employment-supports"),
                menuItem(
                    "Employment Checks",
                    icon = icon("circle-check"),
                    menuSubItem("Check Member",          tabName = "check-employment-member"),
                    menuSubItem("Check Employer",        tabName = "check-employment-employer"),
                    menuSubItem("Check Start",           tabName = "check-employment-start"),
                    menuSubItem("Check Support",         tabName = "check-employment-support"),
                    menuSubItem("Check Pay",             tabName = "check-employment-pay"),
                    menuSubItem("Check Hours",           tabName = "check-employment-hours")
                )
            ),
            
            menuItem(
                "Contacts and Gifts",
                menuSubItem("Organization Contact Info",                tabName = "organization-contact-info"),
                menuSubItem("Family Contact Info",                      tabName = "family-contact-info"),
                menuSubItem("Person Contact Info",                      tabName = "person-contact-info"),
                menuSubItem("All Donors",                               tabName = "all-donors"),
                menuSubItem("All Gifts in Year",                        tabName = "all-gifts"),
                menuSubItem("Gifts by Payment Method and Year",         tabName = "gifts-by-payment-method-and-time"),
                menuSubItem("Gifts by Campaign",                        tabName = "gifts-by-campaign"),
                menuSubItem("Gift Amounts by Campaign",                 tabName = "gift-amounts-by-campaign"),
                selectInput(
                    "campaign_name", "Campaign", dict_campaign_names()$value),
                menuSubItem("Campaign Donors",                          tabName = "campaign-donors"),
                menuItem(
                  "Contact and Gift Graphics",
                  icon = icon("chart-line"),
                  menuSubItem("Gifts by Year",                          tabName = "gifts-by-year"),
                  menuSubItem("Total Raised by Year",                   tabName = "total-raised-by-year"),
                  menuSubItem("Total Raised by Payment Method",         tabName = "total-raised-by-payment-method"),
                  menuSubItem("Number of Gifts vs Total Raised",        tabName = "gifts-vs-total-raised"),
                  menuSubItem("Top 10 Campaigns by Gifts",              tabName = "top-10-campaigns-by-gifts")
                ),
                menuItem(
                  "Contact Checks",
                  icon = icon("circle-check"),
                  menuSubItem("Check Duplicate Contacts",               tabName = "check-duplicate-contacts"),
                  menuSubItem("Check for Phone",                        tabName = "check-contacts-phone"),
                  menuSubItem("Check for Email",                        tabName = "check-contacts-email"),
                  menuSubItem("Check for Street",                       tabName = "check-contacts-street"),
                  menuSubItem("Check for State",                        tabName = "check-contacts-state"),
                  menuSubItem("Check for Zip",                          tabName = "check-contacts-zip"),
                  menuSubItem("Check for nl",                           tabName = "check-contacts-nl"),
                  menuSubItem("Check for Full Name",                    tabName = "check-contacts-full-name"),
                  menuSubItem("Check for Solicit",                      tabName = "check-contacts-solicit")
                ),
                menuItem(
                  "Gift Checks",
                  icon = icon("circle-check"),
                  menuSubItem("Check for Donor",                        tabName = "check-gifts-donor"),
                  menuSubItem("Check for Amount",                       tabName = "check-gifts-amount"),
                  menuSubItem("Check for Campaign",                     tabName = "check-gifts-campaign"),
                  menuSubItem("Check for Date",                         tabName = "check-gifts-date"),
                  menuSubItem("Check for Thank yous",                   tabName = "check-gifts-thank-you"),
                  menuSubItem("Check for Payment Method",               tabName = "check-gifts-method"),
                  menuSubItem("Check for Anonymous",                    tabName = "check-gifts-anonymous"),
                  menuSubItem("Check for Restriction",                  tabName = "check-gifts-restriction"),
                  menuSubItem("Check for Restricted Gifts",             tabName = "check-gifts-restricted")

                )
            ),
            
            menuItem(
                "Billing and Payroll",
                menuSubItem("Clubhouse Billing List",             tabName = "clubhouse-billing"),
                menuSubItem("Supported Employment Billing List",  tabName = "supported-employment-billing"),
                menuSubItem("Last Attendance in Month",           tabName = "last-attendance"),
                selectInput("staff_name", "Staff Member", get_staff_names()),
                menuSubItem("Staff Time Report",                  tabName = "staff-time")
            ),
            
            menuItem(
                "Productivity",
                menuSubItem("Goal Types by Staff",        tabName = "goal-types-by-staff"),
                menuSubItem("Progress Notes by Staff",    tabName = "progress-notes-by-staff"),
                menuSubItem("Support Types by Staff",     tabName = "support-types-by-staff"),
                menuSubItem("Support Types by Year",      tabName = "support-types-by-year"),
                menuSubItem("Membership By The Numbers",  tabName = "membership-by-the-numbers"),
                menuSubItem("Unique Members By Year",     tabName = "unique-members-by-year"),
                menuItem(
                  "Productivity Graphics",
                  icon = icon("chart-line"),
                  menuSubItem("Supports by Staff and Type for Day", tabName = "plot-supports-by-staff-and-type"),
                  menuSubItem("Membership by the Numbers",          tabName = "p-membership-by-the-numbers"),
                  menuSubItem("Members By Year",                    tabName = "p-members-by-year")
                )
            ),
            
            menuItem(
                "Technical",
                menuSubItem("Flourish Record Counts",        tabName = "flourish-record-counts"),
                menuItem(
                  "Fields",
                  icon = icon("table"),
                  menuSubItem("Attendance",        tabName = "fields-attendance"),
                  menuSubItem("Contacts",          tabName = "fields-contacts"),
                  menuSubItem("Employment",        tabName = "fields-employment"),
                  menuSubItem("Gifts",             tabName = "fields-gifts"),
                  menuSubItem("Goals and Plans",   tabName = "fields-goals"),
                  menuSubItem("Members",           tabName = "fields-members"),
                  menuSubItem("Outreach",          tabName = "fields-outreach"),
                  menuSubItem("Progress Notes",    tabName = "fields-progress-notes"),
                  menuSubItem("Supports",          tabName = "fields-supports"),
                  menuSubItem("Users",             tabName = "fields-users")
                ),
                menuSubItem("Flourish Table Relationships",  tabName = "flourish-table-relationships"),
                menuSubItem("Check Users",         tabName = "check-users")
            ),
            
            menuItem(
                "Data Tables",
                icon = icon("table"),
                menuSubItem("Attendance",        tabName = "table-attendance"),
                menuSubItem("Contacts",          tabName = "table-contacts"),
                menuSubItem("Employment",        tabName = "table-employment"),
                menuSubItem("Gifts",             tabName = "table-gifts"),
                menuSubItem("Goals and Plans",   tabName = "table-goals"),
                menuSubItem("Members",           tabName = "table-members"),
                menuSubItem("Outreach",          tabName = "table-outreach"),
                menuSubItem("Progress Notes",    tabName = "table-progress-notes"),
                menuSubItem("Supports",          tabName = "table-supports"),
                menuSubItem("Users",             tabName = "table-users")
            ),
            
            menuItem(
                "Downloads",
                icon = icon("download"),
                downloadLink(outputId = "dl_attendance", label = "Download Attendance"), tags$p(),
                downloadLink(outputId = "dl_contacts", label = "Download Contacts"), tags$p(),
                downloadLink(outputId = "dl_employment", label = "Download Employment"), tags$p(),
                downloadLink(outputId = "dl_gifts", label = "Download Gifts"), tags$p(),
                downloadLink(outputId = "dl_goals", label = "Download Goals and Plans"), tags$p(),
                downloadLink(outputId = "dl_members", label = "Download Members"), tags$p(),
                downloadLink(outputId = "dl_outreach", label = "Download Outreach"), tags$p(),
                downloadLink(outputId = "dl_progress_notes", label = "Download Progress Notes"), tags$p(),
                downloadLink(outputId = "dl_supports", label = "Download Supports"), tags$p(),
                downloadLink(outputId = "dl_supports_with_members", label = "Download Supports with Members"), tags$p(),
                downloadLink(outputId = "dl_users", label = "Download Users")
            )
        )
    ),
    dashboardBody(
        tabItems(
            
            # Dashboard
            tabItem(
                tabName = "dashboard",
                h2("GOC Dashboard"),
                p("This is version 2 of the GOC Dashboard. More here:", a(href="https://github.com/mconlon17/goc-dashboard", target="_blank",
                                                                          "GOC Dashboard Feature Summary")),
                p("All planned reports and plots are now included in the dashboard.  Additional elements can be added as needed."),
                
                infoBox("Today", Sys.Date(), icon = icon("calendar"), color = "fuchsia", fill = TRUE),
                infoBox("Active Members", value=uiOutput("active_members"), icon = icon("users"), color = "green", fill = TRUE),
                box(title = "GOC News", background = "navy", width = 4,
                    p("New estimated completion date is July 18.",
                    "Punch list items and inspections may delay moving back.",
                    "Stay tuned.")
                ),
                
                box(title = "Membership Growth", status = "warning", solidHeader = TRUE, collapsible = TRUE, plotOutput("important_plot", 
                                                                                                                        height = 250)),
                box(title = "Gift Growth", status = "warning", solidHeader = TRUE, collapsible = TRUE, plotOutput("another_plot", height = 250)),
                
                infoBox("Today's Birthdays", value=uiOutput("todays_birthdays"), icon = icon("birthday-cake"), color = "fuchsia", fill = TRUE),
                infoBox("Average Daily Attendance", value=uiOutput("ada"), icon = icon("users"), color = "green", fill = TRUE),
                box( 
                    title = "Flourish News",
                    background = "navy",
                    width = 4,
                    p("This is version 2 of the dashboard.  See link at top of page for what's new.")
                )
            ),

            # Members
            
            tabItem(tabName = "tracking-by-members-and-staff",       uiOutput("html_tracking_by_members_and_staff")),
            tabItem(tabName = "new-members",                         uiOutput("html_new_members")),
            tabItem(tabName = "birthdays",                           uiOutput("html_birthdays")),
            tabItem(tabName = "allergies",                           uiOutput("html_allergies")),
            tabItem(tabName = "accessibility",                       uiOutput("html_accessibility")),
            tabItem(tabName = "veterans",                            uiOutput("html_veterans")),
            tabItem(tabName = "referral-summary",                    uiOutput("html_referral_summary")),
            tabItem(tabName = "members-by-city",                     uiOutput("html_members_by_city")), 
            tabItem(tabName = "members-by-county",                   uiOutput("html_members_by_county")), 
            tabItem(tabName = "goals-by-member-and-staff",           uiOutput("html_goals_by_member_and_staff")),
            tabItem(tabName = "monthly-progress-notes",              uiOutput("html_monthly_progress_notes")),
            tabItem(tabName = "monthly-supports-by-member",          uiOutput("html_monthly_supports_by_member")),
            tabItem(tabName = "all-supports-by-member",              uiOutput("html_all_supports_by_member")),
            
            tabItem(tabName = "daily-supports-by-type",              plotOutput("plot_daily_supports_by_type")),
            tabItem(tabName = "supports-by-member-and-type",         plotOutput("plot_supports_by_member_and_type")),
            
            tabItem(tabName = "check-duplicate-members",             uiOutput("html_check_duplicate_members")),
            tabItem(tabName = "check-contacts",                      uiOutput("html_check_members_contacts")),
            tabItem(tabName = "check-emergency",                     uiOutput("html_check_members_emergency")),
            tabItem(tabName = "check-benefits",                      uiOutput("html_check_members_benefits")),
            tabItem(tabName = "check-demographics",                  uiOutput("html_check_members_demographics")),
            tabItem(tabName = "check-housing",                       uiOutput("html_check_members_housing")),
            tabItem(tabName = "check-education",                     uiOutput("html_check_members_education")),
            tabItem(tabName = "check-employment",                    uiOutput("html_check_members_employment")),
            tabItem(tabName = "check-medical",                       uiOutput("html_check_members_medical")),
            tabItem(tabName = "check-referral",                      uiOutput("html_check_members_referral")),
            tabItem(tabName = "check-admin",                         uiOutput("html_check_members_admin")),
            tabItem(tabName = "check-attendance",                    uiOutput("html_check_members_attendance")),
            
            tabItem(tabName = "check-goals-staff",                   uiOutput("html_check_goals_staff")),
            tabItem(tabName = "check-goals-member",                  uiOutput("html_check_goals_member")),
            tabItem(tabName = "check-goals-text",                    uiOutput("html_check_goals_text")),
            tabItem(tabName = "check-goals-lapsed-table",            uiOutput("html_check_goals_lapsed_table")),
            tabItem(tabName = "check-goals-lapsed-list",             uiOutput("html_check_goals_lapsed_list")),
            
            tabItem(tabName = "check-pn-staff",                      uiOutput("html_check_pn_staff")),
            tabItem(tabName = "check-pn-member",                     uiOutput("html_check_pn_member")),
            tabItem(tabName = "check-pn-goal",                       uiOutput("html_check_pn_goal")),
            tabItem(tabName = "check-pn-text",                       uiOutput("html_check_pn_text")),

            tabItem(tabName = "check-supports-staff",                uiOutput("html_check_supports_staff")),
            tabItem(tabName = "check-supports-member",               uiOutput("html_check_supports_member")),
            tabItem(tabName = "check-supports-date",                 uiOutput("html_check_supports_date")),
            tabItem(tabName = "check-supports-type",                 uiOutput("html_check_supports_type")),
            tabItem(tabName = "check-supports-duration",             uiOutput("html_check_supports_duration")),
            tabItem(tabName = "check-supports-durations",            uiOutput("html_check_supports_durations")),
            
            # Attendance
            
            tabItem(tabName = "member-sign-in-sheet",                uiOutput("html_member_sign_in_sheet")),
            tabItem(tabName = "visitor-sign-in-sheet",               uiOutput("html_visitor_sign_in_sheet")),
            tabItem(tabName = "attendance-check-list",               uiOutput("html_attendance_check_list")),
            tabItem(tabName = "active-member-outreach-list",         uiOutput("html_active_member_outreach_list")),
            tabItem(tabName = "all-member-outreach-list",            uiOutput("html_all_member_outreach_list")),
            tabItem(tabName = "newly-absent-member-list",            uiOutput("html_newly_absent_member_list")),
            tabItem(tabName = "monthly-attendance-summary",          uiOutput("html_monthly_attendance_summary")),
            
            tabItem(tabName = "attendance-by-month",                 plotOutput("plot_attendance_by_month")),
            tabItem(tabName = "attendance-by-year-and-person-type",  plotOutput("plot_attendance_by_year_and_person_type")),
            tabItem(tabName = "active-members-over-time",            plotOutput("plot_active_members_over_time")),
            
            tabItem(tabName = "check-attendance-attendee",           uiOutput("html_check_attendance_attendee")),
            tabItem(tabName = "check-attendance-date",               uiOutput("html_check_attendance_date")),
            tabItem(tabName = "check-attendance-time-in",            uiOutput("html_check_attendance_time_in")),
            tabItem(tabName = "check-attendance-time-out",           uiOutput("html_check_attendance_time_out")),
            tabItem(tabName = "check-attendance-times",              uiOutput("html_check_attendance_times")),
            tabItem(tabName = "check-attendance-location",           uiOutput("html_check_attendance_location")),
            
            tabItem(tabName = "check-outreach-member",               uiOutput("html_check_outreach_member")),
            tabItem(tabName = "check-outreach-date",                 uiOutput("html_check_outreach_date")),
            tabItem(tabName = "check-outreach-type",                 uiOutput("html_check_outreach_type")),
            tabItem(tabName = "check-outreach-outcome",              uiOutput("html_check_outreach_outcome")),

            # Contacts and Gifts

            tabItem(tabName = "organization-contact-info",               uiOutput("html_organization_contact_info")),
            tabItem(tabName = "family-contact-info",                     uiOutput("html_family_contact_info")),
            tabItem(tabName = "person-contact-info",                     uiOutput("html_person_contact_info")),
            tabItem(tabName = "all-donors",                              uiOutput("html_all_donors")),
            tabItem(tabName = "all-gifts",                               uiOutput("html_all_gifts")),
            tabItem(tabName = "gifts-by-payment-method-and-time",        uiOutput("html_gifts_by_payment_method_and_time")),
            tabItem(tabName = "gifts-by-campaign",                       uiOutput("html_gifts_by_campaign")),
            tabItem(tabName = "gift-amounts-by-campaign",                uiOutput("html_gift_amounts_by_campaign")),
            tabItem(tabName = "campaign-donors",                         uiOutput("html_campaign_donors")),
            
            tabItem(tabName = "gifts-by-year",                           plotOutput("plot_gifts_by_year")),
            tabItem(tabName = "total-raised-by-year",                    plotOutput("plot_total_raised_by_year")),
            tabItem(tabName = "total-raised-by-payment-method",          plotOutput("plot_total_raised_by_payment_method")),
            tabItem(tabName = "gifts-vs-total-raised",                   plotOutput("plot_gifts_vs_total_raised")),
            tabItem(tabName = "top-10-campaigns-by-gifts",               plotOutput("plot_top_10_campaigns_by_gifts")),
            
            tabItem(tabName = "check-duplicate-contacts",                uiOutput("html_check_duplicate_contacts")),
            tabItem(tabName = "check-contacts-phone",                    uiOutput("html_check_contacts_phone")),
            tabItem(tabName = "check-contacts-email",                    uiOutput("html_check_contacts_email")),
            tabItem(tabName = "check-contacts-street",                   uiOutput("html_check_contacts_street")),
            tabItem(tabName = "check-contacts-state",                    uiOutput("html_check_contacts_state")),
            tabItem(tabName = "check-contacts-zip",                      uiOutput("html_check_contacts_zip")),
            tabItem(tabName = "check-contacts-nl",                       uiOutput("html_check_contacts_nl")),
            tabItem(tabName = "check-contacts-full-name",                uiOutput("html_check_contacts_full_name")),
            tabItem(tabName = "check-contacts-solicit",                  uiOutput("html_check_contacts_solicit")),
            
            tabItem(tabName = "check-gifts-donor",                       uiOutput("html_check_gifts_donor")),
            tabItem(tabName = "check-gifts-amount",                      uiOutput("html_check_gifts_amount")),
            tabItem(tabName = "check-gifts-campaign",                    uiOutput("html_check_gifts_campaign")),
            tabItem(tabName = "check-gifts-date",                        uiOutput("html_check_gifts_date")),
            tabItem(tabName = "check-gifts-thank-you",                   uiOutput("html_check_gifts_thank_you")),
            tabItem(tabName = "check-gifts-method",                      uiOutput("html_check_gifts_method")),
            tabItem(tabName = "check-gifts-anonymous",                   uiOutput("html_check_gifts_anonymous")),
            tabItem(tabName = "check-gifts-restriction",                 uiOutput("html_check_gifts_restriction")),
            tabItem(tabName = "check-gifts-restricted",                  uiOutput("html_check_gifts_restricted")),
            
            # Billing and Payroll
            
            tabItem(tabName = "clubhouse-billing",                 uiOutput("html_clubhouse_billing")),
            tabItem(tabName = "supported-employment-billing",      uiOutput("html_supported_employment_billing")),
            tabItem(tabName = "last-attendance",                   uiOutput("html_last_attendance")),
            tabItem(tabName = "staff-time",                        uiOutput("html_staff_time")),
            
            # Employment
            
            tabItem(tabName = "current-employment",           uiOutput("html_current_employment")),
            tabItem(tabName = "employment-supports",          uiOutput("html_employment_supports")),
            tabItem(tabName = "check-employment-member",      uiOutput("html_check_employment_member")),
            tabItem(tabName = "check-employment-employer",    uiOutput("html_check_employment_employer")),
            tabItem(tabName = "check-employment-start",       uiOutput("html_check_employment_start")),
            tabItem(tabName = "check-employment-support",     uiOutput("html_check_employment_support")),
            tabItem(tabName = "check-employment-pay",         uiOutput("html_check_employment_pay")),
            tabItem(tabName = "check-employment-hours",       uiOutput("html_check_employment_hours")),
            
            # Productivity
            
            tabItem(tabName = "goal-types-by-staff",          uiOutput("html_goal_types_by_staff")),
            tabItem(tabName = "progress-notes-by-staff",      uiOutput("html_progress_notes_by_staff")),
            tabItem(tabName = "support-types-by-staff",       uiOutput("html_support_types_by_staff")),
            tabItem(tabName = "support-types-by-year",        uiOutput("html_support_types_by_year")),
            tabItem(tabName = "membership-by-the-numbers",    uiOutput("html_membership_by_the_numbers")),
            tabItem(tabName = "unique-members-by-year",       uiOutput("html_unique_members_by_year")),
            
            tabItem(tabName = "plot-supports-by-staff-and-type",  plotOutput("plot_supports_by_staff_and_type")),
            tabItem(tabName = "p-membership-by-the-numbers",      plotOutput("plot_membership_by_the_numbers")),
            tabItem(tabName = "p-members-by-year",                plotOutput("plot_members_by_year")),
            
            # Technical
            
            tabItem(tabName = "flourish-record-counts",       uiOutput("html_flourish_record_counts")),
            tabItem(tabName = "fields-attendance",            uiOutput("html_fields_attendance")),
            tabItem(tabName = "fields-contacts",              uiOutput("html_fields_contacts")),
            tabItem(tabName = "fields-employment",            uiOutput("html_fields_employment")),
            tabItem(tabName = "fields-gifts",                 uiOutput("html_fields_gifts")),
            tabItem(tabName = "fields-goals",                 uiOutput("html_fields_goals")),
            tabItem(tabName = "fields-members",               uiOutput("html_fields_members")),
            tabItem(tabName = "fields-outreach",              uiOutput("html_fields_outreach")),
            tabItem(tabName = "fields-progress-notes",        uiOutput("html_fields_progress_notes")),
            tabItem(tabName = "fields-supports",              uiOutput("html_fields_supports")),
            tabItem(tabName = "fields-users",                 uiOutput("html_fields_users")),
            tabItem(tabName = "flourish-table-relationships", imageOutput("png_flourish_table_relationships")),
            tabItem(tabName = "check-users",                  uiOutput("html_check_users")),
            
            # Data Tables
            
            tabItem(tabName = "table-attendance",             dataTableOutput("table_attendance")),
            tabItem(tabName = "table-outreach",               dataTableOutput("table_outreach")),
            tabItem(tabName = "table-members",                dataTableOutput("table_members")),
            tabItem(tabName = "table-employment",             dataTableOutput("table_employment")),
            tabItem(tabName = "table-contacts",               dataTableOutput("table_contacts")),
            tabItem(tabName = "table-gifts",                  dataTableOutput("table_gifts")),
            tabItem(tabName = "table-goals",                  dataTableOutput("table_goals")),
            tabItem(tabName = "table-supports",               dataTableOutput("table_supports")),
            tabItem(tabName = "table-progress-notes",         dataTableOutput("table_progress_notes")),
            tabItem(tabName = "table-users",                  dataTableOutput("table_users"))
            
            # Downloads
        )
    )
)

server <- function(input, output) {
    
    shinyAppDir(".")
    
    # Dashboard
    
    output$active_members                     <- renderText({ nrow(get_members(active.only=T)) })
    output$todays_birthdays                   <- renderText({ get_birthdays() })
    output$ada                                <- renderText({ format(round(get_average_daily_attendance(30), 1), nsmall = 1) }) 
    output$important_plot                     <- renderPlot({ plot_member_attendance_by_month() })  
    output$another_plot                       <- renderPlot({ plot_total_raised_by_year() })
  
    # Members
    
    output$html_tracking_by_members_and_staff <- renderUI({ list_tracking_by_member_and_staff()         %>% flextable::htmltools_value() })
    output$html_new_members                   <- renderUI({ list_new_members(input$date)                %>% flextable::htmltools_value() })
    output$html_birthdays                     <- renderUI({ list_birthdays(input$date)                  %>% flextable::htmltools_value() })
    output$html_allergies                     <- renderUI({ list_allergies()                            %>% flextable::htmltools_value() })
    output$html_accessibility                 <- renderUI({ list_accessibility()                        %>% flextable::htmltools_value() })
    output$html_veterans                      <- renderUI({ list_veterans()                             %>% flextable::htmltools_value() })
    output$html_referral_summary              <- renderUI({ list_referral_summary()                     %>% flextable::htmltools_value() })
    output$html_members_by_city               <- renderUI({ list_members_by_city()                      %>% flextable::htmltools_value() })
    output$html_members_by_county             <- renderUI({ list_members_by_county()                    %>% flextable::htmltools_value() })
    output$html_goals_by_member_and_staff     <- renderUI({ list_goals_by_member_and_staff()            %>% flextable::htmltools_value() })
    output$html_monthly_progress_notes        <- renderUI({ list_monthly_progress_notes(input$date)     %>% flextable::htmltools_value() })
    output$html_monthly_supports_by_member    <- renderUI({ list_monthly_supports_by_member(input$date) %>% flextable::htmltools_value() })
    output$html_all_supports_by_member        <- renderUI({ list_supports_by_member_and_type()          %>% flextable::htmltools_value() })
    
    output$plot_daily_supports_by_type        <- renderPlot({ plot_daily_supports_by_type(input$date) })
    output$plot_supports_by_member_and_type   <- renderPlot({ plot_supports_by_member_and_type(input$date) })
    
    output$html_check_duplicate_members       <- renderUI({ check_duplicate_members()                   %>% flextable::htmltools_value() })
    output$html_check_members_contacts        <- renderUI({ check_members("contacts")                   %>% flextable::htmltools_value() })
    output$html_check_members_emergency       <- renderUI({ check_members("emergency")                  %>% flextable::htmltools_value() })
    output$html_check_members_benefits        <- renderUI({ check_members("benefits")                   %>% flextable::htmltools_value() })
    output$html_check_members_demographics    <- renderUI({ check_members("demographics")               %>% flextable::htmltools_value() })
    output$html_check_members_housing         <- renderUI({ check_members("housing")                    %>% flextable::htmltools_value() })
    output$html_check_members_education       <- renderUI({ check_members("education")                  %>% flextable::htmltools_value() })
    output$html_check_members_employment      <- renderUI({ check_members("employment")                 %>% flextable::htmltools_value() })
    output$html_check_members_medical         <- renderUI({ check_members("medical")                    %>% flextable::htmltools_value() })
    output$html_check_members_referral        <- renderUI({ check_members("referral")                   %>% flextable::htmltools_value() })
    output$html_check_members_admin           <- renderUI({ check_members("admin")                      %>% flextable::htmltools_value() })
    output$html_check_members_attendance      <- renderUI({ check_members("attendance")                 %>% flextable::htmltools_value() })
    
    output$html_check_goals_staff             <- renderUI({ check_goals("staff")                        %>% flextable::htmltools_value() })
    output$html_check_goals_member            <- renderUI({ check_goals("member")                       %>% flextable::htmltools_value() })
    output$html_check_goals_text              <- renderUI({ check_goals("text")                         %>% flextable::htmltools_value() })
    output$html_check_goals_lapsed_table      <- renderUI({ check_goals("lapsed_table")                 %>% flextable::htmltools_value() })
    output$html_check_goals_lapsed_list       <- renderUI({ check_goals("lapsed_list")                  %>% flextable::htmltools_value() })
    
    output$html_check_pn_staff                <- renderUI({ check_progress_notes("staff")               %>% flextable::htmltools_value() })
    output$html_check_pn_member               <- renderUI({ check_progress_notes("member")              %>% flextable::htmltools_value() })
    output$html_check_pn_goal                 <- renderUI({ check_progress_notes("goal")                %>% flextable::htmltools_value() })
    output$html_check_pn_text                 <- renderUI({ check_progress_notes("text")                %>% flextable::htmltools_value() })
    
    output$html_check_supports_staff          <- renderUI({ check_supports("staff")                     %>% flextable::htmltools_value() })
    output$html_check_supports_member         <- renderUI({ check_supports("member")                    %>% flextable::htmltools_value() })
    output$html_check_supports_date           <- renderUI({ check_supports("date")                      %>% flextable::htmltools_value() })
    output$html_check_supports_type           <- renderUI({ check_supports("type")                      %>% flextable::htmltools_value() })
    output$html_check_supports_duration       <- renderUI({ check_supports("duration")                  %>% flextable::htmltools_value() })
    output$html_check_supports_durations      <- renderUI({ check_supports("durations")                 %>% flextable::htmltools_value() })
    
    # Attendance and Outreach
    
    output$html_member_sign_in_sheet               <- renderUI({ list_member_signin(input$date)               %>% flextable::htmltools_value() })  
    output$html_visitor_sign_in_sheet              <- renderUI({ list_visitors_sign_in(input$date)            %>% flextable::htmltools_value() })  
    output$html_attendance_check_list              <- renderUI({ list_attendance_checklist(input$date)        %>% flextable::htmltools_value() })  
    output$html_active_member_outreach_list        <- renderUI({ list_active_member_outreach()                %>% flextable::htmltools_value() })  
    output$html_all_member_outreach_list           <- renderUI({ list_all_member_outreach()                   %>% flextable::htmltools_value() })  
    output$html_newly_absent_member_list           <- renderUI({ list_newly_absent_members(input$date)        %>% flextable::htmltools_value() })  
    output$html_monthly_attendance_summary         <- renderUI({ list_monthly_attendance_summary(input$date)  %>% flextable::htmltools_value() })  
    
    output$plot_attendance_by_month                <- renderPlot({ plot_member_attendance_by_month(input$date) })
    output$plot_attendance_by_year_and_person_type <- renderPlot({ plot_attendance_by_year()                   })
    output$plot_active_members_over_time           <- renderPlot({ plot_active_members_over_time(input$date)   })
    
    output$html_check_attendance_attendee          <- renderUI({ check_attendance("attendee")                %>% flextable::htmltools_value() })
    output$html_check_attendance_date              <- renderUI({ check_attendance("date")                    %>% flextable::htmltools_value() })
    output$html_check_attendance_time_in           <- renderUI({ check_attendance("time_in")                 %>% flextable::htmltools_value() })
    output$html_check_attendance_time_out          <- renderUI({ check_attendance("time_out")                %>% flextable::htmltools_value() })
    output$html_check_attendance_times             <- renderUI({ check_attendance("times")                   %>% flextable::htmltools_value() })
    output$html_check_attendance_location          <- renderUI({ check_attendance("location")                %>% flextable::htmltools_value() }) 
    
    output$html_check_outreach_member              <- renderUI({ check_outreach("member")                    %>% flextable::htmltools_value() })
    output$html_check_outreach_date                <- renderUI({ check_outreach("date")                      %>% flextable::htmltools_value() })
    output$html_check_outreach_type                <- renderUI({ check_outreach("type")                      %>% flextable::htmltools_value() })
    output$html_check_outreach_outcome             <- renderUI({ check_outreach("outcome")                   %>% flextable::htmltools_value() }) 
    
    # Contacts and Gifts
    
    output$html_organization_contact_info               <- renderUI({ list_organizations()                           %>% flextable::htmltools_value() })
    output$html_family_contact_info                     <- renderUI({ list_families()                                %>% flextable::htmltools_value() })
    output$html_person_contact_info                     <- renderUI({ list_people()                                  %>% flextable::htmltools_value() })
    output$html_all_donors                              <- renderUI({ list_all_donors()                              %>% flextable::htmltools_value() })
    output$html_all_gifts                               <- renderUI({ list_gifts(input$date)                         %>% flextable::htmltools_value() })
    output$html_gifts_by_payment_method_and_time        <- renderUI({ list_gifts_by_payment_method_and_time()        %>% flextable::htmltools_value() })
    output$html_gifts_by_campaign                       <- renderUI({ list_gifts_by_campaign()                       %>% flextable::htmltools_value() })
    output$html_gift_amounts_by_campaign                <- renderUI({ list_gift_amounts_by_campaign()                %>% flextable::htmltools_value() })
    output$html_campaign_donors                         <- renderUI({ list_campaign_donors(input$campaign_name)      %>% flextable::htmltools_value() })

    output$plot_gifts_by_year                           <- renderPlot({ plot_gifts_by_year() })
    output$plot_total_raised_by_year                    <- renderPlot({ plot_total_raised_by_year() })
    output$plot_total_raised_by_payment_method          <- renderPlot({ plot_total_raised_by_payment_method() })
    output$plot_gifts_vs_total_raised                   <- renderPlot({ plot_gifts_vs_total_raised() })
    output$plot_top_10_campaigns_by_gifts               <- renderPlot({ plot_top_10_campaigns_by_gifts() })

    output$html_check_duplicate_contacts                <- renderUI({ check_duplicate_contacts()                 %>% flextable::htmltools_value() })
    output$html_check_contacts_phone                    <- renderUI({ check_contacts("phone")                    %>% flextable::htmltools_value() })
    output$html_check_contacts_email                    <- renderUI({ check_contacts("email")                    %>% flextable::htmltools_value() })
    output$html_check_contacts_street                   <- renderUI({ check_contacts("street")                   %>% flextable::htmltools_value() })
    output$html_check_contacts_state                    <- renderUI({ check_contacts("state")                    %>% flextable::htmltools_value() })
    output$html_check_contacts_zip                      <- renderUI({ check_contacts("zip")                      %>% flextable::htmltools_value() })
    output$html_check_contacts_nl                       <- renderUI({ check_contacts("nl")                       %>% flextable::htmltools_value() })
    output$html_check_contacts_full_name                <- renderUI({ check_contacts("full_name")                %>% flextable::htmltools_value() })
    output$html_check_contacts_solicit                  <- renderUI({ check_contacts("solicit")                  %>% flextable::htmltools_value() })

    output$html_check_gifts_donor                       <- renderUI({ check_gifts("donor")                       %>% flextable::htmltools_value() })
    output$html_check_gifts_amount                      <- renderUI({ check_gifts("amount")                      %>% flextable::htmltools_value() })
    output$html_check_gifts_campaign                    <- renderUI({ check_gifts("campaign")                    %>% flextable::htmltools_value() })
    output$html_check_gifts_date                        <- renderUI({ check_gifts("date")                        %>% flextable::htmltools_value() })
    output$html_check_gifts_thank_you                   <- renderUI({ check_gifts("thank_you")                   %>% flextable::htmltools_value() })
    output$html_check_gifts_method                      <- renderUI({ check_gifts("method")                      %>% flextable::htmltools_value() })
    output$html_check_gifts_anonymous                   <- renderUI({ check_gifts("anonymous")                   %>% flextable::htmltools_value() })
    output$html_check_gifts_restriction                 <- renderUI({ check_gifts("restriction")                 %>% flextable::htmltools_value() })
    output$html_check_gifts_restricted                  <- renderUI({ check_gifts("restricted")                  %>% flextable::htmltools_value() })
    
    # Billing and Payroll

    output$html_clubhouse_billing            <- renderUI({ list_clubhouse_billing()                      %>% flextable::htmltools_value() })   
    output$html_supported_employment_billing <- renderUI({ list_supported_employment_billing()           %>% flextable::htmltools_value() })   
    output$html_last_attendance              <- renderUI({ list_last_attendance()                        %>% flextable::htmltools_value() })   
    output$html_staff_time                   <- renderUI({ list_staff_time(input$staff_name, input$date) %>% flextable::htmltools_value() })   
    
    # Employment
    
    output$html_current_employment          <- renderUI({ list_current_employment()              %>% flextable::htmltools_value() })   
    output$html_employment_supports         <- renderUI({ list_employment_supports()             %>% flextable::htmltools_value() })   
    output$html_check_employment_member     <- renderUI({ check_employment("member")             %>% flextable::htmltools_value() })   
    output$html_check_employment_employer   <- renderUI({ check_employment("employer")           %>% flextable::htmltools_value() })   
    output$html_check_employment_start      <- renderUI({ check_employment("start")              %>% flextable::htmltools_value() })   
    output$html_check_employment_support    <- renderUI({ check_employment("support")            %>% flextable::htmltools_value() })   
    output$html_check_employment_pay        <- renderUI({ check_employment("pay")                %>% flextable::htmltools_value() })   
    output$html_check_employment_hours      <- renderUI({ check_employment("hours")              %>% flextable::htmltools_value() })   
    
    # Productivity
    
    output$html_goal_types_by_staff         <- renderUI({ list_goal_types_by_staff()             %>% flextable::htmltools_value() })
    output$html_progress_notes_by_staff     <- renderUI({ list_staff_progress_notes(input$date)  %>% flextable::htmltools_value() })
    output$html_support_types_by_staff      <- renderUI({ list_supports_by_staff_and_type()      %>% flextable::htmltools_value() })
    output$html_support_types_by_year       <- renderUI({ list_supports_by_year()                %>% flextable::htmltools_value() })
    output$html_membership_by_the_numbers   <- renderUI({ list_membership_by_the_numbers()       %>% flextable::htmltools_value() })
    output$html_unique_members_by_year      <- renderUI({ list_members_by_year()                 %>% flextable::htmltools_value() })
    
    output$plot_supports_by_staff_and_type  <- renderPlot({ plot_supports_by_staff_and_type(input$date) })
    output$plot_membership_by_the_numbers   <- renderPlot({ plot_membership_by_the_numbers() })
    output$plot_members_by_year             <- renderPlot({ plot_members_by_year() })
    
    # Technical
    
    output$html_flourish_record_counts       <- renderUI({ list_record_counts()                  %>% flextable::htmltools_value() })
    output$html_fields_attendance            <- renderUI({ list_fields("attendance")             %>% flextable::htmltools_value() })
    output$html_fields_outreach              <- renderUI({ list_fields("outreach")               %>% flextable::htmltools_value() })
    output$html_fields_members               <- renderUI({ list_fields("members")                %>% flextable::htmltools_value() })
    output$html_fields_employment            <- renderUI({ list_fields("employment")             %>% flextable::htmltools_value() })
    output$html_fields_contacts              <- renderUI({ list_fields("contacts")               %>% flextable::htmltools_value() })
    output$html_fields_gifts                 <- renderUI({ list_fields("gifts")                  %>% flextable::htmltools_value() })
    output$html_fields_goals                 <- renderUI({ list_fields("goals")                  %>% flextable::htmltools_value() })
    output$html_fields_supports              <- renderUI({ list_fields("supports")               %>% flextable::htmltools_value() })
    output$html_fields_progress_notes        <- renderUI({ list_fields("progress_notes")         %>% flextable::htmltools_value() })
    output$html_fields_users                 <- renderUI({ list_fields("users")                  %>% flextable::htmltools_value() })
    output$png_flourish_table_relationships  <- renderImage({ list(src = "img/Flourish-Table-Relationships.png", contentType = 'image/png', 
                                                              width = 1131, height = 671, alt = "ERD-like diagram of key linkage between tables") }, 
                                                              deleteFile = FALSE)
    output$html_check_users                  <- renderUI({ check_users()                         %>% flextable::htmltools_value() })
    
    # Data Tables
    
    output$table_attendance     <- renderDT(datatable(get_attendance(), options = list(scrollX = TRUE)))
    output$table_outreach       <- renderDT(datatable(get_outreach(), options = list(scrollX = TRUE)))
    output$table_members        <- renderDT(datatable(get_members(), options = list(scrollX = TRUE)))
    output$table_employment     <- renderDT(datatable(get_employment(), options = list(scrollX = TRUE)))
    output$table_contacts       <- renderDT(datatable(get_contacts(), options = list(scrollX = TRUE)))
    output$table_gifts          <- renderDT(datatable(get_gifts(), options = list(scrollX = TRUE)))
    output$table_goals          <- renderDT(datatable(get_goals(), options = list(scrollX = TRUE)))
    output$table_supports       <- renderDT(datatable(get_supports(), options = list(scrollX = TRUE)))
    output$table_progress_notes <- renderDT(datatable(get_progress_notes(), options = list(scrollX = TRUE)))
    output$table_users          <- renderDT(datatable(get_users(), options = list(scrollX = TRUE)))
    
    # Downloads
    
    output$dl_attendance            <- downloadHandler(filename = function() { paste0("flourish-attendance-", Sys.Date(), ".csv") },
                                                       content  = function(file) { write_csv(get_attendance(), file) })
    output$dl_outreach              <- downloadHandler(filename = function() { paste0("flourish-outreach-", Sys.Date(), ".csv") },
                                                       content  = function(file) { write_csv(get_outreach(), file) })
    output$dl_members               <- downloadHandler(filename = function() {paste0("flourish-members-", Sys.Date(), ".csv")},
                                                       content  = function(file) { write_csv(get_members(), file)})
    output$dl_contacts              <- downloadHandler(filename = function() {paste0("flourish-contacts-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_contacts(), file)})
    output$dl_gifts                 <- downloadHandler(filename = function() {paste0("flourish-gifts-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_gifts(), file)})
    output$dl_goals                 <- downloadHandler(filename = function() {paste0("flourish-goals-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_goals(), file)})
    output$dl_supports              <- downloadHandler(filename = function() {paste0("flourish-supports-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_supports(), file)})
    output$dl_supports_with_members <- downloadHandler(filename = function() {paste0("flourish-supports-with-members-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_supports(with.members=T), file)})
    output$dl_progress_notes        <- downloadHandler(filename = function() {paste0("flourish-progress-notes-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_progress_notes(), file)})
    output$dl_employment            <- downloadHandler(filename = function() {paste0("flourish-employment-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_employment(), file)})
    output$dl_users                 <- downloadHandler(filename = function() {paste0("flourish-users-", Sys.Date(), ".csv")},
                                                       content  = function(file) {write_csv(get_users(), file)})
}

shinyApp(ui, server)
