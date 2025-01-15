# Devexperts Time Tracker for Jira Overview

Devexperts Time Tracker for Jira is a time tracking tool developed by Devexperts. It is integrated with Jira, and tracked time goes directly into 
Jira worklogs. Time can be tracked using JTT both from Jira interface and from Time Tracker interface.

## Tracking from Jira:
![Screenshot of a ... showing ...](/assets/images/tracking-from-Jira.jpg)

JTT interface:

![Time tracker introduction](/assets/images/Manual_introduction.jpg)

    ‌‌‍‍

'All of them' tab under the 'Tickets' section сontains the full list of tickets available for you to track presented in descending order based on your recent activity:

last time created a worklog,
last time real time tracked,
last time assigned to me,
last time marked as a favorite.
Which means that the most frequently used tickets will be always pop up to the top of the 'All of them' Tab.

Also, next to the tabs of tickets menu there is a Calendar view. To see past worklogs one can simply tap on the specific date in the past.

'Search Bar' on the very top will help you find tickets by:

ticket key (e.g. PROJ-10),
by part of the ticket summary


You may start/stop tracking using 'Play' button:

![play in time tracker](/assets/images/play.jpg)





You may add tickets you work regularly on to 'Favorites'. Find a particular ticket, hover on it and a star will appear to its left. Tap on the star and now you should be able find the ticket on the 'Favorites' tab as well.

![favorites in time tracker](/assets/images/favorite.jpg)






Basic tracking with JTT
Use your credentials to login, like it's shown on the picture below:

![login in time tracker](/assets/images/login.jpg)

    ‌‌‍‍

You can track your time while you are working on a ticket.

Start real time tracking by clicking on the ticket. After you stop tracking, a worklog will be saved immediately and will show up on the timeline on the right panel. In the meantime, a worklog will be synchronized with Jira and appear there shortly.

Note:

If you click on another ticket while you are tracking, then the current session will be stopped and a new one will be started. Tracking logs less than a minute are not possible and will be discarded.
If you have an active real time tracking period and a planned worklog (worklog set up for later today), then real time tracking session automatically suspends by the system, once it reaches the planned worklog.

![play gif](/assets/images/play.gif)


To edit a duration of a worklog:

Pull the worklog up or down by the timeline border
Set the time manually (by clicking on a 'pen' icon next to time duration).
Note: you can change duration of the ticket only after stopping time tracking of this ticket. The worklogs cannot intersect.

![pull gif](/assets/images/pull.gif)



To delete a worklog from the timeline, hover over the worklog, click on the 'pen' icon and click the appearing 'bin' icon.


![delete gif](/assets/images/delete.gif)


You can also change a ticket during real time tracking: just hover on the mistaken ticket and tap on the ‘pen’ icon on the right and enter a correct name. 

![rename gif](/assets/images/rename.gif)



Note: You can add the ticket to the timeline in the future and continue a real time tracking. But real time tracking of a current ticket will stop once it reaches the start time of that ticket. 

You can also add worklogs using drag-and-drop function by pulling the ticket from the left panel with tickets list to the timeline on the right. The default duration of the worklog is equal 20 minutes, minimal duration is 1 minute. 



Set the duration of the worklog:

Pull the worklog up or down on the timeline (by pulling edges of it, keeping the left button of the mouse),
Set the time manually (by clicking on 'pen' next to time duration).
All the worklogs will be saved in Jira automatically. 

![drag gif](/assets/images/drag.gif)


Advanced tracking with JTT
    ‌‌‍‍

Short Worklogs

By default, the worklog duration is 20 minutes, but it can be edited to be 1 minute long.

Short worklogs can be created either by editing a worklog to less than 20 minutes or by stopping Real time tracking with a duration between 1 and 19 minutes.

![less than 20 m gif](/assets/images/less_than_20_mins.gif)




When a user edits the worklog to a duration of less than 20 minutes, then the worklog will no longer show its label.
The size of short worklogs bubbles is relative to their duration in minutes.
The beginning and ending hour containing the worklog will be in a blue box, this shows that there is a short worklog in that time frame. 

To enter the short worklog zoomed view click on any of the blue boxes or the short worklog, and the UI will zoom in the short worklog zoomed view.
In the zoomed view, the hours will be highlighted, with a blue box. To exit the short worklog zoomed view the user should click on the blue box.

In zoomed view, the user can create short worklogs with drag and drop (default value of worklog in zoomed view is 1 minute), start real time tracking, delete or edit worklogs, as you would do with normal worklogs.

![editing in zoom view gif](/assets/images/editing_in_zoom_view.gif)

    ‌‌‍‍

You can hide the ticket you do not want to see in your Tickets list. To do so drag it to the bottom of the page and hover over the 'Hide ticket from here' 

![hide gif](/assets/images/hide.gif)



To restore hidden ticket find it using search and do anything with it, for example, add it to your worklog - it will appear back in your Tickets list.

![restore gif](/assets/images/restore.gif)


    ‌‌‍‍

You can add a comment to a worklog and modify or delete it using a "Comment" popup menu item.

Commented worklogs are marked with a speech balloon icon next to them. Hover with a mouse cursor over a speech balloon to see a comment.

Please note that the maximum comment length is 500 symbols.

To save your comment, click outside a comment area or use the Ctrl+Enter hotkey.

![comment gif](/assets/images/comment.gif)

Reporting
Using "Calendar" function in JTT you can see time tracked:

For the day
Today or any previous day
For the week 
Current week or any previous week
Note: Time can be tracked up to 10 weeks back

![calendar jpg](/assets/images/calendar.jpeg)


    ‌‌‍‍

Keyboard Navigation
    ‌‌‍‍

You can do most of the routine operations using just a keyboard.

Navigation
Press Tab/Shift+Tab to switch between "Search", "Filter", "Tickets", "Calendar", and "Worklogs" areas.
Use Left/Right to switch between the "All of them", "Assigned to me", and "Favorites" tabs.
Tickets
Use Up/Down to select a ticket.
Press Enter to start/pause tracking time on a ticket.
Press Space to start dragging a ticket.
Press Shift+Space to find a free slot starting from midnight, create a worklog, and select it.
Press Cmd/Ctrl + click on ticket / play button - to start tracking from a previous worklog
Calendar
Use Left/Right to select a day or a week.
Press Enter/Space on a selected day to open its worklog.
Press Enter/Space on a selected week to expand it and select the first day of the week.
Worklogs navigation and editing
Use Up/Down to select a worklog.
Press Enter to tracking the same ticket.
Press Cmd/Ctrl + C to open comment area.
Press Shift + E to start editing a worklog.
Press Cmd/Ctrl + Shift + arrow up - to expand worklog up to the previous worklog
Press Cmd/Ctrl + Shift + arrow down - to expand worklog down to the next worklog
Press Cmd/Ctrl + Shift + E - to expand worklog both up and down
Press Tab/Shift+Tab to switch between worklog fields.
Press Space to activate "Comment" or "Delete" actions.
Press Enter/Esc to save changes and exit editing mode.
NVDA Screen Reader Support
NVDA Screen Reader hints are now available!





    ‌‌‍‍

Dark Mode
 ‌‌‍‍

JTT has a dark mode as well.

The dark mode is based on user preferences that are set on the PC, thus applied on the browser.

![dark jpg](/assets/images/dark.jpg)
