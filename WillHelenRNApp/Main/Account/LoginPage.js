import React , {Component} from 'react'

import {
    View,
    StyleSheet,
    TextInput,
    Alert,
} from 'react-native'

import Icon from 'react-native-vector-icons/Ionicons'
import Button from 'react-native-button'

var _ = require('lodash')
var NetUtil = require('../../Common/NetUtil')
var netConfig = require('../../Common/Config')
var UIUtil = require('../../Common/UIUtil')
var Dimensions = require('Dimensions')

var screenWidth = Dimensions.get('window').width
var screenHeight = Dimensions.get('window').height

export default class LoginPage extends Component {

    static navigationOptions = ({navigation}) => UIUtil.navOptions(navigation,'快速登录', false)

    constructor(props){
        super(props)
        this.phoneNum = ''
        this.verifyCode = ''
        this.state = {
            hasSentCode : false,
        }
    }

    render() {
        return (
            <View style={styles.container}>
                <TextInput
                    onChangeText={this._phoneNumTextDidChanged.bind(this)}
                    style={styles.phoneNumInput}
                    placeholder={'输入手机号'}>
                </TextInput>
                {this._verifyCodeInputComponent()}
                {this._funcButtonComponent()}
            </View>
        )
    }


    _getVerifyCode = () => {

        if (this.phoneNum.length <= 0) {
            Alert.alert('手机号不能为空')
            return
        }
        let p = {
            phoneNum : this.phoneNum,
        }

        NetUtil.post(netConfig.method.getVerifyCode, p)
            .then((response) => {
                if (response == null) {
                    return
                }
                if (response.success != null && response.success == true) {
                    this.setState({
                        hasSentCode : true,
                    })
                }
            })
            .catch((error) => {
                console.log(error)
            })
    }

    _verifyCodeLogin = () => {
        if (this.phoneNum.length <= 0) {
            Alert.alert('手机号不能为空')
            return
        }

        if (this.verifyCode.length <= 0) {
            Alert.alert('验证码不能为空')
            return
        }

        let p = {
            phoneNum : this.phoneNum,
            verifyCode : '123456',
        }

        NetUtil.post(netConfig.method.verifyCodeLogin, p)
            .then((response) => {
                if (response == null) {
                    return
                }
                if (response.success != null && response.success == true) {
                    console.log('responsed user data : ',response.data)
                }
            })
            .catch((error) => {
                console.log(error)
            })
    }

    _phoneNumTextDidChanged(text) {
        this.phoneNum = text
    }

    _verifyCodeTextDidChanged(text) {
        this.verifyCode = text
    }

    _funcButtonComponent = () => {
        if (!this.state.hasSentCode) {
            return (
                <Button
                    containerStyle={[styles.funcButton, styles.btnVerifyCode]}
                    onPress={this._getVerifyCode}
                    style={styles.btnTextVerifyCode}>
                    {'获取验证码'}
                </Button>
            )
        } else {
            return (
                <Button
                    containerStyle={[styles.funcButton, styles.btnLogin]}
                    onPress={this._verifyCodeLogin}
                    style={styles.btnTextLogin}>
                    {'登录'}
                </Button>
            )
        }
    }

    _verifyCodeInputComponent = () => {
        if (!this.state.hasSentCode) {
            return null
        }
        return (
            <TextInput
                onChangeText={this._verifyCodeTextDidChanged.bind(this)}
                style={styles.phoneNumInput}
                placeholder={'输入验证码'}>
            </TextInput>
        )
    }

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection : 'column',
        justifyContent : 'flex-start',
        alignItems : 'center',
        backgroundColor: UIUtil.colors.bgGray,

    },

    phoneNumInput : {
        marginTop : 10.0,
        marginHorizontal : 0.0,
        color : UIUtil.colors.textGray,
        fontSize : 15.0,
        textAlign : 'left',
    },

    funcButton : {
        marginVertical: 20.0,
        marginHorizontal: 12.0,
        height : 35.0,
        borderRadius : 4.0,
    },

    btnVerifyCode : {
        borderWidth:1,
        borderColor : UIUtil.colors.mainRed,
        backgroundColor : UIUtil.colors.mainWhite
    },

    btnLogin : {
        backgroundColor : UIUtil.colors.mainRed
    },

    btnTextVerifyCode : {
        color : UIUtil.colors.mainRed,
        textAlign: 'center',
        fontSize: 15.0,
    },

    btnTextLogin : {
        color : UIUtil.colors.mainWhite,
        textAlign: 'center',
        fontSize: 15.0,
    }
});