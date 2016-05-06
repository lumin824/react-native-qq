'use strict';

var React = require('react-native');
var {
  NativeModules
} = React;

var QQAPI = NativeModules.RNQQModule || NativeModules.RNQQManager;

var login = function(scopes, callback){
  QQAPI.login(scopes, function(err, data){
    console.log(arguments);
    var obj = data;
    if(!err && data) obj = JSON.parse(data);
    callback && callback(err, obj);
  });
}

module.exports = {
  login
}
