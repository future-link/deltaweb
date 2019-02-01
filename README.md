# deltaweb
[![Build Status](https://travis-ci.org/future-link/deltaweb.svg?branch=master)](https://travis-ci.org/future-link/deltaweb)

misskey-delta/misskey-webの別実装

## How to config
```
cp .env.example .env
```

- `SESSION_SECRET`: 適当な文字 ないしょ
- `API_ROOT`: APIサーバーが動いているURL
- `API_KEY`: apiPasskey
- `PORT`: 動くポート

## How to run

```
npm install
npm run build
npm start
```
