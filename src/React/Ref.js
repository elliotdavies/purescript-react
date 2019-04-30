'use strict';

var React = require("react");

exports.createRef = React.createRef;

exports.getCurrentRef_ = function(ref) {
  return ref.current;
}
