"use strict";

function _typeof(t) {
    return (_typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(t) {
        return typeof t
    } : function(t) {
        return t && "function" == typeof Symbol && t.constructor === Symbol && t !== Symbol.prototype ? "symbol" : typeof t
    })(t)
}

function _classCallCheck(t, e) {
    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
}

function _defineProperties(t, e) {
    for (var i = 0; i < e.length; i++) {
        var n = e[i];
        n.enumerable = n.enumerable || !1, n.configurable = !0, "value" in n && (n.writable = !0), Object.defineProperty(t, n.key, n)
    }
}

function _createClass(t, e, i) {
    return e && _defineProperties(t.prototype, e), i && _defineProperties(t, i), t
}
var MaterialDatepicker = function() {
    function c(t, e) {
        _classCallCheck(this, c);
        var i = {
            type: "date",
            lang: "en",
            orientation: "landscape",
            color: "rgba(0, 150, 136, 1)",
            theme: "light",
            zIndex: "100",
            position: null,
            openOn: "click",
            closeAfterClick: !0,
            date: new Date,
            weekBegin: "sunday",
            outputFormat: {
                date: "YYYY/MM/DD",
                month: "MMMM YYYY"
            },
            topHeaderFormat: "YYYY",
            headerFormat: {
                date: "ddd, MMM D",
                month: "MMM"
            },
            sitePickerFormat: {
                date: "MMMM YYYY",
                month: "YYYY"
            },
            onLoad: null,
            onOpen: null,
            onNewDate: null,
            onChange: null,
            outputElement: ""
        };
        if (this.settings = Object.assign(i, e), moment.locale(this.settings.lang), "object" == _typeof(this.settings.topHeaderFormat) && (this.settings.topHeaderFormat = this.settings.topHeaderFormat[this.settings.type]), "object" == _typeof(this.settings.headerFormat) && (this.settings.headerFormat = this.settings.headerFormat[this.settings.type]), "object" == _typeof(this.settings.outputFormat) && (this.settings.outputFormat = this.settings.outputFormat[this.settings.type]), "object" == _typeof(this.settings.sitePickerFormat) && (this.settings.sitePickerFormat = this.settings.sitePickerFormat[this.settings.type]), this.element = t, "string" != typeof this.element || (this.element = document.querySelector("".concat(t)), null != this.element)) {
            var n = this.element.tagName,
                s = (this.element.getAttribute("type"), "");
            "INPUT" == n ? s = this.element.value : "DIV" == n || "A" == n || "SPAN" == n || "P" == n ? 0 == this.element.children && (s = this.element.innerHTML) : "PAPER-INPUT" == n && (s = this.element.value);
            var a = moment(s, this.settings.outputFormat);
            this.date = this.settings.date, a.isValid() && (this.date = a.toDate()), "string" == typeof this.settings.outputElement && "" != this.settings.outputElement && (this.settings.outputElement = document.querySelector("".concat(this.settings.outputElement))), this._writeInElement(), this._define()
        } else console.warn('Material Datepicker could not initialize because, Object: "'.concat(t, '" is not defined'))
    }
    return _createClass(c, [{
        key: "_define",
        value: function() {
            var n = this;
            this._createElement(), "direct" != this.settings.openOn ? (this.element.addEventListener(this.settings.openOn, function() {
                n.open(n.settings.openOn)
            }), "direct" != this.settings.openOn && (document.addEventListener("keyup", function(t) {
                9 == t.keyCode && (document.activeElement == n.element ? n.open() : n.close())
            }), document.addEventListener("keyup", function(t) {
                var e = n.element.value,
                    i = moment(e, n.settings.outputFormat).toDate();
                n.newDate(i, "", !1)
            }), document.addEventListener("mouseup", function(t) {
                -1 == n._getPath(t).indexOf(n.picker) && n.close()
            }))) : this.open(this.settings.openOn)
        }
    }, {
        key: "_createElement",
        value: function(t) {
            var e = this,
                i = (new Date).getTime() + Math.round(Math.random() + 2);
            this.picker = document.createElement("div"), this.picker.setAttribute("class", "mp-".concat(this.settings.type, "picker mp-picker")), this.picker.setAttribute("id", "mp-".concat(i)), this.picker.setAttribute("data-theme", this.settings.theme), this.picker.setAttribute("data-orientation", this.settings.orientation);
            var n = document.createElement("div");
            n.setAttribute("class", "mp-picker-info"), this.picker.appendChild(n);
            var s = document.createElement("div");
            s.setAttribute("class", "mp-picker-picker"), this.picker.appendChild(s);
            var a = document.createElement("span");
            a.setAttribute("class", "mp-info-first"), n.appendChild(a);
            var c = document.createElement("span");
            c.setAttribute("class", "mp-info-second"), n.appendChild(c);
            var o = document.createElement("div");
            o.setAttribute("class", "mp-picker-site"), s.appendChild(o);
            var r = document.createElement("a");
            r.setAttribute("class", "mp-picker-site-before mp-picker-site-button"), o.appendChild(r), r.addEventListener("click", function() {
                e._siteChange(-1)
            });
            var l = document.createElement("span");
            l.setAttribute("class", "mp-picker-site-this mp-animate"), o.appendChild(l);
            var p = document.createElement("a");
            p.setAttribute("class", "mp-picker-site-next mp-picker-site-button"), o.appendChild(p), p.addEventListener("click", function() {
                e._siteChange(1)
            });
            var m = document.createElement("div");
            m.setAttribute("class", "mp-picker-choose mp-animate"), s.appendChild(m);
            var h = "\n      #mp-".concat(i, '.mp-picker:not([data-theme="dark"]) .mp-picker-info {\n        background-color: ').concat(this.settings.color, ";\n      }\n\n      #mp-").concat(i, '.mp-picker .mp-picker-choose [class*="mp-picker-click"].active,\n      #mp-').concat(i, '.mp-picker[data-theme="dark"] .mp-picker-choose [class*="mp-picker-click"].active {\n        background-color: ').concat(this.settings.color, ";\n      }\n\n      #mp-").concat(i, '.mp-picker .mp-picker-choose [class*="mp-picker-click"].today:not(.active),\n      #mp-').concat(i, '.mp-picker[data-theme="dark"] .mp-picker-choose .mp-picker-choose [class*="mp-picker-click"].today:not(.active) {\n        color: ').concat(this.settings.color, ";\n      }\n    "),
                d = document.createElement("style");
            d.type = "text/css", d.appendChild(document.createTextNode(h)), document.querySelector("head").appendChild(d), this.draw(), this.callbackOnLoad()
        }
    }, {
        key: "draw",
        value: function() {
            var a = this,
                c = this.picker.querySelector(".mp-picker-choose");
            if (c.innerHTML = "", this.picker.querySelector(".mp-info-first").innerHTML = moment(this.date).format(this.settings.topHeaderFormat), this.picker.querySelector(".mp-info-second").innerHTML = moment(this.date).format(this.settings.headerFormat), this.picker.querySelector(".mp-picker-site-this").innerHTML = moment(this.date).format(this.settings.sitePickerFormat), null != this.picker.querySelector('[class*="mp-picker-click"].active') && this.picker.querySelector('[class*="mp-picker-click"].active').classList.remove("active"), "date" == this.settings.type) {
                for (var t = 0; t < 7; t++) {
                    var e = t;
                    "monday" == this.settings.weekBegin && 7 <= (e += 1) && (e = 0);
                    var i = document.createElement("span");
                    i.setAttribute("class", "mp-picker-header mp-picker-header-day-".concat(t)), i.innerHTML = moment.weekdaysMin()[e].substr(0, 1), c.appendChild(i)
                }
                var o = this.date.getTime();
                (o = new Date(o)).setDate(1), o.setMonth(o.getMonth() + 1), o.setDate(0);
                var r = o;
                o = o.getDate(), r.setDate(1), r = 0 === (r = r.getDay()) ? 7 : r;
                for (var n = function(i, t) {
                        if (o < i) return l = i, "break";
                        var n = moment(new Date(a.date.toISOString()).setDate(i)).format("D"),
                            e = document.createElement("a");
                        e.setAttribute("class", "mp-picker-choose-day");
                        var s = r <= t;
                        "monday" === a.settings.weekBegin && (s = r <= t + 1), s && i <= o ? (e.innerHTML = n, e.classList.add("mp-picker-click-".concat(n)), i++) : (e.innerHTML = " ", e.classList.add("mp-empty")), c.appendChild(e), e.addEventListener("click", function(t) {
                            if (a._getPath(t)[0].classList.contains("mp-empty")) l = i;
                            else {
                                var e = moment(a.date).date(1 * n).toDate();
                                "direct" != a.settings.openOn && a.settings.closeAfterClick ? a.newDate(e, "close") : a.newDate(e)
                            }
                        }), l = i
                    }, s = 0, l = 1; s < 42; s++) {
                    if ("break" === n(l, s)) break
                }
                moment(this.date);
                (new Date).getYear() == this.date.getYear() && (new Date).getMonth() == this.date.getMonth() ? this.picker.querySelector(".mp-picker-click-".concat(moment().format("D"))).classList.add("today") : null != this.picker.querySelector(".mp-picker-click-".concat(1 * (new Date).getMonth(), ".today")) && this.picker.querySelector(".mp-picker-click-".concat(moment().format("D"), ".today")).classList.remove("today"), this.picker.querySelector(".mp-picker-click-".concat(moment(this.date).format("D"))).classList.add("active")
            } else if ("month" == this.settings.type) {
                for (var p = function(i) {
                        var t = document.createElement("a");
                        t.setAttribute("class", "mp-picker-click-".concat(i, " mp-picker-choose-month")), t.innerHTML = moment.monthsShort("-MMM-")[i].replace(".", ""), c.appendChild(t), t.addEventListener("click", function() {
                            var t = i,
                                e = a.date;
                            e.setMonth(t), "direct" != a.settings.openOn && a.settings.closeAfterClick ? a.newDate(e, "close") : a.newDate(e)
                        })
                    }, m = 0; m < 12; m++) p(m);
                (new Date).getYear() == this.date.getYear() ? this.picker.querySelector(".mp-picker-click-".concat(1 * (new Date).getMonth())).classList.add("today") : null != this.picker.querySelector(".mp-picker-click-".concat(1 * (new Date).getMonth(), ".today")) && this.picker.querySelector(".mp-picker-click-".concat(1 * (new Date).getMonth(), ".today")).classList.remove("today"), this.picker.querySelector(".mp-picker-click-".concat(1 * this.date.getMonth())).classList.add("active")
            }
        }
    }, {
        key: "_siteChange",
        value: function(t) {
            var e = this,
                i = {
                    "-1": "left",
                    1: "right"
                },
                n = {
                    "-1": "right",
                    1: "left"
                };
            "date" == this.settings.type ? this.date = moment(this.date).add(t, "month").toDate() : "month" == this.settings.type && (this.date = moment(this.date).add(t, "year").toDate()), this.picker.querySelectorAll(".mp-animate")[0].classList.add("mp-animate-".concat(n[t])), this.picker.querySelectorAll(".mp-animate")[1].classList.add("mp-animate-".concat(n[t])), setTimeout(function() {
                e.picker.querySelectorAll(".mp-animate")[0].classList.remove("mp-animate-".concat(n[t])), e.picker.querySelectorAll(".mp-animate")[0].classList.add("mp-animate-".concat(i[t])), e.picker.querySelectorAll(".mp-animate")[1].classList.remove("mp-animate-".concat(n[t])), e.picker.querySelectorAll(".mp-animate")[1].classList.add("mp-animate-".concat(i[t])), e.draw(), setTimeout(function() {
                    e.picker.querySelectorAll(".mp-animate")[0].classList.remove("mp-animate-".concat(i[t])), e.picker.querySelectorAll(".mp-animate")[1].classList.remove("mp-animate-".concat(i[t])), e.newDate(e.date)
                }, 200)
            }, 200)
        }
    }, {
        key: "open",
        value: function(t) {
            if ("direct" == t && "DIV" == this.element.tagName) this.element.appendChild(this.picker);
            else {
                var e = this.element.tagName,
                    i = this.element.getAttribute("type"),
                    n = this.element.value;
                ("INPUT" != e || "date" != i && "number" != i && "text" != i) && "PAPER-INPUT" != e || "" == n || (this.date = moment(n, this.settings.outputFormat).toDate()), document.body.appendChild(this.picker);
                var s = this._findTotalOffset(this.element),
                    a = s.top + s.height + 10,
                    c = s.left,
                    o = o = Math.max(document.documentElement.clientWidth, window.innerWidth || 0),
                    r = r = Math.max(document.documentElement.clientHeight, window.innerHeight || 0),
                    l = this._findTotalOffset(this.picker);
                c + l.width + 50 > o && (c = c - l.width - 10), a + l.height + 20 > r && (a = a - l.height - s.height - 10), this.picker.style.top = "".concat(a, "px"), this.picker.style.left = "".concat(c, "px")
            }
            this.picker.style.zIndex = this.settings.zIndex, null != this.settings.position && (this.picker.style.position = this.settings.position), this.newDate(null), this.callbackOnOpen()
        }
    }, {
        key: "close",
        value: function() {
            this.picker && this.picker.parentNode && this.picker.parentNode.removeChild(this.picker)
        }
    }, {
        key: "_writeInElement",
        value: function() {
            var t = moment(this.date).format(this.settings.outputFormat);
            ("INPUT" == this.element.tagName && "text" == this.element.getAttribute("type") || "DIV" == this.element.tagName || "PAPER-INPUT" == this.element.tagName) && (this.element.value = t), this.settings.outputElement && "INPUT" != this.settings.outputElement.tagName && (this.settings.outputElement.innerHTML = t)
        }
    }, {
        key: "newDate",
        value: function(t, e, i) {
            var n = !(2 < arguments.length && void 0 !== i) || i,
                s = t || this.date;
            isNaN(s.valueOf()) && (s = this.settings.date), s.setMilliseconds(0), s.setSeconds(0), s.setMinutes(0), s.setHours(0), this.date = s, this.draw(), n && this._writeInElement(), this.callbackOnChange(), "close" == e && (this.close(), this.callbackOnNewDate())
        }
    }, {
        key: "callbackOnLoad",
        value: function() {
            "function" == typeof this.settings.onLoad && this.settings.onLoad.call(this, this.date)
        }
    }, {
        key: "callbackOnOpen",
        value: function() {
            "function" == typeof this.settings.onOpen && this.settings.onOpen.call(this, this.date)
        }
    }, {
        key: "callbackOnNewDate",
        value: function() {
            "function" == typeof this.settings.onNewDate && this.settings.onNewDate.call(this, this.date)
        }
    }, {
        key: "callbackOnChange",
        value: function() {
            "function" == typeof this.settings.onChange && this.settings.onChange.call(this, this.date)
        }
    }, {
        key: "_findTotalOffset",
        value: function(t) {
            var e, i;
            e = i = 0;
            var n = t.getBoundingClientRect();
            if (t.offsetParent)
                for (; e += t.offsetLeft, i += t.offsetTop, t = t.offsetParent;);
            return {
                left: e,
                top: i,
                height: n.height,
                width: n.width
            }
        }
    }, {
        key: "_getPath",
        value: function(t) {
            for (var e = [], i = t.target; i;) e.push(i), i = i.parentElement;
            return -1 === e.indexOf(window) && -1 === e.indexOf(document) && e.push(document), -1 === e.indexOf(window) && e.push(window), e
        }
    }]), c
}();
