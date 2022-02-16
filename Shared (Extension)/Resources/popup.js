console.log("Hello World!", browser);
browser.tabs.create({'url': chrome.extension.getURL('https://orioks.miet.ru/student/student')}, function(tab) {
    var daddy = window.self;
    daddy.opener = window.self;
    daddy.close();
});

