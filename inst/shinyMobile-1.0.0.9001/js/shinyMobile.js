$((function() {
    var config = $(document).find("script[data-for='app']");
    config = JSON.parse(config.html());
    var isPWA = $("body").attr("data-pwa") === "true";
    config.root = "#app";
    if (isPWA) {
        config.serviceWorker = {
            path: window.location.pathname + "service-worker.js",
            scope: window.location.pathname
        };
    }
    config.methods = {
        toggleDarkTheme: function() {
            var self = this;
            var $html = self.$("html");
            $html.toggleClass("theme-dark");
        }
    };
    config.data = function() {
        return {
            popovers: [],
            tooltips: [],
            actions: []
        };
    };
    app = new Framework7(config);
    mainView = app.views.create(".view-main");
    if (!config.hasOwnProperty("dark")) config.dark = false;
    if (config.dark) {
        app.methods.toggleDarkTheme();
    }
    if (config.hasOwnProperty("touch")) {
        if (config.touch.tapHold) {
            $("<style>").prop("type", "text/css").html(`\n          -moz-user-select: none;\n          -webkit-user-select: none;\n          user-select: none;`).appendTo("head");
        }
    }
    if (config.hasOwnProperty("color")) {
        var colorCSS = app.utils.colorThemeCSSProperties(config.color);
        $("<style>").prop("type", "text/css").html(`:root {\n        --f7-theme-color: ${colorCSS["--f7-theme-color"]};\n        --f7-theme-color-rgb: ${colorCSS["--f7-theme-color-rgb"]};\n        --f7-theme-color-shade: ${colorCSS["--f7-theme-color-shade"]};\n        --f7-theme-color-tint: ${colorCSS["--f7-theme-color-tint"]};\n      }`).appendTo("head");
    }
    if (!config.hasOwnProperty("filled")) config.filled = false;
    if (config.filled) {
        var filledCSS = `\n    :root,\n    :root.theme-dark,\n    :root .theme-dark {\n      --f7-bars-bg-color: var(--f7-theme-color);\n      --f7-bars-bg-color-rgb: var(--f7-theme-color-rgb);\n      --f7-bars-translucent-opacity: 0.9;\n      --f7-bars-text-color: #fff;\n      --f7-bars-link-color: #fff;\n      --f7-navbar-subtitle-text-color: rgba(255,255,255,0.85);\n      --f7-bars-border-color: transparent;\n      --f7-tabbar-link-active-color: #fff;\n      --f7-tabbar-link-inactive-color: rgba(255,255,255,0.54);\n      --f7-sheet-border-color: transparent;\n      --f7-tabbar-link-active-border-color: #fff;\n    }\n    .appbar,\n    .navbar,\n    .toolbar,\n    .subnavbar,\n    .calendar-header,\n    .calendar-footer {\n      --f7-touch-ripple-color: var(--f7-touch-ripple-white);\n      --f7-link-highlight-color: var(--f7-link-highlight-white);\n      --f7-button-text-color: #fff;\n      --f7-button-pressed-bg-color: rgba(255,255,255,0.1);\n    }\n    .navbar-large-transparent,\n    .navbar-large.navbar-transparent {\n      --f7-navbar-large-title-text-color: #000;\n\n      --r: 0;\n      --g: 122;\n      --b: 255;\n      --progress: var(--f7-navbar-large-collapse-progress);\n      --f7-bars-link-color: rgb(\n        calc(var(--r) + (255 - var(--r)) * var(--progress)),\n        calc(var(--g) + (255 - var(--g)) * var(--progress)),\n        calc(var(--b) + (255 - var(--b)) * var(--progress))\n      );\n    }\n    .theme-dark .navbar-large-transparent,\n    .theme-dark .navbar-large.navbar-transparent {\n      --f7-navbar-large-title-text-color: #fff;\n  }`;
        $("<style>").prop("type", "text/css").html(`${filledCSS}`).appendTo("head");
    }
    $("body").addClass(config.color);
    $("body").attr("filled", config.filled);
}));

$((function() {
    $(document).on("shiny:disconnected", (function(event) {
        $("#ss-connect-dialog").hide();
        $("#ss-overlay").hide();
        var reconnectToast = app.toast.create({
            icon: '<i class="icon f7-icons">bolt_fill</i>',
            position: "center",
            text: 'Oups... disconnected </br> </br> <div class="row"><button onclick="Shiny.shinyapp.reconnect();" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" class="toast-button button color-red col">Reload</button></div>'
        }).open();
        $(".toast-button").on("click", (function() {
            reconnectToast.close();
        }));
    }));
    $(document).on("shiny:sessioninitialized", (function(event) {
        Shiny.setInputValue("shinyInfo", Shiny.shinyapp.config);
    }));
    $(document).on("shiny:inputchanged", (function(event) {
        Shiny.setInputValue("lastInputChanged", {
            name: event.name,
            value: event.value,
            type: event.binding.name.split(".")[1]
        });
    }));
    $(document).on("shiny:connected", (function(event) {
        Shiny.setInputValue("deviceInfo", Framework7.device);
    }));
    if (Framework7.device.standalone) {
        $("html, body").css({
            height: "100vh",
            width: "100vw"
        });
        if ($(".appbar").length > 0) {
            $(".toolbar").css("margin-bottom", "20px");
        }
    }
    $(".tabs-standalone").css("height", "auto");
    if (app.params.filled && app.params.dark && $("body").attr("class") !== "#ffffff") {
        $(".demo-send-message-link").find("i").addClass("color-white");
    }
    if (app.params.dark) {
        $(".page-content").css("background-color", "");
        $(".page-content.tab, .tab").css("background-color", "");
        $(".demo-facebook-card .card-footer").css("background-color", "#1c1c1d");
        $(".sheet-modal, .swipe-handler").css("background-color", "#1b1b1d");
        $(".popup").css("background-color", "#1b1b1d");
        $(".fab-label").css("background-color", "var(--f7-fab-label-text-color)");
        $(".fab-label").css("color", "var(--f7-fab-text-color)");
        $(".accordion-item .item-content .item-inner").css("color", "white");
        $(".accordion-item .accordion-item-content").css("color", "white");
        var sidebarPanel = $("#f7-sidebar-view").find(".page-content");
        $(sidebarPanel).css("background-color", "#1e1e1e");
        var sidebarItems = $("#f7-sidebar-view").find("li");
        $(sidebarItems).css("background-color", "#171717");
    } else {
        $("div.messages").css("background-color", "gainsboro");
        $("a").on("click", (function() {
            setTimeout((function() {
                var linkColors = $("body").attr("class");
                $(".navbar-photo-browser .navbar-inner .title").css("color", "black");
                $(".navbar-photo-browser .navbar-inner .right .popup-close").css("color", linkColors);
                $(".photo-browser-page .toolbar .toolbar-inner a").css("color", linkColors);
            }), 100);
        }));
    }
    var subnavbar = $(".subnavbar");
    if (subnavbar.length == 1) {
        $(".page").addClass("page-with-subnavbar");
    }
    Shiny.addCustomMessageHandler("update-app", (function(message) {
        app.utils.extend(app.params, message);
    }));
    Shiny.addCustomMessageHandler("update-entity", (function(message) {
        var instanceFamily;
        for (const property in app.data) {
            for (const e in app.data[property]) {
                if (e === message.id) {
                    instanceFamily = property;
                }
            }
        }
        var oldInstance = app.data[instanceFamily][message.id];
        var oldConfig = oldInstance.params;
        var newConfig = app.utils.extend(oldConfig, message.options);
        oldInstance.destroy();
        var newInstance = app[instanceFamily].create(newConfig);
        app.data[instanceFamily][message.id] = newInstance;
    }));
    const uiWidgets = [ "gauge", "swiper", "searchbar" ];
    const serverWidgets = [ "toast", "photoBrowser", "notification" ];
    const widgets = uiWidgets.concat(serverWidgets);
    activateWidget = function(widget) {
        if (uiWidgets.indexOf(widget) > -1) {
            $("." + widget).each((function() {
                var $el = $(this);
                var config = $(document).find("script[data-for='" + $el.attr("id") + "']");
                config = JSON.parse(config.html());
                config.el = "#" + $el.attr("id");
                app[widget].create(config);
            }));
        } else {
            Shiny.addCustomMessageHandler(widget, (function(message) {
                app[widget].create(message).open();
            }));
        }
    };
    widgets.forEach((function(w) {
        activateWidget(w);
    }));
    popoverIds = [];
    getAllPopoverIds = function() {
        $("[data-popover]").each((function() {
            popoverIds.push($(this).attr("data-popover"));
        }));
    };
    getAllPopoverIds();
    popoverIds.forEach((function(index) {
        Shiny.addCustomMessageHandler(index, (function(message) {
            var popover = app.popover.create({
                targetEl: '[data-popover = "' + index + '"]',
                content: '<div class="popover">' + '<div class="popover-inner">' + '<div class="block">' + message.content + "</div>" + "</div>" + "</div>"
            });
            $('[data-popover = "' + index + '"]').on("click", (function() {
                popover.open();
            }));
        }));
    }));
    Shiny.addCustomMessageHandler("add_popover", (function(message) {
        if (app.data.popovers[message.targetEl] === undefined) {
            if (!$(message.targetEl).hasClass("popover-disabled")) {
                message.content = `\n        <div class="popover">\n          <div class="popover-angle"></div>\n          <div class="popover-inner">\n            <div class="block">${message.content}</div>\n          </div>\n        </div>\n        `;
                var p = app.popover.create(message);
                p.open();
                app.data.popovers[message.targetEl] = p;
            }
        } else {
            if (!$(message.targetEl).hasClass("popover-disabled")) {
                app.data.popovers[message.targetEl].open();
            }
        }
    }));
    Shiny.addCustomMessageHandler("toggle_popover", (function(message) {
        $(message).toggleClass("popover-disabled");
    }));
    Shiny.addCustomMessageHandler("add_tooltip", (function(message) {
        if (app.data.tooltips[message.targetEl] === undefined) {
            var t = app.tooltip.create(message);
            t.show();
            app.data.tooltips[message.targetEl] = t;
        }
    }));
    Shiny.addCustomMessageHandler("update_tooltip", (function(message) {
        if (app.data.tooltips[message.targetEl] !== undefined) {
            var t = app.tooltip.get(message.targetEl);
            if (message.action === "update") {
                if (t) {
                    t.setText(message.text);
                }
            } else if (message.action === "toggle") {
                if (t) {
                    var cachedTooltip = Object.assign({}, t);
                    app.data.tooltips[message.targetEl] = cachedTooltip;
                    t.destroy();
                } else {
                    var pars = app.data.tooltips[message.targetEl].params;
                    t = app.tooltip.create(pars);
                    app.data.tooltips[message.targetEl] = t;
                }
            }
        }
    }));
    Shiny.addCustomMessageHandler("dialog", (function(message) {
        var type = message.type;
        var text = `<div style="max-height: 300px; overflow-y: scroll;">${message.text}</div>`;
        switch (type) {
          case "alert":
            var dialog = app.dialog.alert(text, message.title);
            break;

          case "confirm":
            var confirm = app.dialog.confirm(text = text, title = message.title, callbackOk = function() {
                Shiny.setInputValue(message.id, true);
            }, callbackCancel = function() {
                Shiny.setInputValue(message.id, false);
            }).open(Shiny.setInputValue(message.id, null));
            break;

          case "prompt":
            var prompt = app.dialog.prompt(text = text, title = message.title, callbackOk = function(value) {
                Shiny.setInputValue(message.id, value);
            }, callbackCancel = function() {
                Shiny.setInputValue(message.id, null);
            }).open(Shiny.setInputValue(message.id, null));
            break;

          case "login":
            console.log(login);
            var login = app.dialog.login(text = text, title = message.title, callbackOk = function(username, password) {
                Shiny.setInputValue(message.id, {
                    user: username,
                    password: password
                });
            }, callbackCancel = function() {
                Shiny.setInputValue(message.id, null);
            }).open(Shiny.setInputValue(message.id, null));
            break;

          default:
            console.log("");
        }
    }));
    Shiny.addCustomMessageHandler("tapHold", (function(message) {
        var callback = new Function("return (" + message.callback + ")");
        $(message.target).on("taphold", (function() {
            callback();
        }));
    }));
    var tabIds = [];
    getAllTabSetIds = function() {
        $(".tabs.ios-edges").each((function() {
            tabIds.push(this.id);
        }));
    };
    getAllTabSetIds();
    tabIds.forEach((function(index) {
        var id = "insert_" + index;
        Shiny.addCustomMessageHandler(id, (function(message) {
            var tabId = $("#" + message.ns + "-" + message.target);
            var tab = $(message.value.html);
            var newTab;
            if ($(tabId).hasClass("swiper-slide")) {
                newTab = $(tab).addClass("swiper-slide");
                if ($(".tabLinks").children(1).hasClass("segmented")) {
                    $(newTab).removeClass("page-content");
                }
                if (message.select === "true") {
                    $(newTab).addClass("swiper-slide-active");
                }
                if (app.params.dark) $(newTab).css("background-color", "");
            } else {
                newTab = $(tab);
                if (app.params.dark) $(newTab).css("background-color", "");
            }
            if (message.position === "after") {
                $(newTab).insertAfter($(tabId));
                $(message.link).insertAfter($('.tabLinks [data-tab ="#' + message.ns + "-" + message.target + '"]'));
            } else if (message.position === "before") {
                $(newTab).insertBefore($(tabId));
                $(message.link).insertBefore($('.tabLinks [data-tab ="#' + message.ns + "-" + message.target + '"]'));
            }
            Shiny.renderContent(tab[0], {
                html: tab.html(),
                deps: message.value.deps
            });
            if ($(".tabLinks").children(1).hasClass("segmented")) {
                var newLink;
                var oldLink = $('.tabLinks [data-tab ="#' + message.id + '"]');
                newLink = $(oldLink).replaceWith('<button class="button tab-link" data-tab="#' + message.id + '">' + $(oldLink).html() + "</button>");
            }
            if ($(tabId).hasClass("swiper-slide")) {
                var swiper = document.querySelector(".swiper-container").swiper;
                swiper.update();
            }
            if (message.select === "true") {
                app.tab.show("#" + message.id, true);
            }
        }));
    }));
    tabIds.forEach((function(index) {
        var id = "remove_" + index;
        Shiny.addCustomMessageHandler(id, (function(message) {
            var tabToRemove = $("#" + message.ns + "-" + message.target);
            $(".tabs.ios-edges").css("transform", "");
            if (!$(".tabLinks").children(1).hasClass("segmented")) {
                $('.toolbar-inner a[data-tab="#' + message.ns + "-" + message.target + '"]').remove();
            } else {
                var linkToRemove = $('.tabLinks button[data-tab="#' + message.ns + "-" + message.target + '"]');
                var otherLinks = $(".tabLinks button").not('[data-tab="#' + message.ns + "-" + message.target + '"]');
                if ($(linkToRemove).next().length === 0) {
                    if (!$(otherLinks).hasClass("tab-link-active")) {
                        $(linkToRemove).prev().addClass("tab-link-active");
                    }
                } else {
                    if (!$(otherLinks).hasClass("tab-link-active")) {
                        $(linkToRemove).next().addClass("tab-link-active");
                    }
                }
                $(linkToRemove).remove();
            }
            $("#" + message.ns + "-" + message.target).remove();
            if ($(tabToRemove).hasClass("swiper-slide")) {
                var swiper = document.querySelector(".swiper-container").swiper;
                swiper.update();
            }
            var nextTabId = $(tabToRemove).next().attr("id");
            app.tab.show("#" + nextTabId);
            if (!$(".tabLinks").children(1).hasClass("segmented")) {
                $(".tab-link-highlight").remove();
                segment_width = 100 / $(".toolbar-inner > a").length;
                $(".toolbar-inner").append('<span class="tab-link-highlight" style="width: ' + segment_width + '%;"></span>');
            }
        }));
    }));
    Shiny.addCustomMessageHandler("update-gauge", (function(message) {
        var el = "#" + message.id;
        app.gauge.get(el).update(message);
    }));
    activateAllProgress = function() {
        $(".progressbar").each((function() {
            var el = "#" + $(this).attr("id");
            var progress = parseInt($(this).attr("data-progress"));
            app.progressbar.show(el, progress);
        }));
    };
    activateAllProgress();
    Shiny.addCustomMessageHandler("update-progress", (function(message) {
        app.progressbar.set("#" + message.id, message.progress);
    }));
    Shiny.addCustomMessageHandler("show_navbar", (function(message) {
        var animate;
        if (message.animate == "true") animate = true; else animate = false;
        app.navbar.show(".navbar", animate = message.animate);
    }));
    Shiny.addCustomMessageHandler("hide_navbar", (function(message) {
        var animate;
        var hideStatusbar;
        if (message.animate == "true") animate = true; else animate = false;
        if (message.hideStatusbar == "true") hideStatusbar = true; else hideStatusbar = false;
        app.navbar.hide(".navbar", animate = animate, hideStatusbar = hideStatusbar);
    }));
    Shiny.addCustomMessageHandler("toggle_navbar", (function(message) {
        $navbar = $(".navbar");
        var isHidden = $navbar.hasClass("navbar-hidden");
        if (isHidden) {
            app.navbar.show(".navbar", animate = message.animate);
        } else {
            app.navbar.hide(".navbar", animate = message.animate, hideStatusbar = message.hideStatusbar);
        }
    }));
    Shiny.addCustomMessageHandler("action-sheet", (function(message) {
        if (app.data.actions[message.id] === undefined) {
            var buttonsId = message.id + "_button";
            function setButtonInput(index) {
                Shiny.setInputValue(buttonsId, index);
            }
            function setOnClick(element, index) {
                Object.defineProperty(element, "onClick", {
                    value: function() {
                        setButtonInput(index + 1);
                    },
                    writable: false
                });
            }
            message.buttons.forEach(setOnClick);
            message.on = {
                opened: function() {
                    Shiny.setInputValue(message.id, true);
                },
                closed: function() {
                    Shiny.setInputValue(message.id, false);
                    Shiny.setInputValue(buttonsId, null);
                }
            };
            var a = app.actions.create(message);
            a.open();
            app.data.actions[message.id] = a;
        } else {
            app.data.actions[message.id].open();
        }
    }));
    Shiny.addCustomMessageHandler("update-action-sheet", (function(message) {
        app.data.actions[message.id].destroy();
        var a = app.actions.create(message);
        app.data.actions[message.id] = a;
    }));
    if ($("body").attr("data-ptr") === "true") {
        const ptrLoader = $('<div class="ptr-preloader">' + '<div class="preloader"></div>' + '<div class="ptr-arrow"></div>' + "</div>");
        $(".page-content").addClass("ptr-content").prepend(ptrLoader).attr("data-ptr-distance", "55").attr("data-ptr-mousewheel", "true");
        app.ptr.create(".ptr-content");
        var ptr = app.ptr.get(".ptr-content");
        ptr.on("refresh", (function(e) {
            Shiny.setInputValue("ptr", true);
            setTimeout((function() {
                app.ptr.done();
            }), 2e3);
        }));
        ptr.on("done", (function(e) {
            Shiny.setInputValue("ptr", null);
        }));
    }
    Shiny.addCustomMessageHandler("validate-input", (function(message) {
        $("#" + message.target).attr("required", "").attr("validate", "").attr("pattern", message.pattern).attr("data-error-message", message.error);
        $("#" + message.target).closest(".item-content.item-input").addClass("item-input-with-info");
        var infoTag;
        if (message.info !== undefined) {
            infoTag = '<div class = "item-input-info">' + message.info + "</div>";
        }
        $("#" + message.target).parent().append(infoTag);
    }));
    Shiny.addCustomMessageHandler("show-preloader", (function(message) {
        if (typeof message.el !== "undefined") {
            app.preloader.showIn(message.el, message.color);
        } else {
            app.preloader.show(message.color);
        }
    }));
    Shiny.addCustomMessageHandler("hide-preloader", (function(message) {
        if (typeof message.el !== "undefined") {
            app.preloader.hideIn(message.el);
        } else {
            app.preloader.hide();
        }
    }));
    $(".swipeout-item").each((function() {
        $(this).on("click", (function() {
            Shiny.setInputValue($(this).attr("id"), true, {
                priority: "event"
            });
            app.swipeout.close($(this).closest(".swipeout"));
        }));
    }));
}));

var f7ActionSheetBinding = new Shiny.InputBinding;

$.extend(f7ActionSheetBinding, {
    find: function(scope) {},
    getValue: function(el) {},
    receiveMessage: function(el, data) {},
    subscribe: function(el, callback) {},
    unsubscribe: function(el) {}
});

Shiny.inputBindings.register(f7ActionSheetBinding);

var f7AutoCompleteBinding = new Shiny.InputBinding;

$.extend(f7AutoCompleteBinding, {
    initialize: function(el) {
        var id = $(el).attr("id");
        var data = {};
        [].forEach.call(el.attributes, (function(attr) {
            if (/^data-/.test(attr.name)) {
                var camelCaseName = attr.name.substr(5).replace(/-(.)/g, (function($0, $1) {
                    return $1.toUpperCase();
                }));
                if ([ "openIn", "choices", "value", "dropdownPlaceholderText" ].indexOf(camelCaseName) == -1) {
                    var isTrueSet = attr.value == "true";
                    data[camelCaseName] = isTrueSet;
                } else {
                    data[camelCaseName] = attr.value;
                }
            }
        }));
        var vals = JSON.parse(data.choices);
        data.value = JSON.parse(data.value);
        if (data.openIn == "dropdown") {
            data.inputEl = "#" + id;
        } else {
            data.openerEl = "#" + id;
        }
        data.on = {
            change: function(value) {
                $("#" + id).find(".item-after").text(value[0]);
                $("#" + id).find("input").val(value[0]);
                $("#" + id).trigger("change");
            }
        };
        data.source = function(query, render) {
            var results = [];
            if (query.length === 0) {
                render(results);
                return;
            }
            for (var i = 0; i < vals.length; i++) {
                if (vals[i].toLowerCase().indexOf(query.toLowerCase()) >= 0) {
                    results.push(vals[i]);
                }
            }
            render(results);
        };
        app.autocomplete.create(data);
    },
    find: function(scope) {
        return $(scope).find(".autocomplete-input");
    },
    getValue: function(el) {
        var a = app.autocomplete.get($(el));
        return a.value;
    },
    setValue: function(el, value) {
        var a = app.autocomplete.get($(el));
        a.value = value;
        a.$inputEl[0].value = value;
        $(el).trigger("change");
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("value")) {
            this.setValue(el, data.value);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7AutoCompleteBinding", (function(e) {
            setTimeout((function() {
                callback();
            }), 10);
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7AutoCompleteBinding");
    }
});

Shiny.inputBindings.register(f7AutoCompleteBinding, "f7.autocomplete");

var f7ButtonInputBinding = new Shiny.InputBinding;

$.extend(f7ButtonInputBinding, {
    find: function(scope) {
        return $(scope).find(".f7-action-button");
    },
    getValue: function(el) {
        return $(el).data("val") || 0;
    },
    setValue: function(el, value) {
        $(el).data("val", value);
    },
    getType: function(el) {
        return "shiny.action";
    },
    subscribe: function(el, callback) {
        $(el).on("click.f7ButtonInputBinding", (function(e) {
            var $el = $(this);
            var val = $el.data("val") || 0;
            $el.data("val", val + 1);
            callback();
        }));
    },
    getState: function(el) {
        return {
            value: this.getValue(el)
        };
    },
    receiveMessage: function(el, data) {
        var $el = $(el);
        if (data.hasOwnProperty("color")) {
            $(el).removeClass((function(index, className) {
                return (className.match(/(^|\s)color-\S+/g) || []).join(" ");
            }));
            $(el).addClass("color-" + data.color);
        }
        if (data.hasOwnProperty("fill")) {
            var isFilled = $(el).hasClass("button-fill");
            if (data.fill) {
                if (!isFilled) $(el).addClass("button-fill");
            } else {
                if (isFilled) $(el).removeClass("button-fill");
            }
        }
        if (data.hasOwnProperty("outline")) {
            var isOutline = $(el).hasClass("button-outline");
            if (data.outline) {
                if (!isOutline) $(el).addClass("button-outline");
            } else {
                if (isOutline) $(el).removeClass("button-outline");
            }
        }
        if (data.hasOwnProperty("shadow")) {
            var isRaised = $(el).hasClass("button-raised");
            if (data.shadow) {
                if (!isRaised) $(el).addClass("button-raised");
            } else {
                if (isRaised) $(el).removeClass("button-raised");
            }
        }
        if (data.hasOwnProperty("rounded")) {
            var isRounded = $(el).hasClass("button-round");
            if (data.rounded) {
                if (!isRounded) $(el).addClass("button-round");
            } else {
                if (isRounded) $(el).removeClass("button-round");
            }
        }
        if (data.hasOwnProperty("size")) {
            var isLarge = $(el).hasClass("button-large");
            var isSmall = $(el).hasClass("button-small");
            if (!isLarge & !isSmall) $(el).addClass("button-" + data.size);
            if (!isLarge & isSmall) {
                $(el).removeClass("button-small");
                $(el).addClass("button-" + data.size);
            }
            if (isLarge & !isSmall) {
                $(el).removeClass("button-large");
                $(el).addClass("button-" + data.size);
            }
        }
        var label = $el.text();
        if (data.hasOwnProperty("label")) label = data.label;
        $el.html(label);
    },
    unsubscribe: function(el) {
        $(el).off(".f7ButtonInputBinding");
    }
});

Shiny.inputBindings.register(f7ButtonInputBinding, "f7.button");

$(document).on("click", "a.f7-action-button", (function(e) {
    e.preventDefault();
}));

var f7CardBinding = new Shiny.InputBinding;

$.extend(f7CardBinding, {
    find: function(scope) {
        return $(scope).find(".card-expandable");
    },
    getValue: function(el) {
        var open = $(el).hasClass("card-opened");
        return open;
    },
    receiveMessage: function(el, data) {
        app.card.toggle($(el));
    },
    subscribe: function(el, callback) {
        $(el).on("card:opened.f7CardBinding card:closed.f7CardBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7CardBinding");
    }
});

Shiny.inputBindings.register(f7CardBinding, "f7.card");

var f7CollapsibleBinding = new Shiny.InputBinding;

$.extend(f7CollapsibleBinding, {
    find: function(scope) {
        return $(scope).find(".collapsible");
    },
    getValue: function(el) {
        var accordionId = $($(el)[0]).attr("id");
        var items = $("#" + accordionId + " li.accordion-item-opened");
        if (items.length > 0) {
            if (items.length === 1) {
                var val = $(items[0]).find(".item-title").html();
                return {
                    state: true,
                    value: val
                };
            } else {
                var titles = [];
                $(items).each((function(i) {
                    titles.push($(items[i]).find(".item-title").html());
                }));
                return {
                    state: true,
                    value: titles
                };
            }
        } else {
            return {
                state: false,
                value: null
            };
        }
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("selected")) {
            var accordionId = $($(el)[0]).attr("id");
            var items = $("#" + accordionId + " .accordion-item");
            var idx = data.selected - 1;
            var target = $(items[idx]);
            app.accordion.toggle(target);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("accordion:opened.f7CollapsibleBinding accordion:closed.f7CollapsibleBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7CollapsibleBinding");
    }
});

Shiny.inputBindings.register(f7CollapsibleBinding, "f7.collapsible");

var f7ColorPickerBinding = new Shiny.InputBinding;

$.extend(f7ColorPickerBinding, {
    initialize: function(el) {
        app.colorPicker.create({
            inputEl: el,
            targetEl: $(el).attr("id") + "-value",
            targetElSetBackgroundColor: true,
            modules: colorPickerModules,
            openIn: "auto",
            sliderValue: colorPickerSliderValue,
            sliderValueEditable: colorPickerSliderValueEditable,
            sliderLabel: colorPickerSliderLabel,
            hexLabel: colorPickerHexLabel,
            hexValueEditable: colorPickerHexValueEditable,
            groupedModules: colorPickerGroupedModules,
            palette: colorPickerPalettes,
            value: {
                hex: colorPickerValue
            }
        });
    },
    find: function(scope) {
        return $(scope).find(".color-picker-input");
    },
    getValue: function(el) {
        var ID = $(el).attr("id");
        return document.getElementById(ID).value;
    },
    setValue: function(el, value) {},
    receiveMessage: function(el, data) {},
    subscribe: function(el, callback) {
        $(el).on("change.f7ColorPickerBinding ", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7ColorPickerBinding ");
    }
});

Shiny.inputBindings.register(f7ColorPickerBinding, "f7.colorpicker");

var f7DateBinding = new Shiny.InputBinding;

$.extend(f7DateBinding, {
    find: function(scope) {
        return $(scope).find(".date-input");
    },
    getValue: function(el) {
        console.log($(el).attr("value"));
        return $(el).attr("value");
    },
    setValue: function(el, value) {},
    receiveMessage: function(el, data) {},
    subscribe: function(el, callback) {
        $(el).on("keyup.dateInputBinding input.dateInputBinding", (function(event) {
            callback(true);
        }));
        $(el).on("change.f7DateBinding", (function(e) {
            callback(false);
        }));
    },
    getRatePolicy: function() {
        return {
            policy: "debounce",
            delay: 250
        };
    },
    unsubscribe: function(el) {
        $(el).off(".f7DateBinding");
    }
});

Shiny.inputBindings.register(f7DateBinding, "f7.date");

var f7DatePickerBinding = new Shiny.InputBinding;

$.extend(f7DatePickerBinding, {
    initialize: function(el) {
        var inputEl = $(el)[0];
        var config = $(el).parent().find("script[data-for='" + el.id + "']");
        config = JSON.parse(config.html());
        if (!config.hasOwnProperty("value")) {
            config.value = [ new Date ];
        } else {
            for (var i = 0; i < config.value.length; i++) {
                config.value[i] = new Date(config.value[i]);
            }
        }
        config.inputEl = inputEl;
        var calendar = app.calendar.create(config);
        this["calendar-" + el.id] = calendar;
    },
    find: function(scope) {
        return $(scope).find(".calendar-input");
    },
    getType: function(el) {
        return "f7DatePicker.date";
    },
    getValue: function(el) {
        return this["calendar-" + el.id].getValue();
    },
    setValue: function(el, value) {
        this["calendar-" + el.id].setValue(value);
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("config")) {
            this["calendar-" + el.id].destroy();
            data.config.inputEl = el;
            this["calendar-" + el.id] = app.calendar.create(data.config);
        }
        if (data.hasOwnProperty("value")) {
            var tmpdate;
            for (var i = 0; i < data.value.length; i++) {
                tmpdate = new Date(data.value[i]);
                data.value[i] = new Date(tmpdate.getFullYear(), tmpdate.getMonth(), tmpdate.getDate());
            }
            this.setValue(el, data.value);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7DatePickerBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7DatePickerBinding");
    }
});

Shiny.inputBindings.register(f7DatePickerBinding, "f7.datepicker");

var f7FabsBinding = new Shiny.InputBinding;

$.extend(f7FabsBinding, {
    find: function(scope) {
        return $(scope).find(".fab");
    },
    getValue: function(el) {
        var open = $(el).hasClass("fab-opened");
        return open;
    },
    receiveMessage: function(el, data) {
        app.fab.toggle("#" + $(el).attr("id"));
    },
    subscribe: function(el, callback) {
        $(el).on("fab:open.f7FabsBinding fab:close.f7FabsBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7FabsBinding");
    }
});

Shiny.inputBindings.register(f7FabsBinding, "f7.fabs");

var f7LoginBinding = new Shiny.InputBinding;

$.extend(f7LoginBinding, {
    initialize: function(el) {
        var data = {};
        data.el = "#" + $(el).attr("id");
        data.animate = false;
        data.on = {
            opened: function() {
                $(el).trigger("shown");
            }
        };
        var l = app.loginScreen.create(data);
        var startOpen = JSON.parse($(el).attr("data-start-open"))[0];
        if (startOpen) l.open();
    },
    find: function(scope) {
        return $(scope).find(".login-screen");
    },
    getValue: function(el) {
        var l = app.loginScreen.get($(el));
        return l.opened;
    },
    receiveMessage: function(el, data) {
        var l = app.loginScreen.get($(el));
        if (l.opened) {
            if (data.user.length > 0 && data.password.length > 0) {
                l.close();
            } else {
                app.dialog.alert("Please enter a valid password and user.");
            }
        } else {
            l.open();
        }
    },
    subscribe: function(el, callback) {
        $(el).on("loginscreen:opened.f7LoginBinding loginscreen:closed.f7LoginBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7LoginBinding");
    }
});

Shiny.inputBindings.register(f7LoginBinding, "f7.login");

var f7MenuBinding = new Shiny.InputBinding;

$.extend(f7MenuBinding, {
    find: function(scope) {
        return $(scope).find(".menu-item-dropdown");
    },
    getValue: function(el) {
        return $(el).hasClass("menu-item-dropdown-opened");
    },
    receiveMessage: function(el, data) {
        var isOpened = $(el).hasClass("menu-item-dropdown-opened");
        if (!isOpened) {
            app.menu.open($(el));
        }
    },
    subscribe: function(el, callback) {
        $(el).on("menu:opened.f7MenuBinding menu:closed.f7MenuBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7MenuBinding");
    }
});

Shiny.inputBindings.register(f7MenuBinding, "f7.menu");

var f7MessageBarBinding = new Shiny.InputBinding;

$.extend(f7MessageBarBinding, {
    initialize: function(el) {
        app.messagebar.create({
            el: "#" + $(el).attr("id")
        });
    },
    setState: function(el) {
        var val = app.messagebar.get($(el)).getValue();
        var sendLink = $(el).find("#" + el.id + "-send");
        if (!val.length) {
            $(sendLink).addClass("disabled");
        } else {
            $(sendLink).removeClass("disabled");
        }
        return val;
    },
    find: function(scope) {
        return $(scope).find(".messagebar");
    },
    getValue: function(el) {
        return this.setState(el);
    },
    setValue: function(el, value) {
        app.messagebar.get($(el)).setValue(value);
    },
    setPlaceholder: function(el, value) {
        app.messagebar.get($(el)).setPlaceholder(value);
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("value")) {
            this.setValue(el, data.value);
        }
        if (data.hasOwnProperty("placeholder")) {
            this.setPlaceholder(el, data.placeholder);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("input.f7MessageBarBinding change.f7MessageBarBinding focus.f7MessageBarBinding blur.f7MessageBarBinding", (function(e) {
            $(el).find("#" + el.id + "-send").on("click", (function() {
                setTimeout((function() {
                    app.messagebar.get($(el)).clear().focus();
                }), 1e3);
            }));
            callback(true);
        }));
    },
    getRatePolicy: function() {
        return {
            policy: "debounce",
            delay: 250
        };
    },
    unsubscribe: function(el) {
        $(el).off(".f7MessageBarBinding");
    }
});

Shiny.inputBindings.register(f7MessageBarBinding, "f7.messagebar");

var f7MessagesBinding = new Shiny.InputBinding;

$.extend(f7MessagesBinding, {
    initialize: function(el) {
        $(".page-content").addClass("messages-content");
        var id = $(el).attr("id");
        var config = $(el).find("script[data-for='" + id + "']");
        config = JSON.parse(config.html());
        config.el = "#" + id;
        config.firstMessageRule = function(message, previousMessage, nextMessage) {
            if (message.isTitle) return false;
            if (!previousMessage || previousMessage.type !== message.type || previousMessage.name !== message.name) return true;
            return false;
        };
        config.lastMessageRule = function(message, previousMessage, nextMessage) {
            if (message.isTitle) return false;
            if (!nextMessage || nextMessage.type !== message.type || nextMessage.name !== message.name) return true;
            return false;
        };
        config.tailMessageRule = function(message, previousMessage, nextMessage) {
            if (message.isTitle) return false;
            if (!nextMessage || nextMessage.type !== message.type || nextMessage.name !== message.name) return true;
            return false;
        };
        app.messages.create(config);
    },
    find: function(scope) {
        return $(scope).find(".messages");
    },
    getValue: function(el) {
        return app.messages.get($(el)).messages;
    },
    setValue: function(el, value) {
        responseInProgress = true;
        var messages = app.messages.get($(el));
        if (value.showTyping) {
            var who = value.value.pop().name;
            setTimeout((function() {
                messages.showTyping({
                    header: who + " is typing"
                });
                setTimeout((function() {
                    messages.addMessages(value.value);
                    messages.hideTyping();
                    responseInProgress = false;
                }), 1e3);
            }), 500);
        } else {
            messages.addMessages(value.value);
        }
    },
    receiveMessage: function(el, data) {
        var responseInProgress = false;
        if (responseInProgress) return;
        this.setValue(el, data);
        $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7MessagesBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7MessagesBinding");
    }
});

Shiny.inputBindings.register(f7MessagesBinding, "f7.messages");

var f7PanelBinding = new Shiny.InputBinding;

$.extend(f7PanelBinding, {
    initialize: function(el) {
        var data = {};
        data.el = "#" + $(el).attr("id");
        data.on = {
            opened: function() {
                $(el).trigger("shown");
            }
        };
        app.panel.create(data);
    },
    find: function(scope) {
        return $(scope).find(".panel");
    },
    getValue: function(el) {
        var p = app.panel.get($(el));
        return p.opened;
    },
    receiveMessage: function(el, data) {
        var p = app.panel.get($(el));
        p.toggle(p.side);
    },
    subscribe: function(el, callback) {
        $(el).on("panel:open.f7PanelBinding panel:close.f7PanelBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7PanelBinding");
    }
});

Shiny.inputBindings.register(f7PanelBinding, "f7.panel");

var f7PickerBinding = new Shiny.InputBinding;

$.extend(f7PickerBinding, {
    initialize: function(el) {
        var inputEl = $(el)[0];
        var data = {};
        [].forEach.call(el.attributes, (function(attr) {
            if (/^data-/.test(attr.name)) {
                var camelCaseName = attr.name.substr(5).replace(/-(.)/g, (function($0, $1) {
                    return $1.toUpperCase();
                }));
                if ([ "openIn", "toolbarCloseText", "choices", "value" ].indexOf(camelCaseName) == -1) {
                    var isTrueSet = attr.value == "true";
                    data[camelCaseName] = isTrueSet;
                } else {
                    data[camelCaseName] = attr.value;
                }
            }
        }));
        data.inputEl = inputEl;
        data.value = JSON.parse(data.value);
        data.cols = [ {
            textAlign: "center",
            values: JSON.parse(data.choices)
        } ];
        var p = app.picker.create(data);
        inputEl.f7Picker = p;
    },
    find: function(scope) {
        return $(scope).find(".picker-input");
    },
    getValue: function(el) {
        var p = app.picker.get($(el));
        return p.value;
    },
    setValue: function(el, value) {
        var p = app.picker.get($(el));
        p.value = value;
        p.displayValue = value;
        p.open();
        setTimeout((function() {
            p.close();
        }), 10);
    },
    receiveMessage: function(el, data) {
        var p = app.picker.get($(el));
        if (data.hasOwnProperty("value")) {
            this.setValue(el, data.value);
        }
        if (data.hasOwnProperty("choices")) {
            p.cols[0].values = data.choices;
        }
        if (data.hasOwnProperty("rotateEffect")) {
            p.params.rotateEffect = data.rotateEffect;
        }
        if (data.hasOwnProperty("openIn")) {
            p.params.openIn = data.openIn;
        }
        if (data.hasOwnProperty("scrollToInput")) {
            p.params.scrollToInput = data.scrollToInput;
        }
        if (data.hasOwnProperty("closeByOutsideClick")) {
            p.params.closeByOutsideClick = data.closeByOutsideClick;
        }
        if (data.hasOwnProperty("toolbar")) {
            p.params.toolbar = data.toolbar;
        }
        if (data.hasOwnProperty("toolbarCloseText")) {
            p.params.toolbarCloseText = data.toolbarCloseText;
        }
        if (data.hasOwnProperty("sheetSwipeToClose")) {
            p.params.sheetSwipeToClose = data.sheetSwipeToClose;
        }
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7PickerBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7PickerBinding");
    }
});

Shiny.inputBindings.register(f7PickerBinding, "f7.picker");

var f7PopupBinding = new Shiny.InputBinding;

$.extend(f7PopupBinding, {
    initialize: function(el) {
        var config = $(el).find("script[data-for='" + el.id + "']");
        config = JSON.parse(config.html());
        config.el = el;
        config.on = {
            opened: function() {
                $(el).trigger("shown");
            }
        };
        var p = app.popup.create(config);
    },
    find: function(scope) {
        return $(scope).find(".popup");
    },
    getValue: function(el) {
        return app.popup.get($(el)).opened;
    },
    receiveMessage: function(el, data) {
        var p = app.popup.get($(el));
        if (p.opened) {
            p.close();
        } else {
            p.open();
        }
    },
    subscribe: function(el, callback) {
        $(el).on("popup:opened.f7PopupBinding popup:closed.f7PopupBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7PopupBinding");
    }
});

Shiny.inputBindings.register(f7PopupBinding, "f7.popup");

let $escape = Shiny.$escape;

function updateLabel(labelTxt, labelNode) {
    if (typeof labelTxt === "undefined") return;
    if (labelNode.length !== 1) {
        throw new Error("labelNode must be of length 1");
    }
    var emptyLabel = $.isArray(labelTxt) && labelTxt.length === 0;
    if (emptyLabel) {
        labelNode.addClass("shiny-label-null");
    } else {
        labelNode.text(labelTxt);
        labelNode.removeClass("shiny-label-null");
    }
}

var radioInputBinding = new Shiny.InputBinding;

$.extend(radioInputBinding, {
    find: function(scope) {
        return $(scope).find(".shiny-input-radiogroup");
    },
    getValue: function(el) {
        var checked_items = $('input:radio[name="' + $escape(el.id) + '"]:checked');
        if (checked_items.length === 0) {
            return null;
        }
        return checked_items.val();
    },
    setValue: function(el, value) {
        if ($.isArray(value) && value.length === 0) {
            $('input:radio[name="' + $escape(el.id) + '"]').prop("checked", false);
        } else {
            $('input:radio[name="' + $escape(el.id) + '"][value="' + $escape(value) + '"]').prop("checked", true);
        }
    },
    getState: function(el) {
        var $objs = $('input:radio[name="' + $escape(el.id) + '"]');
        var options = new Array($objs.length);
        for (var i = 0; i < options.length; i++) {
            options[i] = {
                value: $objs[i].value,
                label: this._getLabel($objs[i])
            };
        }
        return {
            label: this._getLabelNode(el).text(),
            value: this.getValue(el),
            options: options
        };
    },
    receiveMessage: function(el, data) {
        var $el = $(el);
        if (data.hasOwnProperty("options")) {
            $el.find("ul").remove();
            $el.append(data.options);
        }
        if (data.hasOwnProperty("value")) this.setValue(el, data.value);
        updateLabel(data.label, this._getLabelNode(el));
        $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        $(el).on("change.radioInputBinding", (function(event) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".radioInputBinding");
    },
    _getLabelNode: function(el) {
        return $(el).siblings("div.block-title");
    },
    _getLabel: function(obj) {
        if (obj.parentNode.tagName === "LABEL") {
            return $(obj.parentNode).find("div.item-title").text().trim();
        }
        return null;
    },
    _setLabel: function(obj, value) {
        if (obj.parentNode.tagName === "LABEL") {
            $(obj.parentNode).find("div.item-title").text(value);
        }
        return null;
    }
});

Shiny.inputBindings.register(radioInputBinding, "shiny.radioInput");

var f7SelectBinding = new Shiny.InputBinding;

$.extend(f7SelectBinding, {
    find: function(scope) {
        return $(scope).find(".input-select");
    },
    getValue: function(el) {
        return $(el).val();
    },
    setValue: function(el, value) {
        $(el).val(value);
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("selected")) {
            this.setValue(el, data.selected);
        }
        $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7SelectBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7SelectBinding");
    }
});

Shiny.inputBindings.register(f7SelectBinding, "f7.select");

var f7SheetBinding = new Shiny.InputBinding;

$.extend(f7SheetBinding, {
    initialize: function(el) {
        var id = $(el).attr("id");
        var data = {};
        [].forEach.call(el.attributes, (function(attr) {
            if (/^data-/.test(attr.name)) {
                var camelCaseName = attr.name.substr(5).replace(/-(.)/g, (function($0, $1) {
                    return $1.toUpperCase();
                }));
                var isTrueSet = attr.value == "true";
                data[camelCaseName] = isTrueSet;
            }
        }));
        data.el = "#" + id;
        data.on = {
            opened: function() {
                $(el).trigger("shown");
            }
        };
        var s = app.sheet.create(data);
    },
    find: function(scope) {
        return $(scope).find(".sheet-modal");
    },
    getValue: function(el) {
        var s = app.sheet.get($(el));
        return s.opened;
    },
    receiveMessage: function(el, data) {
        var s = app.sheet.get($(el));
        if (s.opened) {
            s.close();
        } else {
            s.open();
        }
    },
    subscribe: function(el, callback) {
        $(el).on("sheet:open.f7SheetBinding sheet:close.f7SheetBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7SheetBinding");
    }
});

Shiny.inputBindings.register(f7SheetBinding, "f7.sheet");

var f7SliderBinding = new Shiny.InputBinding;

$.extend(f7SliderBinding, {
    initialize: function(el) {
        var id = $(el).attr("id");
        var data = {};
        [].forEach.call(el.attributes, (function(attr) {
            if (/^data-/.test(attr.name)) {
                var camelCaseName = attr.name.substr(5).replace(/-(.)/g, (function($0, $1) {
                    return $1.toUpperCase();
                }));
                if ([ "min", "max", "step", "value", "scaleSteps", "scaleSubSteps", "valueLeft", "valueRight" ].indexOf(camelCaseName) == -1) {
                    var isTrueSet = attr.value == "true";
                    data[camelCaseName] = isTrueSet;
                } else {
                    data[camelCaseName] = parseFloat(attr.value);
                }
            }
        }));
        data.el = "#" + id;
        var r = app.range.create(data);
    },
    find: function(scope) {
        return $(scope).find(".range-slider");
    },
    getValue: function(el) {
        return app.range.get($(el)).value;
    },
    setValue: function(el, value) {
        app.range.setValue(el, value);
    },
    receiveMessage: function(el, data) {
        var r = app.range.get($(el));
        if (data.hasOwnProperty("min")) {
            r.min = data.min;
            r.updateScale();
        }
        if (data.hasOwnProperty("max")) {
            r.max = data.max;
            r.updateScale();
        }
        if (data.hasOwnProperty("step")) {
            r.step = data.step;
            r.updateScale();
        }
        if (data.hasOwnProperty("scaleSteps")) {
            r.scaleSteps = data.scaleSteps;
            r.updateScale();
        }
        if (data.hasOwnProperty("scaleSubSteps")) {
            r.scaleSubSteps = data.scaleSubSteps;
            r.updateScale();
        }
        if (data.hasOwnProperty("scale")) {
            r.scale = data.scale;
        }
        if (data.hasOwnProperty("value")) {
            var val = data.value;
            if ($.isArray(val)) {
                this.setValue(el, val);
            } else {
                r.dual = false;
                r.updateScale();
                this.setValue(el, val);
            }
        }
        if (data.hasOwnProperty("color")) {
            $(el).removeClass((function(index, className) {
                return (className.match(/(^|\s)color-\S+/g) || []).join(" ");
            }));
            $(el).addClass("color-" + data.color);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("range:change.f7SliderBinding", (function(e) {
            callback(true);
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7SliderBinding");
    },
    getRatePolicy: function() {
        return {
            policy: "debounce",
            delay: 250
        };
    }
});

Shiny.inputBindings.register(f7SliderBinding, "f7.range");

var f7SmartSelectBinding = new Shiny.InputBinding;

$.extend(f7SmartSelectBinding, {
    initialize: function(el) {
        var id = $(el).children().eq(0).attr("id");
        var config = $(el).children().eq(2);
        config = JSON.parse(config.html());
        config.el = "#" + id;
        var ss = app.smartSelect.create(config);
        this["smart-select-" + el.id] = ss;
    },
    find: function(scope) {
        return $(scope).find(".smart-select");
    },
    getValue: function(el) {
        return this["smart-select-" + el.id].getValue();
    },
    setValue: function(el, value) {
        this["smart-select-" + el.id].setValue(value);
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("config")) {
            this["smart-select-" + el.id].destroy();
            data.config.el = "#" + $(el).children().eq(0).attr("id");
            this["smart-select-" + el.id] = app.smartSelect.create(data.config);
        }
        if (data.hasOwnProperty("multiple")) {
            if (data.multiple) {
                this["smart-select-" + el.id].destroy();
                $(el).find("select").attr("multiple", "");
                data.config.el = "#" + $(el).children().eq(0).attr("id");
                this["smart-select-" + el.id] = app.smartSelect.create(data.config);
            }
        }
        if (data.hasOwnProperty("maxLength")) {
            this["smart-select-" + el.id].destroy();
            $(el).find("select").attr("maxLength", data.maxLength);
            data.config.el = "#" + $(el).children().eq(0).attr("id");
            this["smart-select-" + el.id] = app.smartSelect.create(data.config);
        }
        var setOption = function(value) {
            return "<option value = '" + value + "'>" + value + "</option>";
        };
        if (data.hasOwnProperty("choices")) {
            $(el).find("select").empty();
            $.each(data.choices, (function(index) {
                var temp = data.choices[index];
                $(el).find("select").append(setOption(temp));
            }));
        }
        if (data.hasOwnProperty("selected")) {
            this.setValue(el, data.selected);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7SmartSelectBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7SmartSelectBinding");
    }
});

Shiny.inputBindings.register(f7SmartSelectBinding, "f7.smartselect");

var f7StepperBinding = new Shiny.InputBinding;

$.extend(f7StepperBinding, {
    initialize: function(el) {
        var id = $(el).attr("id");
        var data = {};
        [].forEach.call(el.attributes, (function(attr) {
            if (/^data-/.test(attr.name)) {
                var camelCaseName = attr.name.substr(5).replace(/-(.)/g, (function($0, $1) {
                    return $1.toUpperCase();
                }));
                if ([ "min", "max", "step", "value", "decimalPoint" ].indexOf(camelCaseName) == -1) {
                    var isTrueSet = attr.value == "true";
                    data[camelCaseName] = isTrueSet;
                } else {
                    data[camelCaseName] = parseFloat(attr.value);
                }
            }
        }));
        data.el = "#" + id;
        var s = app.stepper.create(data);
        if (!data.manualInputMode) {
            var inputTarget = $(el).find("input");
            $(inputTarget).attr("readonly", "");
        }
    },
    find: function(scope) {
        return $(scope).find(".stepper");
    },
    getValue: function(el) {
        return app.stepper.get($(el)).value;
    },
    setValue: function(el, value) {
        app.stepper.setValue(el, value);
    },
    increment: function() {
        app.stepper.increment();
    },
    decrement: function() {
        app.stepper.decrement();
    },
    receiveMessage: function(el, data) {
        var s = app.stepper.get($(el));
        if (data.hasOwnProperty("min")) {
            s.min = data.min;
            s.params.min = data.min;
        }
        if (data.hasOwnProperty("max")) {
            s.max = data.max;
            s.params.max = data.max;
        }
        if (data.hasOwnProperty("wraps")) {
            s.params.wraps = data.wraps;
        }
        if (data.hasOwnProperty("decimalPoint")) {
            s.decimalPoint = data.decimalPoint;
            s.params.decimalPoint = data.decimalPoint;
        }
        if (data.hasOwnProperty("manual")) {
            s.params.manualInputMode = data.manual;
            var inputTarget = $(el).find("input");
            if (data.manual) {
                if (typeof $(inputTarget).attr("readonly") !== typeof undefined) {
                    $(inputTarget).removeAttr("readonly");
                }
            } else {
                $(inputTarget).attr("readonly", "");
            }
        }
        if (data.hasOwnProperty("step")) {
            s.step = data.step;
            s.params.step = data.step;
        }
        if (data.hasOwnProperty("autorepeat")) {
            s.params.autorepeat = data.autorepeat;
            s.params.autorepeatDynamic = data.autorepeat;
        }
        if (data.hasOwnProperty("rounded")) {
            if (data.rounded) {
                $(el).addClass("stepper-round");
            } else {
                $(el).removeClass("stepper-round");
            }
        }
        if (data.hasOwnProperty("raised")) {
            if (data.raised) {
                $(el).addClass("stepper-raised");
            } else {
                $(el).removeClass("stepper-raised");
            }
        }
        if (data.hasOwnProperty("color")) {
            $(el).removeClass((function(index, className) {
                return (className.match(/(^|\s)color-\S+/g) || []).join(" ");
            }));
            $(el).addClass("color-" + data.color);
        }
        if (data.hasOwnProperty("size")) {
            if ($(el).hasClass("stepper-small") || $(el).hasClass("stepper-large")) {
                if ($(el).hasClass("stepper-small") && data.size == "large") {
                    $(el).removeClass("stepper-small");
                    $(el).addClass("stepper-large");
                } else if ($(el).hasClass("stepper-large") && data.size == "small") {
                    $(el).addClass("stepper-small");
                    $(el).removeClass("stepper-large");
                }
            } else {
                if (data.size == "small") {
                    $(el).addClass("stepper-small");
                } else if (data.size == "large") {
                    $(el).addClass("stepper-large");
                }
            }
        }
        if (data.hasOwnProperty("value")) {
            this.setValue(el, data.value);
            s.params.value = data.value;
        }
    },
    subscribe: function(el, callback) {
        $(el).on("stepper:change.f7StepperBinding", (function(e) {
            var s = app.stepper.get($(el));
            if (s.params.autorepeat) {
                callback(true);
            } else {
                callback();
            }
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7StepperBinding");
    },
    getRatePolicy: function() {
        return {
            policy: "debounce",
            delay: 500
        };
    }
});

Shiny.inputBindings.register(f7StepperBinding, "f7.stepper");

var f7TabsBinding = new Shiny.InputBinding;

$.extend(f7TabsBinding, {
    find: function(scope) {
        return $(scope).find(".tabs");
    },
    getValue: function(el) {
        var activeTab;
        if ($(el).hasClass("standalone")) {
            activeTab = $(el).find(".tab-active");
        } else {
            activeTab = $(el).find(".page-content.tab-active");
        }
        if ($(activeTab).data("hidden")) {
            $(".tab-link-highlight").hide();
        } else {
            $(".tab-link-highlight").show();
        }
        return $(activeTab).attr("data-value");
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("selected")) {
            app.tab.show("#" + data.ns + "-" + data.selected);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("tab:show.f7TabsBinding", (function(e) {
            $(el).trigger("shown");
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7TabsBinding");
    }
});

Shiny.inputBindings.register(f7TabsBinding, "f7.tabs");

var f7ToggleBinding = new Shiny.InputBinding;

$.extend(f7ToggleBinding, {
    initialize: function(el) {
        app.toggle.create({
            el: el
        });
    },
    find: function(scope) {
        return $(scope).find(".toggle");
    },
    getValue: function(el) {
        return app.toggle.get($(el)).checked;
    },
    setValue: function(el, value) {
        var t = app.toggle.get($(el));
        t.checked = value;
    },
    receiveMessage: function(el, data) {
        if (data.hasOwnProperty("checked")) {
            this.setValue(el, data.checked);
        }
        if (data.hasOwnProperty("color")) {
            $(el).removeClass((function(index, className) {
                return (className.match(/(^|\s)color-\S+/g) || []).join(" ");
            }));
            $(el).addClass("color-" + data.color);
        }
    },
    subscribe: function(el, callback) {
        $(el).on("toggle:change.f7ToggleBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7ToggleBinding");
    }
});

Shiny.inputBindings.register(f7ToggleBinding, "f7.toggle");

var f7VirtualListBinding = new Shiny.InputBinding;

$.extend(f7VirtualListBinding, {
    decodeHTML: function(html) {
        var txt = document.createElement("textarea");
        txt.innerHTML = html;
        return txt.value;
    },
    initialize: function(el) {
        var id = $(el).attr("id");
        var config = $(el).find("script[data-for='" + id + "']");
        config = JSON.parse(config.html());
        config.el = "#" + id;
        for (var item of config.items) {
            if (item.media.length > 0) {
                item.media = '<div class="item-media">' + this.decodeHTML(item.media) + "</div>";
            }
        }
        var template;
        if (config.items[0].url === undefined) {
            template = "<li>" + '<div class="item-content">' + "{{media}}" + '<div class="item-inner">' + '<div class="item-title-row">' + '<div class="item-title">' + '<div class="item-header">{{header}}</div>' + "{{title}}" + '<div class="item-footer">{{footer}}</div>' + "</div>" + '<div class="item-after">{{right}}</div>' + "</div>" + '<div class="item-subtitle">{{subtitle}}</div>' + '<div class="item-text">{{content}}</div>' + "</div>" + "</div>" + "</li>";
        } else {
            template = "<li>" + '<a class="item-link item-content external" href="url" target="_blank">' + "{{media}}" + '<div class="item-inner">' + '<div class="item-title-row">' + '<div class="item-title">' + '<div class="item-header">{{header}}</div>' + "{{title}}" + '<div class="item-footer">{{footer}}</div>' + "</div>" + '<div class="item-after">{{right}}</div>' + "</div>" + '<div class="item-subtitle">{{subtitle}}</div>' + '<div class="item-text">{{content}}</div>' + "</div>" + "</a>" + "</li>";
        }
        config.itemTemplate = template;
        config.searchAll = function(query, items) {
            var found = [];
            for (var i = 0; i < items.length; i++) {
                if (items[i].title.toLowerCase().indexOf(query.toLowerCase()) >= 0 || query.trim() === "") found.push(i);
            }
            return found;
        };
        config.height = config.items[0].media !== undefined ? app.theme === "ios" ? 112 : app.theme === "md" ? 132 : 78 : app.theme === "ios" ? 63 : app.theme === "md" ? 73 : 46;
        app.virtualList.create(config);
    },
    find: function(scope) {
        return $(scope).find(".virtual-list");
    },
    getValue: function(el) {
        var vl = app.virtualList.get($(el));
        return {
            length: vl.items.length,
            current_from: vl.currentFromIndex + 1,
            current_to: vl.currentToIndex + 1,
            reach_end: vl.reachEnd
        };
    },
    setValue: function(el, value) {
        var vl = app.virtualList.get($(el));
        vl.resetFilter();
        var addImageWrapper = function(items) {
            var temp;
            if (items.length === undefined) {
                temp = `<div class="item-media">${items.media}</div>`;
                items.media = temp;
            } else {
                for (var i = 0; i < items.length; i++) {
                    temp = `<div class="item-media">${items[i].media}</div>`;
                    items[i].media = temp;
                }
            }
            return items;
        };
        switch (value.action) {
          case "appendItem":
            vl.appendItem(addImageWrapper(value.item));
            break;

          case "prependItem":
            vl.prependItem(addImageWrapper(value.item));
            break;

          case "appendItems":
            vl.appendItems(addImageWrapper(value.items));
            break;

          case "prependItems":
            vl.prependItems(addImageWrapper(value.items));
            break;

          case "replaceItem":
            vl.replaceItem(value.index, value.item);
            break;

          case "replaceAllItems":
            vl.replaceAllItems(value.items);
            break;

          case "moveItem":
            vl.moveItem(value.oldIndex, value.newIndex);
            break;

          case "insertItemBefore":
            vl.insertItemBefore(value.index, addImageWrapper(value.item));
            break;

          case "filterItems":
            vl.filterItems(value.indexes);
            break;

          case "deleteItem":
            vl.deleteItem(value.index);
            break;

          case "deleteAllItems":
            vl.deleteAllItems(value.indexes);
            break;

          case "scrollToItem":
            vl.scrollToItem(value.index);
            break;

          default:
        }
        $(el).trigger("change");
    },
    receiveMessage: function(el, data) {
        this.setValue(el, data);
    },
    subscribe: function(el, callback) {
        $(el).on("change.f7VirtualListBinding", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".f7VirtualListBinding");
    }
});

Shiny.inputBindings.register(f7VirtualListBinding, "f7.virtuallist");
