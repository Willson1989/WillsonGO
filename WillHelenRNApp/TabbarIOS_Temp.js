/**
 * Created by willhelen on 2017/10/27.
 */

import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
    TabBarIOS,
} from 'react-native'

import  Icon  from 'react-native-vector-icons/Ionicons'
// import  ListPage  from './Main/ListPage.js'
import  MorePage  from './Main/MorePage.js'
import  VideoPage from './Main/VideoPage.js'
import  {ListNavigator} from './Main/ListPage.js'
import  FlatListDemo from './FlatListDemo.js'

export default class TabBarMainView extends React.Component {

    constructor(props) {
        super(props)
        this.state = {
            selectedIndex : 0,
        }
    }

    setTabSelectIndex (index) {
        this.setState({
            selectedIndex : index
        })
    }

    render(){
        return (
            <TabBarIOS tintColor='#ee735c'>

                <Icon.TabBarItem
                    iconName={'ios-videocam-outline'}
                    selectedIconName={'ios-videocam'}
                    title='List'
                    selected={this.state.selectedIndex == 0}
                    onPress={() => {
                        this.setTabSelectIndex(0)
                    }}>

                    <ListNavigator />

                </Icon.TabBarItem>

                <Icon.TabBarItem
                    iconName={'ios-recording-outline'}
                    selectedIconName={'ios-recording'}
                    title='Video'
                    selected={this.state.selectedIndex == 1}
                    onPress={() => {
                        this.setTabSelectIndex(1)
                    }}>
                    <VideoPage/>

                </Icon.TabBarItem>

                <Icon.TabBarItem
                    iconName={'ios-more-outline'}
                    selectedIconName={'ios-more'}
                    title='More'
                    selected={this.state.selectedIndex == 2}
                    onPress={() => {
                        this.setTabSelectIndex(2)
                    }}>

                    <MorePage/>

                </Icon.TabBarItem>

            </TabBarIOS>
        )
    }
}

