const { VueLoaderPlugin } = require('vue-loader')

module.exports={
  devServer: {
      proxy: {
        "^/api/": {
          target: "http://calculator",
          secure: false,
          pathRewrite: {
            "/api/*": "/"
          }
        }
      }
    }
  };