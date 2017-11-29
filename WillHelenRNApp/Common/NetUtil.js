

var Mock = require('mockjs')
var _    = require('lodash')
var queryString = require('query-string')
var netConfig = require('./Config.js')

var NetUtil = {}

NetUtil.get = (method , params) => {
    var url = netConfig.apiBaseUrl + method
    if (params != null) {
        url += '?' + queryString.stringify(params, '&', '=')
    }

    return fetch(url)
        .then((response) => response.json())
        .then((responseJson) => Mock.mock(responseJson))
}

NetUtil.post = (method, params) => {
    var url = netConfig.apiBaseUrl + method
    var options = _.assign(netConfig.headerParams, {
        body : JSON.stringify(params)
    })

    return fetch(url, options)
        .then((response) => response.json())
        .then((responseJson) => Mock.mock(responseJson))
}

module.exports = NetUtil