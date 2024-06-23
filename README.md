# 概要

技術評論社様へ寄稿した記事と関連し、AWS、Azure、Google CloudでT-Potを動かすためのインフラ設定を公開します。

この設定を利用することで各クラウドサービスにT-Pot用インスタンスをデプロイし、同時にT-Potの利用に必要なVPC設定、ネットワーク設定、さらにはファイアウォール設定等を自動で行うことができます。  
(リージョン毎の傾向を見るために各クラウドサービスの日本と米国の両リージョンに同時にリソースをデプロイします)

# 利用方法

## tfvarsファイルを作成・編集

見本のtfvarsファイルをコピーし、必要な情報を記述してください

```shell
# 見本ファイルからtfvarsファイルを新規作成
cp terraform.tfvars.example terraform.tfvars

# tfvarsファイルを編集
vi terraform.tfvars
```

## SSH鍵の作成・配置

T-Potをセットアップ/管理するためのSSH鍵を作成してください。  
Terraform経由で各インスタンスに公開鍵を配置します。

```shell
# SSH用のキーペアを作成
ssh-keygen -t rsa

# 公開鍵をアップロード用のディレクトリに移動
mv [GENERATED_PUB_KEY].pub ./keys/id_rsa.pub
```

## terraformの実行

terraformを実行してインフラをデプロイしてください。

```shell
terraform init
terraform apply
```

## 備考など

- 必要に応じてマシンスペック等を調整して下さい  
  (例えば長時間動かす場合はより大きなDiskを利用して下さい)
- T-Potのカスタマイズ等については[公式リポジトリ](https://github.com/telekom-security/tpotce)を参照して下さい。
- 今回はインフラ部分のみterraform化していますがcloud-init等でT-Potセットアップの自動化も可能です。
