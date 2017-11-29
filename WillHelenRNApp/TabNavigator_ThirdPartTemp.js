

import React , {Component} from 'react'
import {
    View,
    Text,
    StyleSheet,
    Image,
    TouchableOpacity,
    DeviceEventEmitter,
} from 'react-native'

import  TabNavigator from 'react-native-tab-navigator'
import  Icon  from 'react-native-vector-icons/Ionicons'
import  MorePage  from './Main/MorePage.js'
import  VideoPage from './Main/VideoPage.js'
import  { ListNavigator } from './Main/ListPage.js'


var TABBAR_HEIGHT = 49

export default class TabBarMainView01 extends Component {
    constructor(props) {
        super(props)
        this.tabbarHidden = false
        DeviceEventEmitter.addListener('TabbarHidden',this._setTabBarHidden)
        this.state = {
            selectedIndex : 0,
        }
    }

    _setTabBarHidden = (param) => {
        if (param == null || (param && param.hidden == null)) {
            return
        }
        var hidden = param.hidden
        if (hidden == this.tabbarHidden) {
            return
        }
        this.tabbarHidden = hidden
        this.setState({
            tabbarHidden : hidden,
        })
    }

    _setTabSelectIndex (index) {
        this.setState({
            selectedIndex : index,
            tabbarHidden : false,
        })
    }

    render() {
        return (
            <View style={{flex : 1}}>

                <TabNavigator tabBarStyle={{
                                  height : this.state.tabbarHidden ? 0 : TABBAR_HEIGHT,
                                  overflow:this.state.tabbarHidden ? 'hidden':'visible'}}
                              sceneStyle={{
                                  paddingBottom : this.state.tabbarHidden ? 0 : TABBAR_HEIGHT,
                              }}
                              tintColor={'#ffd734'}>
                    <TabNavigator.Item
                        title='List'
                        selected={this.state.selectedIndex == 0}
                        onPress={() => {
                            this._setTabSelectIndex(0)
                        }}
                        renderIcon={() =>
                            <Icon name='ios-videocam-outline'
                                  size={28}
                                  color='#ed7b65'/>
                        }
                        renderSelectedIcon ={() =>
                            <Icon name='ios-videocam'
                                  size={28}
                                  color='#ed7b65'/>
                        }>
                        <ListNavigator/>

                    </TabNavigator.Item>

                    <TabNavigator.Item
                        title='Video'
                        selected={this.state.selectedIndex == 1}
                        onPress={() => {
                            this._setTabSelectIndex(1)
                        }}
                        renderIcon={() =>
                            <Icon name='ios-recording-outline'
                                  size={28}
                                  color='#ed7b65'/>
                        }
                        renderSelectedIcon ={() =>
                            <Icon name='ios-recording'
                                  size={28}
                                  color='#ed7b65'/>
                        }>
                        <VideoPage />

                    </TabNavigator.Item>

                    <TabNavigator.Item
                        title='More'
                        selected={this.state.selectedIndex == 2}
                        onPress={() => {
                            this._setTabSelectIndex(2)
                        }}
                        renderIcon={() =>
                            <Icon name='ios-more-outline'
                                  size={28}
                                  color='#ed7b65'/>
                        }
                        renderSelectedIcon ={() =>
                            <Icon name='ios-more'
                                  size={28}
                                  color='#ed7b65'/>
                        }>
                        <MorePage />

                    </TabNavigator.Item>

                </TabNavigator>
            </View>

        )
    }
}
