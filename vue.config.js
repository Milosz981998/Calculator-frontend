const { VueLoaderPlugin } = require('vue-loader')

module.exports={
  devServer: {
      proxy: {
        "^/api/": {
          target: "http://backend",
          secure: false,
          pathRewrite: {
            "/api/*": "/"
          }
        }
      }
    }
  };