
import { StackNavigator } from 'react-navigation'


var CustomNavigationOption = ({navigation}) => {

    var headerStyles = {
        backgroundColor:'#ee735c',
    }

    var headerTitleStyle = {
        color:'#fff',
        fontSize:15,
        textAlign:'center',
        fontWeight:'600',
        alignSelf:'center'
    }

    return {
        headerStyle: headerStyles,
        headerBackTitle : null,
        headerTitleStyle : headerTitleStyle,
        gesturesEnabled : false,
        headerTitle:'Video List'
    }
}

var netConfig = {
    headerParams:{
        method : 'POST',
        headers : {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        },
    },
    apiBaseUrl : 'http://rapapi.org/mockjs/28487/',
    method:{
        createion : 'api/creations',
        like      : 'api/like',
        comment   : 'api/comment',
        submitComment : 'api/submitComment',
        tempTest  : 'api/tempTest'
    },
    navOptions : CustomNavigationOption,
}



// export {
//     netConfig,
//     CustomNavigationOption,
// }

module.exports = netConfig
