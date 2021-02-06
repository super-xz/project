module.exports={
    devServer: {
        proxy: {
            'admin': {
                target: 'http://www.restaurant.com/index.php/vue/',
                pathRewrite: {
                    '^/api': '/admin',
                }
            },
            'restaurant': {
                target: 'http://www.restaurant.com/index.php/vue/',
                pathRewrite: {
                    '^/restaurant': '/restaurant',
                }
            },
            'img': {
                target: 'http://www.restaurant.com/index.php/vue/',
                pathRewrite: {
                    '^/img': '/img',
                }
            },
        }
    }
}