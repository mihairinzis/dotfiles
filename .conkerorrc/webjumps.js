define_webjump("wf", "https://www.wolframalpha.com/input/?i=%s");
define_webjump("yo", "https://www.youtube.com/results?search_query=%s&search=Search");
define_webjump("imbd", "https://imdb.com/find?q=%s");
define_webjump("stack",  "https://stackoverflow.com/search?q=%s", $alternative = "http://stackoverflow.com/");
define_webjump("duck", "https://duckduckgo.com/?q=%s");
define_webjump("img", "https://www.google.com/images?q=%s", $alternative = "http://www.google.com/imghp");
define_webjump("trans", "https://translate.google.com/translate_t#auto|en|%s");
define_webjump("roen", "https://translate.google.com/translate_t#ro|en|%s");
define_webjump("enro", "https://translate.google.com/translate_t#en|ro|%s");
define_webjump("github", "https://github.com/search?q=%s&type=Everything");
define_webjump("dex", "http://dexonline.ro/definitie/%s");
