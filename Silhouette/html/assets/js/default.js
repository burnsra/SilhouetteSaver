/* default.js */

(function() {
    var Silhouette;

    Silhouette = (function() {
        function Silhouette() {}

        Silhouette.prototype.start = function() {
            this.container = $('#container');
            return true;
        };
        
        return Silhouette;
    })();

    new Silhouette().start();
}).call(this);
