/*
 * Copyright (c) e-binaria <info@e-binaria.com.ar>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

"use strict"

// Data folder name will be current application folder name plus the sufix '-data'
var parts = __dirname.split('/');
var destinationPath = '../' + parts[parts.length - 1] + '-data';

var apps  = [
    {
        name: 'web',
        prefixes: [
            './src/app.web.*',
            './vendor/e-binaria/dna.web.*'
        ]
    },
    {
        name: 'admin',
        prefixes: [
            './vendor/e-binaria/dna.admin.*',
            './vendor/e-binaria/dna.common.*',
            './vendor/mlp/juzgado.admin.*',
            './vendor/mlp/juzgado.common.*'
        ]
    },
];

module.exports.destinationPath = destinationPath;
module.exports.apps = apps;