import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
    TouchableOpacity,
    DeviceEventEmitter,
    ActivityIndicator,
    SectionList,
    TextInput,
    Modal,
} from 'react-native'

import Icon from 'react-native-vector-icons/Ionicons'
import Video from 'react-native-video'
import Button from 'react-native-button'

var UIUtil = require('../Common/UIUtil')
var NetUtil = require('../Common/NetUtil')
var netConfig = require('../Common/Config')
var Dimensions = require('Dimensions')
var screenWidth = Dimensions.get('window').width
var screenHeight = Dimensions.get('window').height

let videoBox_Height = 280
let progressBar_Height = 5
let playIconBtnSize = 46
let playIconSize = 28
let NAVBAR_HEIGHT = 64
let commentInputAreaHeight = 50

var detailFrameInfo = {
    avatarSize : 60,
    replyAvatarSize : 40,
}

class CommentInputPage extends Component {

    constructor(props) {
        super(props)
        this.closeAction = this.props.closeAction
        this.state = {
            submitEnable : false,
            content : '',
        }
    }

    _submitComment() {
        let videoInfo = this.props.videoItemInfo
        let params = {
            id : videoInfo.id,
            token : '123',
            content : this.state.content
        }
        NetUtil.post(netConfig.method.submitComment, params)
            .then((data) => {
                console.log('submit comment : ', data)
                if (data && data.success && data.success == true) {
                    let commentData = {
                        nickName : 'WillHelen',
                        content : this.state.content,
                        avatar : 'http://dummyimage.com/500x500/e8576a)',
                    }
                    if (this.props.commentDidSubmit) {
                        this.props.commentDidSubmit(commentData)
                    }
                }
            })
            .catch((error) => {
                console.log(error)
            })

    }

    _onChangeText(text) {
        let submitEnable = (text.length > 0)
        this.setState({
            content : text,
            submitEnable : submitEnable,
        })
    }

    render() {
        return (
            <View style={ciStyles.container} >

                <TouchableOpacity
                    activeOpacity={1.0}
                    style={ciStyles.closeArea}
                    onPress={this.closeAction}>
                    <Icon
                        name='ios-close'
                        style={ciStyles.cancelBtn}
                        size={30}
                    />
                </TouchableOpacity>

                <TextInput
                    style={ciStyles.input}
                    placeholder={'评论一下~'}
                    multiline={true}
                    onChangeText={this._onChangeText.bind(this)}
                />
                <Button
                    containerStyle={[ciStyles.submitBtnContainer,
                        {backgroundColor : this.state.submitEnable ? '#ff807b' : '#848783'}]}
                    style={ciStyles.submitBtnText}
                    disabled={!this.state.submitEnable}
                    onPress={this._submitComment.bind(this)}
                >
                    {'提交评论'}
                </Button>

            </View>
        )
    }

}

const ciPage_ContentPadding = 15
const ciStyles = StyleSheet.create({
    container : {
        flex : 1,
        backgroundColor : '#fff',
        flexDirection : 'column',
        alignItems : 'center',
        padding : 15,
        margin : 0,
    },

    input : {
        borderRadius : 5,
        borderColor : '#cdcdcd',
        borderWidth : 0.5,
        width : screenWidth - ciPage_ContentPadding * 2.0,
        height : 180,
        marginVertical : 10.0,
        paddingHorizontal:8,
        paddingVertical:5,
    },

    closeArea : {
        flexDirection : 'column',
        justifyContent: 'center',
        alignItems: 'center',
        width : 40,
        height : 40,
    },

    cancelBtn : {
        marginTop : 50,
        marginBottom : 30,
    },

    submitBtnContainer : {
        borderRadius : 4,
        width : screenWidth * 0.3,
        height : 30,
        marginVertical : 20,
        flexDirection : 'column',
        justifyContent : 'center',
        alignItems : 'center',
    },

    submitBtnText : {
        fontSize : 15,
        color : '#fff',
        textAlign : 'center'
    },
})

/*
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 */


class MainVideo extends Component {


    constructor(props) {
        super(props)
        this.state = {
            rate : 1,
            paused : false,
            muted : false,
            videoLoaded : false,
            videoError : false,
            videoProgress : 0,
            totalTime : 0,
            currentTime : 0,
            playing : false,
        }
    }

    _onLoadStart() {
        console.log('_onLoadStart')
    }

    _onLoad() {
        console.log('_onLoad')
    }

    /*
     不知道为何，onProgress方法在onEnd之后还会继续调用
     所以需要在onEnd方法中将Video的rate属性设置为0，让视频停止
     但是这样的话，在onEnd之后还会额外再调用一次onProgress，
     所以需要在onProgress的最开始加上 this.state.rate == 0 的判断
     */
    _onProgress(data) {
        if (this.state.rate == 0) {
            return
        }

        // console.log('_onProgress : ', data)
        if (!this.state.videoLoaded) {
            this.setState({
                videoLoaded : true,
            })
        }

        var duration = data.playableDuration
        var currentTime = data.currentTime
        var percent = Number( currentTime / duration ) .toFixed(2)
        var newState = {
            videoProgress : percent,
            totalTime : duration,
            currentTime : currentTime
        }

        if (this.state.videoLoaded == false) {
            newState.videoLoaded = true
        }

        if (this.state.playing == false) {
            newState.playing = true
        }
        this.setState(newState)
    }

    _onEnd() {
        console.log('_onEnd')
        this.setState({
            rate : 0,
            videoProgress : 1,
            playing : false,
        })
    }

    _onError() {
        console.log('_onError')
        this.setState({
            videoError : true,
            videoLoaded : false,
        })
    }

    _replay() {
        this.setState({
            rate : 1,
            playing : true,
            videoProgress : 0.01
        })
        this._video.seek(0)
    }

    _pause() {
        console.log('===== pause =====')
        if (!this.state.paused) {
            this.setState({
                paused:true,
            })
        }
    }

    _resume() {
        console.log('===== resume =====')
        if (this.state.paused) {
            this.setState({
                paused:false,
            })
        }
    }

    render() {
        return (
            <View style={videoStyles.videoBox}>
                {this._videoComponent(this.props.item)}
                {this._videoErrorComponent()}
                {this._videoLoadingComponent()}
                {this._videoProgressComponent()}
                {this._replayComponent()}
                {this._pauseComponent()}
            </View>
        )
    }

    _videoComponent() {
        return (
            <Video
                ref={(v) => {this._video = v}}
                style={videoStyles.video}
                source={{uri:this.props.item.videoAddress}}
                volume={4}
                paused={this.state.paused}
                muted={this.state.muted}
                onLoad={this._onLoad.bind(this)}
                onLoadstart={this._onLoadStart.bind(this)}
                onProgress={this._onProgress.bind(this)}
                onError={this._onError.bind(this)}
                onEnd={this._onEnd.bind(this)}
                rate={this.state.rate}
                resizeMode="strech"
            />
        )
    }

    _videoErrorComponent() {
        if (this.state.videoError) {
            return (
                <Text style={videoStyles.errorText}>
                    {'视频出错啦！很抱歉~'}
                </Text>
            )
        }
        return null
    }

    _pauseComponent() {
        if (this.state.videoLoaded && this.state.playing) {
            return (
                <TouchableOpacity
                    activeOpacity={1}
                    onPress={() => {
                        if (this.state.paused) {
                            this._resume()
                        } else {
                            this._pause()
                        }
                    }}
                    style={videoStyles.pauseTouchArea}>
                    {
                        this.state.paused
                            ? <Icon name='ios-play'
                                    size={playIconSize}
                                    color='#ed7b65'
                                    style={videoStyles.replayIcon}
                            />
                            : <View></View>
                    }
                </TouchableOpacity>
            )
        }
    }

    _replayComponent() {
        if (this.state.videoLoaded && !this.state.playing) {
            return (
                <Icon name='ios-play'
                      size={playIconSize}
                      color='#ed7b65'
                      style={videoStyles.replayIcon}
                      onPress={this._replay.bind(this)}/>
            )
        }
        return null
    }

    _videoProgressComponent() {
        return (
            <View style={videoStyles.progressBox}>
                <View style={[videoStyles.progressBar,
                    {width:screenWidth * this.state.videoProgress}]}>
                </View>

            </View>
        )
    }

    _videoLoadingComponent() {
        if (!this.state.videoLoaded && !this.state.videoError) {
            return (
                <ActivityIndicator color='#fff'
                                   style={videoStyles.videoLoading}
                                   tintColor='black'
                />
            )
        }
        return null
    }
}

const videoStyles = StyleSheet.create({
    video : {
        width : screenWidth,
        height : videoBox_Height,
        backgroundColor : '#000',
    },

    videoBox : {
        width : screenWidth,
        height : videoBox_Height,
        backgroundColor : '#f9763f',
    },

    videoLoading : {
        position:'absolute',
        top:videoBox_Height * 0.5 - 15,
        height : 30,
        alignSelf:'center',
    },

    progressBox : {
        width : screenWidth,
        height : progressBar_Height,
        backgroundColor : 'gray',
    },

    progressBar : {
        width : screenWidth,
        height : progressBar_Height,
        backgroundColor : '#ff6600',
    },

    replayIcon : {
        position : 'absolute',
        top : (videoBox_Height - playIconBtnSize) * 0.5,
        left : (screenWidth - playIconBtnSize) * 0.5,
        width : playIconBtnSize,
        height : playIconBtnSize,
        paddingTop : 9,
        paddingLeft : 18,
        backgroundColor : 'transparent',
        borderColor: '#fff',
        borderWidth : 1,
        borderRadius: 46 * 0.5,
    },

    pauseTouchArea : {
        position : 'absolute',
        top : 0,
        left : 0,
        width : screenWidth,
        height : videoBox_Height,
        backgroundColor : 'transparent',
    },

    errorText : {
        position : 'absolute',
        color : '#fff',
        top : videoBox_Height * 0.5 - 10,
        textAlign: 'center',
        width : screenWidth,
        alignSelf:'center',
        backgroundColor : 'transparent',
    },

    videoTitle : {
        backgroundColor : 'white',
        color : '#000',
        textAlign : 'center',
        fontSize : 17,
        fontWeight: 'normal',
        marginTop : 20,
        marginBottom : 20,
    },
})

/*
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 ************************************************************
 */


export default class VideoDetail extends Component {

    static navigationOptions = ({navigation}) => UIUtil.navOptions(navigation, '视频详情')

    constructor(props) {
        super(props)
        var item = this.props.navigation.state.params.videoItemInfo
        this.state = {
            videoItemInfo  : item,
            commentData : [],
            loadingTail : false,
            modalVisible : false,
        }

        this.cachedComment = {
            nextPage : 1,
            listData : [],
            total    : 0,
        }

        this.listContentSize = {
            width : 0,
            height : 0,
        }
    }

    componentDidMount() {
        this._fetchCommentData()
    }

    _hasMore() {
        return this.cachedComment.listData.length <= this.cachedComment.total
    }

    _loadMore() {
        if (!this._hasMore() || this.state.loadingTail || this.state.length == 0) {
            return
        }
        var page = this.cachedComment.nextPage
        this._fetchCommentData(page)
    }

    _fetchCommentData(page) {
        if (page != 0 ) {
            this.setState({
                loadingTail:true
            })
        }
        var that = this
        var method = netConfig.method.comment
        var params = {
            id : this.state.videoItemInfo.id,
            token : '11111',
        }

        NetUtil.post(method, params)
            .then((responseData) => {
                if (responseData && responseData.success) {
                    this.cachedComment.nextPage += 1
                    this.cachedComment.total = responseData.total
                    var commentList = responseData.data
                    this.cachedComment.listData = this.cachedComment.listData.concat(commentList)
                    this.setState({
                        commentData : this.cachedComment.listData,
                        loadingTail : false
                    })
                }
            })
            .catch((error) => {
                console.log('fetch comment data error : ', error)
                this.setState({
                    loadingTail : false
                })
            })
    }

    _keyExtractor = (item, index) => {
        return item.id + index
    }


    _onScroll(event) {

        var contentOffset = event.nativeEvent.contentOffset
        var visiableHeight = screenHeight - videoBox_Height - NAVBAR_HEIGHT - progressBar_Height - commentInputAreaHeight
        if (contentOffset.y + visiableHeight >= this.listContentSize.height) {
            this._loadMore()
        }
    }

    _onContentSizeChanged(width, height) {
        this.listContentSize.width  = width
        this.listContentSize.height = height
    }

    render() {
        var videoItemInfo = this.state.videoItemInfo
        return (
            <View style={styles.container}>
                <MainVideo
                    ref = {(mv) => {this._video = mv}}
                    item = {videoItemInfo}/>
                {this._videoDetailComponent_SectionList(videoItemInfo)}
                {this._commentInputComponent()}
                {this._modalCommentSubmitPage()}
            </View>
        )
    }

    _commentInputModalVisiable(visible) {
        this.setState({
            modalVisible : visible
        },() => {
            if (this._video) {
                if ( visible == true ) {
                    this._video._pause()
                } else {
                    this._video._resume()
                }
            }

        })
    }


    _modalCommentSubmitPage() {
        return (
            <Modal
                visible={this.state.modalVisible}
                onRequestClose={() => {
                    console.log('CommentInputPage onRequestClose')
                }}
                onShow={() => {
                    console.log('CommentInputPage onShow')
                }}
                transparent={true}
                animationType={'slide'}
            >
                <CommentInputPage
                    closeAction = {() => {this._commentInputModalVisiable(false)}}
                    videoItemInfo = {this.state.videoItemInfo}
                    commentDidSubmit = {this._commentDidSubmit.bind(this)}
                />
            </Modal>
        )
    }

    _commentDidSubmit(commentData) {
        let nickName = commentData.nickName
        let avatar   = commentData.avatar
        let content  = commentData.content
        let newCommentData = [{nickName, avatar, content}].concat(this.state.commentData)
        this.setState({
            commentData : newCommentData,
            modalVisible : false,
        })
    }


    _commentInputComponent() {
        return (
            <View style={styles.commentInputBox}>

                <TextInput
                    ref={(input) => {this.commentInput = input}}
                    style={styles.commentInput}
                    editable={false}
                    placeholder={'评论一下'}
                />
                <TouchableOpacity
                    style={styles.commentInputTapArea}
                    onPress={() => {
                        this._commentInputModalVisiable(true)
                    }}
                />

            </View>
        )
    }

    _videoDetailComponent_SectionList(videoItemInfo) {
        var commentData = this.state.commentData
        var authorInfo  = [videoItemInfo.author]
        return (
            <SectionList
                style={styles.mainListView}
                automaticallyAdjustContentInsets = {false}
                stickySectionHeadersEnabled={false}
                showsVerticalScrollIndicator={false}
                keyExtractor={this._keyExtractor.bind(this)}
                renderSectionHeader={this._commentSectionHeader.bind(this)}
                ListFooterComponent={this._renderFooter.bind(this)}
                onContentSizeChange={this._onContentSizeChanged.bind(this)}
                onScroll={this._onScroll.bind(this)}
                bounces={false}
                sections={
                    [
                        {
                            data : authorInfo,
                            key : 'section01',
                            renderItem : this._authorInfoComponent.bind(this)
                        },
                        {
                            data : commentData,
                            key : 'section02',
                            renderItem : this._commentInfoItemComponent.bind(this)
                        },
                    ]
                }/>
        )
    }

    _renderFooter() {
        if (this.cachedComment.listData.length == 0) {
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

    _authorInfoComponent = ({item}) => {
        var videoTitle = this.state.videoItemInfo.title
        return (
            <View style={styles.infoBox}>
                <Image style={styles.authorAvatar}
                       source={{uri : item.avatar}}/>

                <View style={styles.descBox}>

                    <Text style={styles.authorNick}>{item.nickName}</Text>
                    <Text style={styles.videoTitle}>{videoTitle}</Text>

                </View>
            </View>
        )
    }

    _commentInfoItemComponent = ({item}) => {
        return (
            <View style={styles.commentBox}>
                <Image style={styles.replyAvatar}
                       source={{uri : item.avatar}}/>

                <View style={styles.commentDescBox}>

                    <Text style={styles.replyNick}>{item.nickName}</Text>
                    <Text style={styles.replyContent}>{item.content}</Text>

                </View>
            </View>
        )
    }

    _commentSectionHeader = ({section}) => {
        if (section.key != 'section02') {
            return null
        }
        return (
            <View style={{backgroundColor:'#fff', height : 30}}>
                <Text style={{color : '#8f8f8f', textAlign : 'center', fontSize : 15}}>
                    {'--------  评论  --------'}
                </Text>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container : {
        flex : 1,
        backgroundColor : 'white',
    },


    videoInfoScrollView : {
        width : screenWidth,
    },

    infoBox : {
        flexDirection : 'row',
        width : screenWidth,
        justifyContent : 'center',
        marginTop : 10,
        marginBottom : 20,
    },

    authorAvatar : {
        width : detailFrameInfo.avatarSize,
        height : detailFrameInfo.avatarSize,
        borderRadius : detailFrameInfo.avatarSize * 0.5,
        marginHorizontal : 8,
        marginVertical : 8,
    },

    descBox : {
        flex : 1,
    },

    authorNick : {
        marginVertical : 8,
        marginRight : 8,
        fontSize : 18,
        color : '#000'
    },

    videoTitle : {
        marginTop : 0,
        marginBottom : 8,
        marginRight : 8,
        fontSize : 16,
        color : '#666'
    },

    mainListView : {
        width : screenWidth,
        marginTop : progressBar_Height,
        backgroundColor : '#fff',
    },

    commentBox : {
        flexDirection: 'row',
        // width : 200,
        paddingRight: 30,
    },

    commentDescBox : {
        padding : 8,
        marginRight : 20,
    },

    replyNick : {
        color : '#000',
        fontSize : 14,
        textAlign : 'left',
        marginRight : 8,
    },

    replyContent : {
        marginRight : 8,
        color : '#666',
        fontSize : 12,
        textAlign : 'left',
    },

    replyAvatar : {
        width : detailFrameInfo.replyAvatarSize,
        height : detailFrameInfo.replyAvatarSize,
        borderRadius : detailFrameInfo.replyAvatarSize * 0.5,
        marginHorizontal : 8,
        marginVertical : 8,
    },

    loadingMore : {
        marginVertical:10,
    },

    loadingMoreText : {
        color : '#777',
        textAlign : 'center'
    },

    commentInputBox : {
        position : 'absolute',
        width  : screenWidth,
        height : commentInputAreaHeight,
        bottom : 0,
        left : 0,
        backgroundColor : '#f4f3f9',
        borderWidth : 0.5,
        borderTopColor : '#5a5a5a'
    },

    commentInput : {
        color:'#3d3940',
        fontSize : 14,
        margin : 8,
        height : commentInputAreaHeight - 16,
        borderWidth:1,
        borderColor:'#bdbdbd',
        borderRadius : 4,
        backgroundColor : '#fff',
        paddingLeft : 8,
    },

    commentInputTapArea : {
        backgroundColor:'transparent',
        position : 'absolute',
        height : commentInputAreaHeight,
        width:screenWidth,
        bottom:0,
        left : 0,
    }

})

