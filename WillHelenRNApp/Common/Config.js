
import React , {Component} from 'react'


var netConfig = {
    headerParams:{
        method : 'POST',
        headers : {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        },
    },
    apiBaseUrl : 'http://rapapi.org/mockjs/28487/',
    method:{
        createion : 'api/creations',
        like      : 'api/like',
        comment   : 'api/comment',
        submitComment : 'api/submitComment',
        verifyCodeLogin : 'api/verifyCodeLogin',
        getVerifyCode : 'api/getVerifyCode',
        tempTest  : 'api/tempTest'
    },
}

module.exports = netConfig
