// default directory for downloads and shell commands.
cwd = get_home_directory();
cwd.append("downloads");

// remember last save directory
function update_save_path (info) {
    cwd = info.target_file.parent;
}
add_hook("download_added_hook", update_save_path);

// load download buffers in the background in the current
// window, instead of in new windows.
download_buffer_automatic_open_target = OPEN_NEW_BUFFER_BACKGROUND;

// default download path and filename transformations
function suggest_save_path_from_file_name (file_name, buffer) {
    var cwd = with_current_buffer(buffer, function (I) I.local.cwd);
    var file = cwd.clone();
    for (let re in replace_map) {
        if (file_name.match(re)) {
            if (replace_map[re].path) {
                file = make_file(replace_map[re].path);
            }
            file_name = replace_map[re].transformer(file_name);
        }
    }
    file.append(file_name);
    return file.path;
}

var replace_map = {
    ".": {
        "transformer": function (filename) {
            return filename.replace( /[\W ]+/g   , "-"   )
                .replace( /^-+/       , ""    )
                .replace( /-+$/       , ""    )
                .replace( /-([^-]+)$/ , ".$1" )
                .toLowerCase();
        }
    },
    "\.torrent$": {
        "path": "~/downloads/",
        "transformer": function (filename) {
            return filename.replace( /isohunt-/i, "" );
        }
    }
};
