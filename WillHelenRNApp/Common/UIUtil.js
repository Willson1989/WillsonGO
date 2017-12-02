
import React , {Component} from 'react'

import {
    View,
    TouchableOpacity,
    DeviceEventEmitter
} from 'react-native'

import Icon from 'react-native-vector-icons/Ionicons'

const CustomNavigationOption = (navigation, headerTitle, isBack = true) => {

    var params = navigation.state.params

    const headerStyle = {
        backgroundColor:'#ff807b',
    }

    const headerTitleStyle = {
        color:'#fff',
        fontSize:17,
        textAlign:'center',
        fontWeight:'600',
        alignSelf:'center'
    }

    let backComponent = (isBack) => {
        if (!isBack) {
            return null
        }
        return(
            <TouchableOpacity
                onPress={() => {
                    if (params) {
                        if (params.isFromFirst != null && params.isFromFirst == true) {
                            DeviceEventEmitter.emit('TabbarHidden',{hidden : false})
                        }
                    }
                    navigation.goBack()
                }}>
                <Icon style={{marginVertical:10}}
                      name = 'ios-arrow-back'
                      size={21}/>
            </TouchableOpacity>
        )
    }

    const headerLeft =
        <View
            style={{
                marginLeft : 10,
                width : 50,
                height : 40,
                backgroundColor: 'transparent'}}>
            {backComponent(isBack)}
        </View>

    const title = headerTitle

    return {
        title,
        headerLeft,
        headerStyle,
        headerTitleStyle,
    }
}

let navigate = (navigation, screen, params = null, isFromFirst = false) => {

    if (navigation == null || screen == null) {
        return
    }
    var isFirst = isFromFirst == null ? false : isFromFirst
    if (params) {
        params.isFromFirst = isFirst
    }
    navigation.navigate(screen,params)
    if (isFromFirst) {
        DeviceEventEmitter.emit('TabbarHidden',{hidden : true})
    }
}

var UIUtil = {
    navOptions : CustomNavigationOption,
    navigate : navigate,
    colors : {
        bgGray : '#E6E6E6',
        mainRed : '#ff807b',
        mainWhite : '#ffffff',
        textGray : '#999999',
    },
}

module.exports = UIUtil
