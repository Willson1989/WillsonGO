/**
 * Created by willhelen on 2017/11/3.
 */

import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
    TouchableOpacity,
} from 'react-native'

import { StackNavigator } from 'react-navigation'
import LoginPage from './Account/LoginPage.js'

var UIUtil = require('../Common/UIUtil')

class MorePage extends React.Component {

    static navigationOptions = ({navigation}) => UIUtil.navOptions(navigation,'我的', false)

    constructor(props) {
        super(props)
    }

    render() {
        console.log('MorePage   reender')

        return (
            <View>
                <Text>{'This is More page'}</Text>
                <TouchableOpacity onPress={() => {
                    UIUtil.navigate(this.props.navigation,'login',true)
                }}>
                    <Text>{'去登录'}</Text>
                </TouchableOpacity>
            </View>
        )
    }

}

const MoreNavigator = StackNavigator({
    more : {
        screen : MorePage,
    },
    login : {
        screen : LoginPage,
    }
})

export  { MoreNavigator }