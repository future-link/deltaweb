# deltaweb
misskey-delta/misskey-webの別実装

## config
```
cp .env.example .env
```

- `SESSION_SECRET`: 適当な文字 ないしょ
- `API_ROOT`: APIサーバーが動いているURL
- `API_KEY`: apiPasskey

## run

```
npm install
npm run build
node src/index.js
```
