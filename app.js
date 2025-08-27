'use strict';
const express = require("express");
const path = require('path');
const app = express();

const debug = (req, res, next) => {
    console.log("middleware.debug ->", req.method, req.url);
    next();
};

app.use(debug);
app.use(express.static('public'));

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'), (err) => {
        if (err) {
            console.error('Error sending file:', err);
            res.status(500).send('Internal Server Error');
        }
    });
});

app.get("/json", (req, res) => {
    res.json({
        result: 'ok'
    });
});

// Express 5対応の404ハンドラー
app.use((req, res) => {
    res.status(404).json({
        error: 'Not Found',
        path: req.originalUrl
    });
});

// エラーハンドリングミドルウェア
app.use((err, req, res, next) => {
    console.error('Unhandled error:', err);
    res.status(500).json({
        error: 'Internal Server Error'
    });
});

const PORT = process.env.PORT || 80;

app.listen(PORT, (err) => {
    if (err) {
        console.error("Server start error:", err);
        process.exit(1);
    }
    console.log(`Server running on http://127.0.0.1:${PORT}`);
});