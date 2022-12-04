
# If you want to create the project from scratch.

# First cd into the correct folder. Ensure first the folder is present.

# https://dev.to/larswillemsens/managing-asp-net-core-mvc-front-end-dependencies-with-npm-and-webpack-part-1-3jf5

pwd

cd ../..

pwd

cd ./src/tasks/3070-WebAppStockAnalyzerHttpClient

cd ../../apps/3070-WebAppStockAnalyzerHttpClient

pwd

############################################################

# 1. First create the asp.net core 6 web app solution
# Run the following command, but before that ensure to delete the node_modules folder.

Remove-Item -Recurse -Force node_modules

$SolutionName = "WebAppStockAnalyzerHttpClient"

$ProjectFileName = $SolutionName + ".csproj"

$ProjectFileNameCurrentPath = "./" + $ProjectFileName

$SolutionNameCopyPath = "./" + $SolutionName + "/*"

$SolutionNamePath = "./" + $SolutionName

$NewLineString = [Environment]::NewLine

dotnet new sln --name $SolutionName

dotnet new mvc --name $SolutionName --framework net7.0

Copy-Item $SolutionNameCopyPath . -Recurse

# Now that we have copied all of the items inside of the folder, we can delete all of the items inside of it and the folder itself.

Remove-Item $SolutionNamePath -Recurse

dotnet sln add $ProjectFileName

dotnet build $ProjectFileNameCurrentPath

dotnet run --project $ProjectFileNameCurrentPath

# The following is not needed.
dotnet new gitignore

New-Item -Path '.\ClientApp\src' -ItemType Directory

New-Item -Path ".\ClientApp\src\loadjquery.js"

New-Item -Path ".\ClientApp\src\main.js"

New-Item -Path ".\ClientApp\src\other.js"

New-Item -Path ".\ClientApp\src\site.js"

New-Item -Path ".\ClientApp\src\sitecss.css"

$LoadJqueryContent = @"

// import 'bootstrap';
// import './scss/app.scss';
// import { $, jQuery } from 'jquery';

global.jQuery = global.$ = require('jquery');

"@

$MainFileContent = @"
var other = require('./other');

jQuery('#jqueryTestDiv').append('<p>Hello World! If you are seeing this, then jquery is loaded....</p>');

other();

"@

$OtherFileContent = @"

function func() {
     alert('loaded!!! Just for testing');
}

module.exports = func;
"@

$SiteJsFileContent = @"

// JS Dependencies: Popper, Bootstrap & JQuery
import '@popperjs/core';
import 'bootstrap';



// CSS Dependencies: Bootstrap
import 'bootstrap/dist/css/bootstrap.css';

// Custom JS imports
// ... none at the moment

// Custom CSS imports
import './sitecss.css';

console.log('The \'site\' bundle has been loaded!');

"@

Add-Content -Path ".\ClientApp\src\loadjquery.js" -Value $LoadJqueryContent

Add-Content -Path ".\ClientApp\src\main.js" -Value $MainFileContent

Add-Content -Path ".\ClientApp\src\other.js" -Value $OtherFileContent

Add-Content -Path ".\ClientApp\src\site.js" -Value $SiteJsFileContent

$SomeSiteCssFileContent = Get-Content -Path ".\wwwroot\css\site.css" 

Add-Content -Path ".\ClientApp\src\sitecss.css" -Value $SomeSiteCssFileContent

$NewLineString = [Environment]::NewLine

Add-Content -Path ".\ClientApp\src\sitecss.css" -Value $NewLineString

$SomeSiteCssFileContent = Get-Content -Path ".\Views\Shared\_Layout.cshtml.css" 

Add-Content -Path ".\ClientApp\src\sitecss.css" -Value $SomeSiteCssFileContent

Set-Location ClientApp

npm init -y

Remove-Item -Recurse -Force node_modules

# Dev Server may not be needed, need to look into. Also webpack-cli
# npm install webpack webpack-cli webpack-dev-server --save-dev

npm install jquery jquery-validation jquery-validation-unobtrusive bootstrap @popperjs/core --save

npm install webpack webpack-cli --save-dev

npm install css-loader style-loader --save-dev

npm install

# Add the following to the scripts section of Package.json

    "start": "webpack serve",
    "build": "set NODE_ENV=production&&webpack",
    "wpbuild": "webpack",
    "wpdevsrv": "webpack serve",

New-Item -Path ".\webpack.config.js"

$WebPackConfigFileContent=@"

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
"@

Add-Content -Path ".\webpack.config.js" -Value $WebPackConfigFileContent

Set-Location ClientApp

npm run wpbuild

Set-Location ..

Remove-Item -Recurse -Force ".\wwwroot\css"

Remove-Item -Recurse -Force ".\wwwroot\js"

Remove-Item ".\Views\Shared\_Layout.cshtml.css"

Remove-Item -Recurse -Force ".\wwwroot\lib"

# Update the _Layout.cshtml(inside of Views/Shared) file with the following in the head.

    <script src="~/dist/loadjquery.build.js" ></script>
    <script src="~/dist/main.build.js" defer ></script>
    <script src="~/dist/site.build.js"  ></script>

# Remove or commentout the following from the same layout page.

    <link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="~/css/site.css" asp-append-version="true" />
    <link rel="stylesheet" href="~/WebAppStockAnalyzerHttpClient.styles.css" asp-append-version="true" />

# Add Jquery test page and also its link in the layout page. 

Set-Location ClientApp

npm run wpbuild

Set-Location ..

dotnet run --project $ProjectFileNameCurrentPath

# Now stop the app, add index cshtml page and also the action method. now run the app again.

############################################################################################

# If you are cloding and just want to run the app after cloning, run the following command.
dotnet run --project WebAppStockAnalyzerHttpClient.csproj