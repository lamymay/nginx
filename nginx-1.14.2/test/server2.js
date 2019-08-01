var http = require('http');
const fs = require("fs");
const wait = (seconds) => {
    return new Promise((resolve, reject) => {

        setTimeout(() => {
            resolve();
        }, seconds * 1000)
    })
};

http.createServer(function (request, response) {
    console.log('----- request come', request.headers.host + new Date());

    if (request.url === "/") {
        const html = fs.readFileSync('test.html', 'utf-8');
        response.writeHead(200, {
            // 'Content-Type': 'text/plain'
            'Content-Type': 'text/html'
        });
        response.end(html);
    }
    if (request.url === "/data") {
        response.writeHead(200, {
            //private no-store
            'Very':'X-T-estCache',//userAgent 区分头来缓存
            'Cache-Control': 'max-age=5,s-maxage=20'
        });

        wait(2).then(() => response.end('success'));
    }



    if (request.url === "/favicon.ico") {
        wait(2).then(() => response.end('favicon.ico'));
    }

}).listen(8002);

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8002/');

