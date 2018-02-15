const {readFileSync} = require('fs');
const version = readFileSync('pub/static/deployed_version.txt', 'utf8');
const theme = "Magento/luma"
const dir = `pub/static/frontend/${theme}/en_GB`;
const publicPath = `/static/version${version}/frontend/${theme}/en_GB`;
module.exports = {
    "globDirectory": './',
    "globPatterns": [
        `${dir}/css/styles-{l,m}.css`,
        `${dir}/requirejs/require.js`,
        `${dir}/mage/requirejs/mixins.js`,
        `${dir}/requirejs-config.js`,
        `${dir}/bundles/*.js`,
        `${dir}/images/logo.svg`
    ],
    "manifestTransforms": [
        function(items) {
            return items.map(item => {
                if (item.url.indexOf(dir) === 0) {
                    return {
                        ...item,
                        url: item.url.replace(dir, publicPath)
                    }
                }
                return {
                    ...item
                }
            })
        }
    ],
    "templatedUrls": {
        "/offline": "app/code/Jh/Offline/view/frontend/templates/index/index.phtml",
    },
    "swSrc": `${dir}/Jh_Offline/service-worker.js`,
    "swDest": "pub/service-worker.js",
    "maximumFileSizeToCacheInBytes": 3000000
};
