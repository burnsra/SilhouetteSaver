/* default.js */

(function() {
    var Silhouette;

    Silhouette = (function() {
        function Silhouette() {}

        Silhouette.prototype.itemSizeWidth = 11;
        Silhouette.prototype.itemSizeHeight = 13;

        Silhouette.prototype.boxes = 0;
        Silhouette.prototype.colors = ["CCCCCC", "D08D61", "59B75C", "8485BC", "94C472", "DB3C40", "B43E92", "1AACA5"];
        Silhouette.prototype.words = [":", ";", "\\", "/", "!", "?", "[", "]", "+", "-", "*", "&", "^", "(", ")", "#", "@", "&", "<", ">", "[", "]", "~", "0", "1", "%", "$"];

        Silhouette.prototype.start = function() {
            this.container = $('#container');
            this.setSize();
            this.drawBoxes();
            this.intervalShowSymbol = setInterval(this.showSymbol, 500);
            this.intervalChangeSymbol = setInterval(this.changeSymbol, 500);
            return true;
        };

        Silhouette.prototype.setSize = function() {
            var left, top;
            this.screenWidth = window.innerWidth;
            this.screenHeight = window.innerHeight;
            this.cols = Math.ceil(this.screenWidth / this.itemSizeWidth);
            if (this.cols % 2 === 1) {
                this.cols += 1;
            }
            this.rows = Math.ceil(this.screenHeight / this.itemSizeHeight);
            if (this.rows % 2 === 0) {
                this.rows += 1;
            }
            this.width = this.cols * this.itemSizeWidth;
            this.height = this.rows * this.itemSizeHeight;
            left = -(this.width - this.screenWidth) / 2;
            top = (this.height - this.screenHeight) / 2;
            return true;
        };

        Silhouette.prototype.drawBoxes = function() {
            var box, col, row, _i, _ref, _results, _color_current, _color_previous, _symbol_current, _symbol_previous;
            _results = [];
            _color_current = 1;
            _color_previous = 1;
            _symbol_current = 1;
            _symbol_previous = 1;
            for (row = _i = 1, _ref = this.rows; 1 <= _ref ? _i <= _ref : _i >= _ref; row = 1 <= _ref ? ++_i : --_i) {
                _results.push((function() {
                    var _j, _ref1, _results1;
                    _results1 = [];
                    for (col = _j = 1, _ref1 = this.cols; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; col = 1 <= _ref1 ? ++_j : --_j) {
                        box = document.createElement('div');
                        do {
                           _color_current = Math.floor(Math.random() * this.colors.length);
                           _symbol_current = Math.floor(Math.random() * this.words.length);
                        }
                        while (_color_current == _color_previous || _symbol_current == _symbol_previous);
                        _color_previous = _color_current;
                        _symbol_previous = _symbol_current;
                        box.classList.add('text');
                        box.classList.add('hidden');
                        box.innerHTML = Silhouette.prototype.words[_symbol_current];
                        box.style.color = Silhouette.prototype.colors[_color_current];
                        _results1.push(this.container.append(box));
                        Silhouette.prototype.boxes++;
                    }
                    return _results1;
                }).call(this));
            }
            return _results;
        };

        Silhouette.prototype.showSymbol = function() {
            var boxes_hidden, boxes_selection;

            boxes_hidden = $(".text.hidden").get();
            boxes_selection = boxes_hidden.sort(function(){ return Math.round(Math.random())-0.5 }).slice(0,Math.ceil(boxes_hidden.length == Silhouette.prototype.boxes ? Silhouette.prototype.boxes / 20 : (Silhouette.prototype.boxes - boxes_hidden.length) / 10));
            if ( boxes_hidden.length != 0 ) {
                $(boxes_selection).removeClass('hidden');
            }
            return true;
        };

        Silhouette.prototype.changeSymbol = function() {
            var boxes_hidden, boxes_selection;

            boxes_hidden = $(".text.hidden").get();
            if ( boxes_hidden.length == 0 ) {
                clearInterval(1);
                clearInterval(2);
                boxes_selection = $(".text:not(.changed)").get().sort(function() { return Math.round(Math.random())-0.5 }).slice(0,Math.ceil(Silhouette.prototype.boxes / 10));
                if ( boxes_selection.length == 0 ) {
                    $(".text").removeClass("changed");
                } else {
                    $(boxes_selection).each(function() {
                        $(this).addClass("changed");
                            $(this).html(Silhouette.prototype.words[Math.floor(Math.random() * Silhouette.prototype.words.length)]);
                            $(this).css("color",Silhouette.prototype.colors[Math.floor(Math.random() * Silhouette.prototype.colors.length)]);
                            /*
                            // Functionality to prevent adjacent duplicate colors
                            try {
                                do {
                                    $(this).css("color",Silhouette.prototype.colors[Math.floor(Math.random() * Silhouette.prototype.colors.length)]);
                                }
                                while ($(this).css("color") == $(this).prev().css("color") || $(this).css("color") == $(this).next().css("color"));
                            } catch(err) {
                                $(this).css("color",Silhouette.prototype.colors[Math.floor(Math.random() * Silhouette.prototype.colors.length)]);
                            }
                            // Functionality to prevent adjacent duplicate text
                            try {
                                do {
                                    $(this).html(Silhouette.prototype.words[Math.floor(Math.random() * Silhouette.prototype.words.length)]);
                                }
                                while ($(this)[0].innerText == $(this).prev()[0].innerText || $(this)[0].innerText == $(this).next()[0].innerText);
                            } catch(err) {
                                $(this).html(Silhouette.prototype.words[Math.floor(Math.random() * Silhouette.prototype.words.length)]);
                            }
                            */
                    });
                }
                setTimeout(function() {Silhouette.prototype.changeSymbol()}, 0);
            }
            return true;
        };

        return Silhouette;
    })();

    new Silhouette().start();
}).call(this);
