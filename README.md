# react-native-qq

gradle.properties

android 配置
QQ_API_ID=1234567890

ios配置
Build Settings->Search Paths->Framework Search Paths 增加 $(SRCROOT)/../node_modules/react-native-qq/ios
Build Settings->Link->Other Linker Flags 增加 -framework TencentOpenAPI
Info->URL Types 添加
  Identifier -> qq
  URL Schemes -> tencent1234567890


  <key>LSApplicationQueriesSchemes</key>
      <array>
        <string>wechat</string>
        <string>weixin</string>
        <string>mqqapi</string>
        <string>mqq</string>
        <string>mqqOpensdkSSoLogin</string>
        <string>mqqconnect</string>
        <string>mqqopensdkdataline</string>
        <string>mqqopensdkgrouptribeshare</string>
        <string>mqqopensdkfriend</string>
        <string>mqqopensdkapi</string>
        <string>mqqopensdkapiV2</string>
        <string>mqqopensdkapiV3</string>
        <string>mqzoneopensdk</string>
        <string>wtloginmqq</string>
        <string>wtloginmqq2</string>
        <string>mqqwpa</string>
        <string>mqzone</string>
        <string>mqzonev2</string>
        <string>mqzoneshare</string>
        <string>wtloginqzone</string>
        <string>mqzonewx</string>
        <string>mqzoneopensdkapiV2</string>
        <string>mqzoneopensdkapi19</string>
        <string>mqzoneopensdkapi</string>
        <string>mqzoneopensdk</string>
      </array>
