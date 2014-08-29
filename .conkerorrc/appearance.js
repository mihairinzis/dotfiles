// set theme
theme_load("conkeror-theme-zenburn");

// default zoom level
function my_zoom_set (buffer) {
    browser_zoom_set(buffer, false, 120);
}
add_hook('create_buffer_late_hook', my_zoom_set);

// darken current page
function darken_page (I) {
    var styles='* { background: black !important; color: grey !important; }'+
        ':link, :link * { color: #4986dd !important; }'+
        ':visited, :visited * { color: #d75047 !important; }';
    var document = I.buffer.document;
    var newSS=document.createElement('link');
    newSS.rel='stylesheet';
    newSS.href='data:text/css,'+escape(styles);
    document.getElementsByTagName("head")[0].appendChild(newSS);
}

interactive("darken-page", "Darken the page in an attempt to save your eyes.",
            darken_page);
define_key(content_buffer_normal_keymap, "C-d", "darken-page");

// show url in minibuffer
// var minibuffer_autohide_message_timeout = 3000;
// var minibuffer_autohide_timer = null;
// var minibuffer_mutually_exclusive_with_mode_line = true;

// var old_minibuffer_restore_state = (old_minibuffer_restore_state ||
//                                     minibuffer.prototype._restore_state);
// var old_minibuffer_show = (old_minibuffer_show ||
//                            minibuffer.prototype.show);
// var old_minibuffer_clear = (old_minibuffer_clear ||
//                             minibuffer.prototype.clear);

// show_minibuffer = function (window) {
//     window.minibuffer.element.collapsed = false;
//     if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
//         window.mode_line.container.collapsed = true;
// };

// hide_minibuffer = function (window) {
//     window.minibuffer.element.collapsed = true;
//     if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
//         window.mode_line.container.collapsed = false;
// };

// minibuffer.prototype._restore_state = function () {
//     if (minibuffer_autohide_timer) {
//         timer_cancel(minibuffer_autohide_timer);
//         minibuffer_autohide_timer = null;
//     }
//     if (this.current_state)
//         this.show();
//     else
//         hide_minibuffer(this.window);
//     old_minibuffer_restore_state.call(this);
// };

// minibuffer.prototype.hide = function () {
//     hide_minibuffer(this.window);
// };

// minibuffer.prototype.show = function (str, force, hide_after_timeout) {
//     var w = this.window;
//     var self = this;
//     show_minibuffer(this.window);
//     old_minibuffer_show.call(this, str, force);
//     if (minibuffer_autohide_timer)
//         timer_cancel(minibuffer_autohide_timer);
//     if (hide_after_timeout || hide_after_timeout == null) {
//         minibuffer_autohide_timer = call_after_timeout(
//             function (I) {self.hide();}, minibuffer_autohide_message_timeout);
//     }
// };

// minibuffer.prototype.clear = function () {
//     if (minibuffer_autohide_timer) {
//         timer_cancel(minibuffer_autohide_timer);
//         minibuffer_autohide_timer = null;
//     }
//     if (!this.current_state)
//         this.hide();
//     old_minibuffer_clear.call(this);
// };

// add_hook("window_initialize_hook", function (I) {I.window.minibuffer.hide();});


// interactive('show-page-title-forever', 'Show the page title of the page',
//             function(I) {I.window.minibuffer.show(I.buffer.document.title, false, true);});

///
/// Auto-hide Minibuffer
///

var minibuffer_autohide_timer = null;
var minibuffer_autohide_message_timeout = 3000; //milliseconds to show messages
var minibuffer_mutually_exclusive_with_mode_line = true;

function hide_minibuffer (window) {
    window.minibuffer.element.collapsed = true;
    if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
        window.mode_line.container.collapsed = false;
}

function show_minibuffer (window) {
    window.minibuffer.element.collapsed = false;
    if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
        window.mode_line.container.collapsed = true;
}

add_hook("window_initialize_hook", hide_minibuffer);
// for_each_window(hide_minibuffer); // initialize existing windows


var old_minibuffer_restore_state = (old_minibuffer_restore_state ||
                                    minibuffer.prototype._restore_state);
minibuffer.prototype._restore_state = function () {
    if (minibuffer_autohide_timer) {
        timer_cancel(minibuffer_autohide_timer);
        minibuffer_autohide_timer = null;
    }
    if (this.current_state)
        show_minibuffer(this.window);
    else
        hide_minibuffer(this.window);
    old_minibuffer_restore_state.call(this);
};

var old_minibuffer_show = (old_minibuffer_show || minibuffer.prototype.show);
minibuffer.prototype.show = function (str, force) {
    var w = this.window;
    show_minibuffer(w);
    old_minibuffer_show.call(this, str, force);
    if (minibuffer_autohide_timer)
        timer_cancel(minibuffer_autohide_timer);
    minibuffer_autohide_timer = call_after_timeout(
        function () { hide_minibuffer(w); },
        minibuffer_autohide_message_timeout);
};

var old_minibuffer_clear = (old_minibuffer_clear || minibuffer.prototype.clear);
minibuffer.prototype.clear = function () {
    if (minibuffer_autohide_timer) {
        timer_cancel(minibuffer_autohide_timer);
        minibuffer_autohide_timer = null;
    }
    if (! this.current_state)
        hide_minibuffer(this.window);
    old_minibuffer_clear.call(this);
};
