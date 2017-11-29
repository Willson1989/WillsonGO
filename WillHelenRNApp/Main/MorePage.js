/**
 * Created by willhelen on 2017/11/3.
 */

import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
} from 'react-native'



export default class MorePage extends React.Component {

    constructor(props) {
        super(props)
    }

    render() {
        console.log('MorePage   reender')

        return (
            <View>
                <Text>{'This is More page'}</Text>
            </View>
        )
    }

}