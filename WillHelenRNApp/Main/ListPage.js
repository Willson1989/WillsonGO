/**
 * Created by willhelen on 2017/11/3.
 */

import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    ImageBackground,
    FlatList,
    TouchableHighlight,
    ActivityIndicator,
    Alert,
} from 'react-native'

import { StackNavigator } from 'react-navigation'
import Icon from 'react-native-vector-icons/Ionicons'
import VideoDetail from "./VideoDetail";

var _ = require('lodash')
var NetUtil = require('../Common/NetUtil')
var netConfig = require('../Common/Config')
var UIUtil = require('../Common/UIUtil')
var Dimensions = require('Dimensions')

var screenWidth = Dimensions.get('window').width
var screenHeight = Dimensions.get('window').height

var thumbHeight = screenWidth * 0.5625
var itemFooterHeight = 45
var itemTitleHeight = 30
var itemHeight = thumbHeight + itemFooterHeight + itemTitleHeight;
var NAVBAR_HEIGHT = 64;

var ListContentSize = {
    width : 0,
    height : 0,
}

var cachedResults = {
    nextPage : 1,
    items : [],
    total : 0,
}


class ListPageItem extends Component {
    constructor(props){
        super(props)
        this.state = {
            item : this.props.item,
        }
    }

    _likeAction = () => {
        var item = this.state.item
        var params = {
            token : '111',
            id : '11111',
            isLike : item.isLike ? 'N' : 'Y'
        }

        NetUtil.post(netConfig.method.like, params)
            .then((response) => {
                console.log('like success : ', response)
                if (response.success) {
                    item.isLike = !item.isLike
                    this.setState({
                        item : item,
                    })
                    Alert.alert(
                        '提示',
                        '操作成功',
                        [{text : 'OK', onPress : null},])
                } else {
                    Alert.alert(
                        '提示',
                        '操作失败，请稍后再试',
                        [{text : 'OK', onPress : null},])
                }
            })
            .catch((error) => {
                console.log(error)
                Alert.alert(
                    '提示',
                    '网络异常，请稍后再试',
                    [{text : 'OK', onPress : null},])
            })
    }

    _onSelectVideo() {
        this.props.onSelect()
    }


    render() {
        var item = this.state.item
        return (
            <View style={styles.item}>
                <Text style={styles.itemTitle}>{item.title}</Text>
                <TouchableHighlight onPress={this._onSelectVideo.bind(this)}>
                    <ImageBackground
                        style={styles.videoImage}
                        source={{uri:item.thumb}}
                    >
                        <Icon name='ios-play-outline'
                              size={28}
                              color='#ed7b65'
                              style={styles.playIcon}/>
                    </ImageBackground>
                </TouchableHighlight>


                <View style={styles.itemFooter} >
                    <TouchableHighlight onPress={this._likeAction}>
                        <View style={styles.handleBox}
                              onPress={this._likeAction}>
                            <Icon name={item.isLike ? 'ios-heart' : 'ios-heart-outline'}
                                  size={23}
                                  style={styles.handleIcon}/>
                            <Text style={styles.handleText}>{'喜欢'}</Text>
                        </View>
                    </TouchableHighlight>

                    <View style={styles.handleBox} >
                        <Icon name='ios-chatboxes-outline'
                              size={23}
                              style={styles.handleIcon}/>
                        <Text style={styles.handleText}>{'评论'}</Text>
                    </View>
                </View>
            </View>
        )
    }
}

class ListPage extends Component {

    static navigationOptions = ({navigation}) => UIUtil.navOptions(navigation, '视频列表', false)
    
    _renderItem = ({item}) => {
        return (
            <ListPageItem item={item}
                          onSelect={() => {
                              this._gotoDetailPage(item)
                          }}/>
        )
    }

    _gotoDetailPage = (videoItemInfo) => {
        let params = {videoItemInfo : videoItemInfo}
        UIUtil.navigate(this.props.navigation,'Detail',params,true)
    }

    _renderFooter() {

        if (cachedResults.items.length == 0) {
            return null
        }

        if (!this._hasMore()) {
            return (
                <View style={styles.loadingMore}>
                    <Text style={styles.loadingMoreText}>{'没有更多啦'}</Text>
                </View>
            )
        } else {
            return (
                <ActivityIndicator style={styles.loadingMore}/>
            )
        }
    }

    _requestData(page) {

        if (page == 0) {
            this.setState({
                refreshing : true,
            })
        } else {
            this.setState({
                loadingTail : true,
            })
        }
        var param = {
            token : '123456',
            page  : page
        }
        NetUtil.post(netConfig.method.createion, param)
            .then((responseData) => {
                var items = responseData.data
                cachedResults.total = responseData.total
                if (page != 0) {
                    cachedResults.items = cachedResults.items.concat(items)
                    cachedResults.nextPage += 1
                } else {
                    cachedResults.items = items
                    cachedResults.nextPage = 1
                }
                console.log('fetch complete , cachedResult : ', cachedResults)
                this.timer = setTimeout(() => {
                    this.setState({
                        listData : cachedResults.items,
                        refreshing : false,
                        loadingTail: false
                    })
                }, 200)
                console.log('responseData : ',responseData)
            })
             .catch((error) => {
                this.setState({
                    refreshing : false,
                    loadingTail : false,
                })
                console.warn(error)
            })
    }

    _hasMore() {
        console.log('_hasMore ', cachedResults.items.length)
        return cachedResults.items.length <= cachedResults.total
    }

    _loadMore() {

        if (!this._hasMore() || this.state.loadingTail || cachedResults.items.length == 0) {
            return
        }
        console.log(' loadMore =-=-=-=-=-=-=-=-=-=-= ', this._mainListView)

        var page = cachedResults.nextPage
        this._requestData(page)
    }

    _onRefresh() {
        if (this.state.refreshing) {
            return
        }
        console.log(' refresh =-=-=-=-=-=-=-=-=-=-= ', this._mainListView)

        this._requestData(0)
    }

    componentDidMount() {
        this._onRefresh()

    }

    componentWillUnmount() {
        this.timer && clearTimeout(this.timer)

    }

    shouldComponentUpdate(nextProp, nextState) {
        if (_.isEqual(nextState, this.state)) {
            return false
        }
        return true
    }

    constructor(props) {
        super(props)
        this.state = {
            listData : [],
            refreshing : false,
            loadingTail : false,
        }
    }

    _onScroll(event) {

        var contentOffset = event.nativeEvent.contentOffset
        var visiableHeight = screenHeight - 49 - NAVBAR_HEIGHT
        if (contentOffset.y + visiableHeight >= ListContentSize.height + 20) {
            this._loadMore()
        }
    }

    _onContentSizeChanged(width, height) {
        ListContentSize.width  = width
        ListContentSize.height = height
    }

    _keyExtractor = (item, index) => {
        return index + item.id
    }

    render() {

        return (
            <View style={styles.container}>
                <FlatList
                    ref={(ft) => {
                        this._mainListView = ft
                    }}
                    style={styles.listDataView}
                    data={this.state.listData}
                    keyExtractor={this._keyExtractor}
                    renderItem={this._renderItem}
                    ListFooterComponent={this._renderFooter.bind(this)}
                    automaticallyAdjustContentInsets={false}
                    // onEndReached={this._requestMore}
                    // onEndReachedThreshold={0.1}
                    onRefresh={this._onRefresh.bind(this)}
                    refreshing={this.state.refreshing}
                    onScroll={this._onScroll.bind(this)}
                    onContentSizeChange={this._onContentSizeChanged.bind(this)}
                />
            </View>
        )
    }
}


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#ffd734',
    },
    header : {
        marginTop:0,
        height:NAVBAR_HEIGHT,
        backgroundColor:'#ee735c',
    },

    headerTitle:{
        marginTop:30,
        color:'#fff',
        fontSize:15,
        textAlign:'center',
        fontWeight:'600',
        alignSelf:'center'
    },
    
    listDataView : {
        backgroundColor:'#cffff8',
        // marginBottom: 49,
        // height:screenHeight,
    },

    txt: {
        textAlign: 'center',
        textAlignVertical: 'center',
        color: 'white',
        fontSize: 30,
    },

    item : {
        width : screenWidth,
        //height : itemHeight,
        marginBottom : 10,
        backgroundColor : '#fff',
    },

    videoImage : {
        backgroundColor: '#444',
        width : screenWidth,
        height : thumbHeight,
        // resizeMode : 'cover',
    } ,

    itemTitle : {
        padding:10,
        fontSize:18,
        color : '#333',
    },

    itemFooter : {
        flexDirection:'row',
        justifyContent:'space-between',
        backgroundColor:'#eee',
    },

    handleBox : {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems:'center',
        padding : 10,
        width : screenWidth * 0.5 - 1,
        backgroundColor : '#fff',
    },

    playIcon : {
        position : 'absolute',
        bottom : 14,
        right : 14,
        width : 46,
        height : 46,
        paddingTop : 9,
        paddingLeft : 18,
        backgroundColor : 'transparent',
        borderColor: '#fff',
        borderWidth : 1,
        borderRadius: 46 * 0.5,
    },

    handleText : {
        paddingLeft : 12,
        fontSize : 18,
        color : '#333'
    },

    handleIcon : {
        width: 25,
        height: 25,
    },

    loadingMore : {
        marginVertical:10,
    },

    loadingMoreText : {
        color : '#777',
        textAlign : 'center'
    }

});


const ListNavigator = StackNavigator({
    List   :
        {
            screen : ListPage,
        },
    Detail :
        {
            screen : VideoDetail
        },
})


export  { ListNavigator }