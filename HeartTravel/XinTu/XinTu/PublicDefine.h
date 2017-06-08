

#import "PublicFunction.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MJRefresh.h"
#import "TopPhotoScrollView.h"
#import "YRSideViewController.h"
#import "SUNSlideSwitchView.h"
#import "AudioStreamer.h"
#import "MONActivityIndicatorView.h"

//数据库
#import "SQLDataHandle.h"
//缓存
#import "CacheDataHandle.h"
//友盟
#import "UMSocial.h"

#import "SideViewController.h"

#import "TopNavigationView.h"
#import "FunctionCell.h"
#import "NavigationLeftButton.h"
#import "HotCityCell.h"
#import "DetailPageCell.h"
#import "HotGuideCell.h"
#import "UILabel+VerticalUpAlignment.h"
#import "CityFuncCell.h"
#import "TopTabBar.h"
#import "NavBackButton.h"

#import "NoneView.h"

#define API_KEY_MAP  @"07bad7be4a1c32391ede7c313f583053"

//定义宏,标识是从哪一个ViewController跳转到地图页面

typedef enum : NSUInteger {
    CountryDetailVC = 0,
    CityDetailVC,
    WayPointListVC
} VCEnum;

//缓存相关
#define Cache_Path  @"cache"
#define Country_Cache_path @"CountryList"

//友盟key
#define APPKEY @"557fcc1a67e58e3f2e001551"


//发现模块的头文件
#import "Country.h"
#import "City.h"

#define COMMON_FONT_SIZE       17.0f
#define LABEL_COLOR  [PublicFunction getColorWithRed:239.0 Green:239.0 Blue:239.0];
#define SELECT_COLOR [PublicFunction getColorWithRed:155.0 Green:209.0 Blue:75.0];
//#define SELECT_COLOR [PublicFunction getColorWithRed:0.0 Green:191.0 Blue:252.0];

//#define iPHone6  ([UIScreen mainScreen].bounds.size.height == 667) ? YES : NO

#define MYWIDTH   [[UIScreen mainScreen] bounds].size.width
#define MYHEIGHT  [[UIScreen mainScreen] bounds].size.height

#define WIDTHR  MYWIDTH  / 375
#define HEIGHTR MYHEIGHT / 667

//详情页面中各种cell的尺寸大小
#define COLL_CELL_HEIGHT       110.0f  //collectionView中cell的高度
#define COLL_CELL_LINE_SPACE   10.0f   //collectionView中cell之间的水平间距
#define DETAIL_CELL_TOP_HEIGHT 30.0f   //详情页面中,细节cell的顶部高度
#define USER_IMAGE_WIDTH       30.0f   //发布游记的用户头像小图标的宽度(或者高度)
#define GUIDE_CELL_HEIGHT      COLL_CELL_HEIGHT * 1.5f   //特色游记的collectionView的cell的高度(hotCity的1.5倍)

#define HOT_GUIDE_CELLID       @"coll_hotGuide"
#define CITY_LIST_CELLID       @"city_list"

//搜索功能,NSUserDefaults 使用的key
#define HISTORY_ARR @"array"

#define COLLECT_IMAGE @"trip_like_button_image@2x.png"
#define SHARE_IMAGE   @"tabbar_share_button_image_hl@2x.png"
#define MORE_IMAGE    @"tab_more_normal@2x.png"
#define BACK_IMAGE    @"auth_back_button_image"


//#define BACK_IMAGE    @"btn_nav_back@2x.png"
//#define MORE_IMAGE    @"tab_more_normal@2x副本.png"

//------国家详情中会使用的参数
#define LINE_SPACE   10.0f
#define HOT_CELL_HEIGHT 100.0f
#define COLL_TOP_HEIGHT 10.0f
#define SPEED  100.0f

//------特色列表中使用的参数
#define GUIDE_LIST_CELL_HEIGHT ((MYHEIGHT - 64) * 2.0f/5.0f)
#define GUIDE_AVATAR_WITH (30.0f)

//宏定义详情页面中热门国家tableViewCell的高度
#define GET_CITY_CELL_HEIGHT(a)   ceil((a))*(COLL_CELL_HEIGHT + COLL_CELL_LINE_SPACE) + DETAIL_CELL_TOP_HEIGHT + COLL_CELL_LINE_SPACE
//宏定义详情页面中热门国家tableViewCell的高度
#define GET_GUIDE_CELL_HEIGHT(a)  ceil((a)) * (HOT_CELL_HEIGHT*1.5 + LINE_SPACE ) + DETAIL_CELL_TOP_HEIGHT

#define PHOLDER_IMAGE_NAME @"placeHolder.png"
//国家列表
#define COUNTRY_LIST_URL   @"http://open.qyer.com/qyer/footprint/continent_list?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88285245920633&lon=121.5397154133398&page=1&track_app_channel=App%2520Store&track_app_version=6.3&track_device_info=iPhone7%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%25208.3&v=1"

//国家详情
//参数:country_id
#define COUNTRY_DETAIL_URL @"http://open.qyer.com/qyer/footprint/country_detail?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@&lat=38.8828660137188&lon=121.5396645471911&page=1&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//城市详情
#define CITY_DETAIL_URL @"http://open.qyer.com/qyer/footprint/city_detail?app_installtime=1434021180&city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88283453829436&lon=121.5397283890296&page=1&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//城市列表 参数 countryid page
#define CITY_LIST_URL @"http://open.qyer.com/place/city/get_city_list?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&countryid=%@&lat=38.87982110139613&lon=121.5421073624529&page=%li&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//特色列表 参数id type page
#define GUIDE_LIST_URL @"http://open.qyer.com/qyer/footprint/mguide_list?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&id=%@&lat=38.85294869425481&lon=121.5155925853864&page=%li&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&type=%@&v=1"

//特色详情 参数
#define GUIDE_DETAIL_URL @"http://open.qyer.com/qyer/footprint/mguide_detail?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&id=%@&lat=38.85280279188221&lon=121.5152194915353&page=%li&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//推荐行程列表 参数 type id(cityid 或者 countryid page recommand)
#define RECOM_TRAVEL_LIST_URL  @"http://open.qyer.com/place/common/get_recommend_plan_list?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&%@=%@&lat=38.8828217715488&lon=121.539663172314&page=%li&recommand=%@&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&type=%@&v=1"

//足迹列表 参数 : category_id , city_id , page
#define WAYPOINT_LIST_URL  @"http://open.qyer.com/qyer/onroad/poi_list?app_installtime=1434021180&category_id=%li&city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&orderby=popular&page=%li&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&types=&v=1"

//足迹详情 参数:  poi_id
#define WAYPOINT_DETAIL_URL  @"http://open.qyer.com/qyer/footprint/poi_detail?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.85425004802912&lon=121.5190100160246&page=1&poi_id=%@&screensize=1242&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//国家详情进入地图
#define CITYLIST_MAP_URL @"http://open.qyer.com/qyer/map/city_list?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@&lat=38.88281901973186&lon=121.5393892846033&page=1&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//城市详情进入地图
#define POILIST_MAP_URL @"http://open.qyer.com/qyer/map/poi_list?app_installtime=1434021180&cate_id=32&city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88281499144234&lon=121.5395576135878&page=1&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&v=1"

//搜索页面热门搜索数据
#define HOT_SEARCH_URL  @"http://open.qyer.com/qyer/search/hot_history?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88279346127519&lon=121.5397270565838&oauth_token=0e4c909d9148fbecf809da352ccd67f3&page=1&track_app_channel=App%2520Store&track_app_version=6.3&track_device_info=iPhone7%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%25208.3&track_user_id=6189101&v=1"

//搜索页面实时更新搜索结果
#define TEMP_SEARCH_URL  @"http://open.qyer.com/qyer/search/autocomplate?app_installtime=1434021180&citymode=0&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%@&lat=38.88285347457298&lon=121.5396060526987&oauth_token=0e4c909d9148fbecf809da352ccd67f3&page=1&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&track_user_id=6189101&v=1"

//详细的搜索结果列表
#define SEARCH_LIST_URL   @"http://open.qyer.com/qyer/search/index?app_installtime=1434021180&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%@&lat=38.88274276409582&lon=121.5396346026016&oauth_token=0e4c909d9148fbecf809da352ccd67f3&page=%li&place_field=country%%7Ccity%%7Cpoi&track_app_channel=App%%2520Store&track_app_version=6.3&track_device_info=iPhone7%%2C1&track_deviceid=8FCBE397-C1C4-4B26-86E9-B0A238D5C9D9&track_os=ios%%25208.3&track_user_id=6189101&type=place&v=1"

//AFN请求时的acceptableContentTypes内容
#define ACCEPTABLE_TYPES @"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html"

//tableView上方的大图UIImageView的高度
#define IMAGE_HEIGHT 240.f

//电台列表接口
#define radio_url0 @"%E5%9F%8E%E5%B8%82%E5%8D%B0%E8%B1%A1"
#define radio_url1 @"%E8%8A%B1%E6%A0%B7%E6%97%85%E8%A1%8C"
#define radio_url2 @"%E5%9C%A8%E8%B7%AF%E4%B8%8A"
#define radio_url3 @"%E8%A1%8C%E5%90%AC%E5%A4%A9%E4%B8%8B"
#define radio_url4 @"%E8%B6%85%E7%BA%A7%E7%8E%A9%E5%AE%B6"
#define radio_url5 @"%E5%AF%BB%E6%99%AF%E5%AE%9D%E5%85%B8"

//推荐列表接口
#define Recomone_URLNo_1 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88282528613024&lng=121.5396567937513&sign=891a06b48fd035d96db03c3800902354"

#define Recomone_URLNo_2 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88281359473868&lng=121.5396759728157&next_start=2386608762&sign=c1f2625a3192d58d126873501c313f57"

#define Recomone_URLNo_3 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88281359473868&lng=121.5396759728157&next_start=2386619530&sign=e89382a612d76dbe5dc4c86b7beac202"

#define Recomone_URLNo_4 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88281359473868&lng=121.5396759728157&next_start=2388254104&sign=14ed6cbb55945978a39091ac3443b2bf"

#define Recomone_URLNo_5 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88281359473868&lng=121.5396759728157&next_start=2386613685&sign=54550629df0e5240045ca18972e48eeb"
#define Recomone_URLNo_6 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88281359473868&lng=121.5396759728157&next_start=2386612287&sign=4b4a1d73095b17adaf3bec5f22d06c46"
#define Recomone_URLNo_7 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387740639&sign=8fcc036bf11eda7f46e24e16d04a900e"
#define Recomone_URLNo_8 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387781879&sign=43d67d04dd8fe5c0c7aad79e61e12b94"
#define Recomone_URLNo_9 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387848896&sign=ec08e5a5bf6a26c64e1596b3ee6a4afb"
#define Recomone_URLNo_10 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387914288&sign=7376a335ea4d9a8b27ab54b263959656"
#define Recomone_URLNo_11 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387765069&sign=861c19185955d569b16050d9f088825f"
#define Recomone_URLNo_12 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387714741&sign=92ff006371f346e57a9d880019c88a71"
#define Recomone_URLNo_13 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387745067&sign=dbc65fb8f2a98c88393206aa88e6372e"
#define Recomone_URLNo_14 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387951168&sign=0be986603415a2c136d2bd4c0024eb4f"
#define Recomone_URLNo_15 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2388008180&sign=e6d94721ddeaaceb232cecf6566f814d"
#define Recomone_URLNo_16 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387785550&sign=99eeed599ca3784bc8c2dee29ca8472e"
#define Recomone_URLNo_17 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2388080428&sign=d11ca4eda05e173603c292ac97588831"
#define Recomone_URLNo_18 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387859338&sign=d5e3653a5ca652004357f0cc7e38bb1b"
#define Recomone_URLNo_19 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387714241&sign=ada6551e46087f642fc5b2020929fc64"
#define Recomone_URLNo_20 @"http://api.breadtrip.com/v5/index/?is_ipad=0&lat=38.88285968457019&lng=121.5396286768673&next_start=2387711916&sign=3e33bd2218c32d9f7d5e65eb74c58d86"
