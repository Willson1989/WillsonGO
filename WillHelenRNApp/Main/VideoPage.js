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

export default class VideoPage extends React.Component {

    constructor(props) {
        super(props)
    }

    render() {
        console.log('VideoPage   reender')

        return (
            <View>
                <Text>{'This is Video page'}</Text>
            </View>
        )
    }

}