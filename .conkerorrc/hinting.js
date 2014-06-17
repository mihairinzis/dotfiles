// display info about hint in minibuffer
hints_minibuffer_annotation_mode(true);

// bigger hint numbers
register_user_stylesheet(
    "data:text/css," +
        escape(
            "@namespace url(\"http://www.w3.org/1999/xhtml\");\n" +
                "span.__conkeror_hint {\n"+
                "  font-size: 12px !important;\n"+
                "  line-height: 12px !important;\n"+
                "}"));
