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

class SubView extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            times : 0
        }
    }

    componentWillReceiveProps(props) {
        console.log(props)
        this.setState({
            times : props.tapTimes
        })
    }

    subView_ResetTimes() {
        this.props.resetTimes()
    }

    render() {
        console.log('SubView','render')
        return (
            <View style={styles.containerSubView}>
                <Text style={styles.instructions}>
                    {'视图被点击了' + this.props.tapTimes + '次'}
                </Text>
                <Text style={styles.instructions} onPress={this.subView_ResetTimes.bind(this)}>
                    {'子视图重置次数'}
                </Text>
            </View>
        );
    }
}


export default class MainView extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            tapTimes : 0,
            showSubView : false
        }
    }

    pressAction() {
        let times = this.state.tapTimes
        times ++
        this.setState({
            tapTimes : times,
        })
    }

    resetTimes() {
        this.setState({
            tapTimes : 0
        })
    }

    tapToShowSubView = () => {
        this.setState({
            showSubView : !this.state.showSubView,
        })
    }

    tempTitle = 'willson'

    tempFunc(title) {
        console.log(this.tempTitle)
    }

    render() {
        console.log('mainView','render')
        return (
            <View style={styles.containerMainView}>

                {
                    this.state.showSubView
                        ? <SubView tapTimes={this.state.tapTimes}
                                   resetTimes={this.resetTimes.bind(this)}/>
                        : null
                }
                <Text style={styles.welcome} onPress={this.pressAction.bind(this)}>
                    点一下试试
                </Text>

                <Text style={styles.welcome} onPress={this.tapToShowSubView.bind(this)}>
                    {this.state.showSubView ? '隐藏子视图' : '显示子视图'}
                </Text>
                <Text style={styles.welcome} onPress={this.tempFunc.bind(this)}>
                    {'咔咔咔'}
                </Text>
                <Text style={styles.instructions}>
                    {'点击了' + this.state.tapTimes + '次'}
                </Text>
            </View>
        );
    }
}

var styles = StyleSheet.create({
    containerMainView: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },

    containerSubView: {
        // flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'green',
        height : 200,
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

