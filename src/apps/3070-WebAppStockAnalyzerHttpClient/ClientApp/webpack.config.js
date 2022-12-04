
const path = require('path');

var $ = require('jquery');

let production = process.env.NODE_ENV === 'production';

let config = {
  entry: {
    main: './src/main',
    loadjquery: './src/loadjquery',
    site: './src/site'
  },
  output: {
    publicPath: '/dist/',
    path: path.join(__dirname, './../wwwroot/dist/'),
    filename: '[name].build.js',
  },
    module: {
      rules: [
        {
          test: /\.css$/,
          use: ['style-loader', 'css-loader'],
        },
      ],
    },
    resolve: {
      extensions: ['.js'],
    },
    mode: 'development',
}

if (production) {
    config.mode = 'production';
    config.devtool = 'inline-source-map';
  }
  
  module.exports = config;
