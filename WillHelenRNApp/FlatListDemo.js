

import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
    ImageBackground,
    FlatList,
    ListView,
    TouchableHighlight,
    Alert,
} from 'react-native'

var _ = require('lodash')
var Dimensions = require('Dimensions')
var screenWidth = Dimensions.get('window').width
var screenHeight = Dimensions.get('window').height

var listParams = {
    contentSizeWidth : 0,
    contentSizeHeight : 0,
    loadingTail:false,
}

export default class TempList extends  Component {

    constructor(props) {
        super(props)
        this.state = {
            refreshing : false,
            listData : this._ListData()
        }
    }

    _ListData = () => {
        var data = []
        var count = 9
        for (var i = 0 ; i < count ; i ++) {
            var content = 'No.' + (i+1)
            data.push({index : i, content : content})
        }
        return data

        this._flatList.setNativeProps({
            refreshing : true
        })
    }


    _renderItem = ({item}) => {

        var bgColor = item.index % 2 == 0 ? 'red' : 'blue'
        return (
            <View style={{backgroundColor:bgColor, height : 100}} onPress={() => {
                this.ref.listView.s
            }}>
                <Text style={{color : 'white'}}>
                    {'Index : ' + item.index + ' , content : ' + item.content}
                </Text>
            </View>
        )
    }

    _loadMore() {

        this.timer = setTimeout(() => {
            Alert.alert(
                'Alert',
                '加载更多。。。',
                [{text:'OK', onPress : () => {
                    listParams.loadingTail = false
                }}]
            )
        }, 1000)
    }

    _refresh() {
        this.setState({refreshing : true})
        this.timer = setTimeout(() => {
            Alert.alert(
                'Alert',
                '刷新。。。',
                [{text:'OK', onPress : () => {
                    this.setState({refreshing : false})

                }}]
            )
        }, 3000)
    }

    _onScroll(e) {
        // console.log('content offset : ' , this._flatList.scrollProperties.offset)
        // console.log('flatList ', this._flatList.scrollProperties)
        var offSetY = e.nativeEvent.contentOffset.y
        var listHeight = screenHeight - 49.0
        if (offSetY + listHeight >= listParams.contentSizeHeight) {
            console.log('shoule load more')
            if (!listParams.loadingTail) {
                listParams.loadingTail = true
                this._loadMore()
            }
        }

    }

    _onContentSizeChanged(contentSizeWidth, contentSizeHeight) {
        console.log('content size, w : ' + contentSizeWidth + ', h : ' + contentSizeHeight)
        listParams.contentSizeWidth = contentSizeWidth
        listParams.contentSizeHeight = contentSizeHeight
    }

    render() {
        console.log('flatList render =====00000')
        return (
            <FlatList
                ref={(fl) => {
                    this._flatList = fl
                }}
                style={styles.listDataView}
                data={this.state.listData}
                renderItem={this._renderItem}
                automaticallyAdjustContentInsets={false}
                // onEndReached={this._loadMore}
                // onEndReachedThreshold={0}
                onScroll={this._onScroll.bind(this)}
                refreshing={this.state.refreshing}
                onRefresh={this._refresh.bind(this)}
                onContentSizeChange={this._onContentSizeChanged.bind(this)}
            />
        )
    }

}

const styles = StyleSheet.create({
    listDataView : {
        backgroundColor:'#cffff8',
        marginBottom: 49,
        // height:screenHeight,
    },

    item : {
        width : screenWidth,
        //height : itemHeight,
        marginBottom : 10,
        backgroundColor : '#fff',
    },
})