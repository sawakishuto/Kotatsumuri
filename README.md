# ガーデニング管理アプリケーション

全世界のガーデニング初心者の方が知識と経験不足による植物管理がうまくいかないという課題を解決するガーデニング管理アプリケーションです．
このリポジトリはAPIのリポジトリです

### 概要
育てる植物マスタの登録や育成中の植物が今何をする時期なのかを一覧でわかりやすく見ることができます。
植物が病気にかかった時は生育環境や写真からどんな病気の可能性が高いか、どんな対策、解決策をどんなタイミングで行えばいいかを教えてくれ、そのままやることリストに紐付けることができます。
知識不足が故にうっかり、肥料を上げる時期を逃してしまったり、植え付ける時期を逃してしまったりする課題を解決し、素人では判断しずらい病気の知識を補填してくれます。

# スクリーンショット

<img src="https://github.com/user-attachments/assets/8b6017c1-ea6b-473b-8d95-c7e89713bfe8" width="30%" />
<img src="https://github.com/user-attachments/assets/68d8dae9-4632-4f66-ab99-9e8af3fefe7e" width="30%" />
<img src="https://github.com/user-attachments/assets/d8a527f7-6028-4084-9530-e49c6a18e20f" width="30%" />
<img src="https://github.com/user-attachments/assets/7c9331a9-8e8f-44b5-9a8b-e1aaf7b4b45e" width="30%" />
<img src="https://github.com/user-attachments/assets/bf7add1f-b6f4-490d-80df-4a4408f006a1" width="30%" />
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
