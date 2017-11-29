

var Mock = require('mockjs')

var listData = Mock.mock('http://g.cn/api/creations', {
    'data|5-20' : [
        {
            'title' : '@cparagraph(1, 3)',
            'thumb': Mock.Random.image('1280x760', '@color()', 'hello'),
        }
    ],
})


export {
    listData
}