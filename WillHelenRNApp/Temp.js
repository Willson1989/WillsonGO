/**
 * Created by willhelen on 2017/10/27.
 */
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    Platform,
    StyleSheet,
    Text,
    View
} from 'react-native';

const instructions = Platform.select({
    ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
    android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component<{}> {

    constructor(props) {
        super(props)
        this.state = {
            tapTimes : 0
        }
    }

    componentWillMount() {
        console.log('componentWillMount')
    }

    componentDidMount() {
        console.log('componentDidMount')
    }

    shouldComponentUpdate() {
        console.log('shouldComponentUpdate')
        return true
    }

    componentWillUpdate() {
        console.log('componentWillUpdate')

    }


    componentDidUpdate() {
        console.log('componentDidUpdate')
    }

    componentWillUnmount() {
        console.log('componentWillUnmount')
    }



    pressAction() {
        let times = this.state.tapTimes
        times ++
        this.setState({
            tapTimes:times
        })
    }

    render() {
        console.log('render')
        return (
            <View style={styles.container}>
                <Text style={styles.welcome} onPress={this.pressAction.bind(this)}>
                    点一下试试
                </Text>
                <Text style={styles.instructions}>
                    {'点击了' + this.state.tapTimes + '次'}
                </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});
