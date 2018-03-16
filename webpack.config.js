/*
 * Copyright (c) e-binaria <info@e-binaria.com.ar>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const config  = require('./dna.config.js');
const webpack = require('webpack');
const path    = require('path');
const glob    = require('glob');
const fse     = require('fs-extra');
const fs      = require('fs');

const colorGreen  = '\033[1;32m';
const colorYellow = '\033[1;33m';
const colorOrange = '\033[0;33m';
const colorWhite  = '\033[1;37m';
const colorRed    = '\033[1;31m';
const colorNone   = '\033[0m';

var modules = new Array();

// Create parent data folder and symlink to assets
var dataFolders = [
  { folder: '', permissions: 0755 },
  { folder: '/private', permissions: 0777 },
  { folder: '/public', permissions: 0755 },
  { folder: '/public/modules', permissions: 0755 },
  { folder: '/public/static', permissions: 0755 },
  { folder: '/public/uploads', permissions: 0777 },
  { folder: '/var', permissions: 0777 }
];

for (k = 0; k < dataFolders.length; k++) {
  if (!fs.existsSync(config.destinationPath + dataFolders[k].folder)){
    fs.mkdirSync(config.destinationPath + dataFolders[k].folder);
    fs.chmodSync(config.destinationPath + dataFolders[k].folder, + dataFolders[k].permissions);
  }
}

if (!fs.existsSync('./web/assets')){
  fs.symlinkSync('../' + config.destinationPath + '/public', './web/assets');
  console.log(colorGreen + '\u2713' + colorNone + ' Created: ' + colorYellow + 'Assets symlink' + colorNone);
  console.log('\n...\n');
}

if (!fs.existsSync(config.destinationPath + '/private')){
  fs.mkdirSync(config.destinationPath + '/private', 0777);
  fs.chmodSync(config.destinationPath + '/private', 0777);
}


// For each app
for (k = 0; k < config.apps.length; k++) {

  app = config.apps[k];

  console.log(colorWhite + 'App: ' + colorYellow + app.name + colorNone + '\n');

  // Create an array of modules within each bundle
  console.log(colorWhite + 'Modules:\n' + colorNone);
  var modulesInBundles = {};
  var files = [];
  for (p = 0; p < app.prefixes.length; p++) {
    var filesToAdd = glob.sync(app.prefixes[p] + '/src/Resources/assets/modules/**/*.js');
    if (filesToAdd.length > 0) {
      files = files.concat(filesToAdd);
    }
  }

  if (files.length == 0) {
    console.log(colorRed + 'x None\n' + colorNone);
    console.log('\n...\n');
    continue;  // Nothing to do
  }

  // Add modules to bundles
  for (var i = 0; i < files.length; i++) {
    parts        = files[i].split('/');
    bundleIndex = 3;
    if (parts[1] == 'src') {
      bundleIndex = 2
    }
    bundlePrefix = parts[bundleIndex].split('.').join('-');
    bundleModule = parts[bundleIndex + 5].substring(0, parts[bundleIndex + 5].length - 3);
    console.log(colorGreen + '\u2713' + colorNone + ' Created ' + colorGreen + bundlePrefix + '-' + bundleModule + colorNone + ' from ' + colorWhite + files[i] + colorNone);
    modulesInBundles[bundlePrefix + '-' + bundleModule] = files[i];
  }

  // Copy static assets from each symfony bundle to /web/assets/<bundle.key>
  console.log(colorWhite + '\nStatic assets:\n' + colorNone);
  var bundlesWtihStaticFiles = [];
  for (p = 0; p < app.prefixes.length; p++) {
    var filesToAdd = glob.sync(app.prefixes[p] + '/src/Resources/assets/static');
    if (filesToAdd.length > 0) {
      bundlesWtihStaticFiles = bundlesWtihStaticFiles.concat(filesToAdd);
    }
  }

  if (bundlesWtihStaticFiles.length == 0) {
    console.log(colorOrange + 'x None\n' + colorNone);
  } else {
    for (var i = 0; i < bundlesWtihStaticFiles.length; i++) {
      parts      = bundlesWtihStaticFiles[i].split('/');
      bundleIndex = 3;
      if (parts[1] == 'src') {
        bundleIndex = 2
      }
      destFolder = config.destinationPath + '/public/static/' + parts[bundleIndex];
      console.log(colorGreen + '\u2713' + colorNone + ' Created ' + colorGreen + destFolder + '/*' + colorNone + ' from ' + colorWhite + bundlesWtihStaticFiles[i] + '/*' + colorNone);
      fse.copy(bundlesWtihStaticFiles[i] + '/', destFolder, err => {
        if (err) return console.error(err);
      });
    }
  }


  modules.push({

    entry: modulesInBundles,

    output: {
      filename: 'module-[name].js',
      /* path: path.resolve(__dirname, 'web/assets/modules'), */
      path: path.resolve(config.destinationPath + '/public/', 'modules'),
      publicPath: "/assets/modules/"
    },

    devServer: {
      inline: false,
      contentBase: path.resolve(__dirname, 'web')
    },

    plugins: [
      // Automatically import jquery where $, etc. are used.
      new webpack.ProvidePlugin({
        $: 'jquery',
        'jQuery': 'jquery',
        'window.jQuery': 'jquery',
        'MediumEditor': 'medium-editor'
        // 'fetch': 'imports?this=>global!exports?global.fetch!whatwg-fetch',
      }),
      new webpack.optimize.CommonsChunkPlugin({
        name: ['dna-' + app.name +'-common'],
        minChunks: 2
      }),
      new webpack.optimize.ModuleConcatenationPlugin()
      // Minify assets.
      /* new webpack.optimize.UglifyJsPlugin({
        compress: {
          warnings: false // https://github.com/webpack/webpack/issues/1496
        }
      }) */
    ],

    module: {
      rules: [
        {
          test   : /\.css$/,
          loaders: ['style-loader', 'css-loader', 'resolve-url-loader']
        },
        {
          test: /\.scss?$/,
          use: [
            'style-loader', 'css-loader', 'resolve-url-loader', 'sass-loader?sourceMap'
          ]
        },
        {
          test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
          loader: 'url-loader?limit=10000&mimetype=application/font-woff'
        },
        {
          test: /\.(ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
          loader: 'url-loader?limit=10000',
        },
        {
          test: /\.(jpe?g|gif|png|ico)$/,
          loader: 'url-loader?limit=10000'
        }
      ]
    }
  });

  console.log('\n...\n');
}


// Export configuration
module.exports = modules;

