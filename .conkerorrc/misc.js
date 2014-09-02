// show favicons
require("favicon");

// mode-line
mode_line_mode(false);
// favicons in mode-line
// add_hook("mode_line_hook", mode_line_adder(buffer_icon_widget), true);
// require("mode-line.js");
// remove_hook("mode_line_hook", mode_line_adder(clock_widget));
// add_hook("mode_line_hook", mode_line_adder(buffer_icon_widget), true);
// add_hook("mode_line_hook", mode_line_adder(loading_count_widget), true);
// add_hook("mode_line_hook", mode_line_adder(buffer_count_widget), true);
// add_hook("mode_line_hook", mode_line_adder(zoom_widget));
// add_hook("mode_line_hook", mode_line_adder(downloads_status_widget));

// favicons in minibuffer completions list
read_buffer_show_icons = true;
// open middle-clicked links in new buffers
require("clicks-in-new-buffer.js");
// follow links in new background buffer
define_key(content_buffer_normal_keymap, "d", "follow-new-buffer-background");

// completion
url_completion_use_history = true;
url_completion_use_bookmarks = true;
url_completion_use_webjumps = true;
minibuffer_auto_complete_default = true;
// disable scrollbars - doesn't work
// buffer.browser.contentWindow.scrollbars.visible = false;
// session manager
require("session.js");
//session_auto_save_auto_load = true;
session_auto_save_auto_load = "prompt";
// close download manager when finished
user_pref("browser.download.manager.closeWhenDone", true);

// HTTPS everywhere
// if ('@eff.org/https-everywhere;1' in Cc) {
//     interactive("https-everywhere-options-dialog",
//                 "Open the HTTPS Everywhere options dialog.",
//                 function (I) {
//                     window_watcher.openWindow(
//                         null, "chrome://https-everywhere/content/preferences.xul",
//                         "", "chrome,titlebar,toolbar,centerscreen,resizable", null);
//                 });
// }
