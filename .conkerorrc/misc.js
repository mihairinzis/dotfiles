// show favicons
require("favicon");
// disable mode-line
mode_line_mode(false);
// favicons in mode-line
// add_hook("mode_line_hook", mode_line_adder(buffer_icon_widget), true);
// favicons in minibuffer completions list
read_buffer_show_icons = true;
// open middle-clicked links in new buffers
require("clicks-in-new-buffer.js");
// follow links in new background buffer
define_key(content_buffer_normal_keymap, "d", "follow-new-buffer-background");
minibuffer_auto_complete_default = true;
url_completion_use_history = true; // should work since bf05c87405
url_completion_use_bookmarks = true;
// disable scrollbars - doesn't work
// buffer.browser.contentWindow.scrollbars.visible = false;
// session manager
require("session.js");
//session_auto_save_auto_load = true;
session_auto_save_auto_load = "prompt";
// close download manager when finished
user_pref("browser.download.manager.closeWhenDone", true);
