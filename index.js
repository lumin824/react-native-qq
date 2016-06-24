import {
  NativeModules
} from 'react-native';

let { QQModule } = NativeModules;

export var login = QQModule.login
