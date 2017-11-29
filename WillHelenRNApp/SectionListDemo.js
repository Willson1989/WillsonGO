

import React , {Component} from 'react'

import {
    View,
    Text,
    StyleSheet,
    Image,
    SectionList,
} from 'react-native'

var NetUtil = require('./Common/NetUtil')
var netConfig = require('./Common/Config')

const renderSectionHeader = ({section}) => (
    <View style={{backgroundColor:'#776655'}}>
        <Text style={{flex:1, color:'#fff', fontSize:15, textAlign:'center'}}>
            {section.sectionHeaderTitle}
        </Text>
    </View>
)

const itemSeperatorComponent = ({item}) => (
    <View style={{backgroundColor:'#888', height:1, flex:1}}></View>
)

const emptyComponent = () => (
    <View style={{flex : 1, backgroundColor: '#ffd734', height : 500}}></View>
)

export default class SectionListDemo extends Component {

    constructor(props) {
        super(props)
        this.state = {
            data: {
                list01 : [ ],
                list02 : [ ],
            }
        }
    }

    _renderItem_List01({item}) {
        console.log('title : ' + item.title + ', content : ' + item.content)

        return (
            <View style={styles.itemBox01}>
                <Text style={styles.itemMainText}>{item.title}</Text>
                <Text style={styles.itemSubText}>{item.content}</Text>
            </View>
        )
    }

    _renderItem_List02({item}) {
        console.log('mainTitle : ' + item.mainTitle + ' subTitle : ' + item.subTitle + ' mainContent : ' + item.mainContent)
        return (
            <View style={styles.itemBox02}>
                <Text style={styles.itemMainText}>{item.mainTitle}</Text>
                <Text style={styles.itemMainText}>{item.subTitle}</Text>
                <Text style={styles.itemSubText}>{item.mainContent}</Text>
            </View>
        )
    }

    _fetchData() {
        var method = netConfig.method.tempTest
        NetUtil.post(method, null)
            .then((data) => {
                var mainData = {}
                mainData.list01 = data.list01
                mainData.list02 = data.list02
                console.log('mainData 000 : ', mainData)
                this.setState({
                    data : mainData,
                })
            })
            .catch((error) => {
                console.log(error)
            })
    }

    componentDidMount() {
        this._fetchData()
    }

    _sectionsData() {
        var data = this.state.data
        return [
            {
                data : data.list01,
                renderItem : this._renderItem_List01.bind(this),
                sectionHeaderTitle : 'section01 header ',
                key : 's1'
            },
            {
                data : data.list02,
                renderItem : this._renderItem_List02.bind(this),
                sectionHeaderTitle : 'section02 header ',
                key : 's2'
            }
        ]
    }



    render() {
        return (
            <View style={styles.container}>
                <SectionList
                    sections={this._sectionsData()}
                    renderSectionHeader={renderSectionHeader}
                    stickySectionHeadersEnabled={false}
                    ItemSeparatorComponent={itemSeperatorComponent}
                    ListEmptyComponent={emptyComponent}
                />

            </View>
        )
    }
}

const styles = StyleSheet.create({
    container : {
        flex : 1,
        backgroundColor : 'white',
        paddingTop : 30,
    },

    itemBox01 : {
        flex : 1,
        flexDirection:'column',
        justifyContent:'flex-start',
        backgroundColor:'#fff'
    },

    itemBox02 : {
        flex : 1,
        flexDirection:'column',
        justifyContent:'flex-start',
        backgroundColor:'#ff9290'
    },

    itemMainText : {
        margin : 5,
        color : '#000',
        textAlign : 'left',
        fontSize : 15,
    },

    itemSubText : {
        margin:5,
        color : '#3d3940',
        textAlign:'left',
        fontSize : 18,
    }
})

