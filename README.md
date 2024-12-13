# ガーデニング管理アプリケーション

全世界のガーデニング初心者の方が知識と経験不足による植物管理がうまくいかないという課題を解決するガーデニング管理アプリケーションです．
このリポジトリはAPIのリポジトリです

---

環境構築方法
---
**以下の手順を踏んで環境を構築してください**

**クローン**

``` clone git@github.com:sasatoast/Kotatsumuri.git  ```

**.envファイルの作成**

``` touch .env ```

**Dockerを立ち上げる**

``` docker compose up ```

### Postgresqlの起動

**コンテナ内に移動**
```docker exec -it kotatsumuri-db-1 bash```

**Postgresqlを起動**

```sql -U postgres```


**パスワードを入力**

```postgres```
