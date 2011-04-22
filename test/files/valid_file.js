var foo = function() {
};

foo.prototype = {
  addTwo: function(x) {
    return x + 2;
  }
};

// console underscore log should be valid
var console_log = function() {
};

var x = 7; // console.log in a single-line comment should be valid
