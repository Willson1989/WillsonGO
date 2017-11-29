
import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
    PanResponder,
    ProgressViewIOS,
} from 'react-native'

var Dimensions = require('Dimensions')
var screenWidth = Dimensions.get('window').width
var screenHeight = Dimensions.get('window').height

let contentPaddingHor = 20
let totalWidth = screenWidth - contentPaddingHor * 2.0



//***************************************************
//***************************************************
//***************************************************


class ProgressDemo extends Component {

    constructor(props) {
        super(props)
        this._onPanResponderGrant = this._onPanResponderGrant.bind(this)
        this._onPanResponderMove = this._onPanResponderMove.bind(this)
        this.state = {
            progress : 0.0,
            gestrueState : null,
        }
    }

    _onPanResponderGrant(e, g) {
        this._calculateProgress(g.x0)
    }

    _onPanResponderMove(e, g) {
        this._calculateProgress(g.moveX)
    }

    _calculateProgress(x) {
        var progress
        if (x < contentPaddingHor) {
            progress = 0.0
        } else if (x > screenWidth - contentPaddingHor) {
            progress = 1.0
        } else {
            progress = (x - contentPaddingHor) / totalWidth
        }
        this.setState({
            progress : progress,
        })
    }

    componentWillMount() {
        this.panResponder = PanResponder.create({
            onStartShouldSetPanResponder:(e,g) => true,
            onPanResponderGrant:this._onPanResponderGrant,
            onPanResponderMove:this._onPanResponderMove,
        })
    }

    render() {
        let p = Number(this.state.progress * 100.0).toFixed(1)
        return (
            <View style={pdStyles.container}>
                <ProgressViewIOS style={pdStyles.progress}
                                 progress={this.state.progress}
                                 progressTintColor={'#f9763f'}
                                 progressViewStyle={'bar'}/>
                <Text style={pdStyles.progressText}> {p + '%'} </Text>
                <View style={pdStyles.gestureArea} {...this.panResponder.panHandlers}></View>
            </View>
        )
    }
}

const pdStyles = StyleSheet.create({
    container : {
        flex : 1,
        position:'absolute',
        backgroundColor:'#1cffb2',
        top:30,
        height:100,
        width:screenWidth,
        flexDirection:'column',
        justifyContent:'center',
    },

    progress : {
        left : contentPaddingHor,
        marginTop : 30,
        backgroundColor : '#8f8f8f',
        width : screenWidth - contentPaddingHor * 2.0
    },

    progressText : {
        marginTop : 10,
        marginLeft : contentPaddingHor,
        color : '#4b4b4b',
        fontSize : 18,
        textAlign : 'left'
    },

    gestureArea : {
        position : 'absolute',
        width: screenWidth,
        top : 0,
        height : 100,
        backgroundColor : 'transparent',
    }
})

//***************************************************
//***************************************************
//***************************************************

export default class PanGestureDemo extends Component {

    render() {
        return (
            <View style={styles.container}>
                <ProgressDemo />
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container : {
        flex : 1,
        backgroundColor:'#fff',
        paddingTop : 30,
    },
})


