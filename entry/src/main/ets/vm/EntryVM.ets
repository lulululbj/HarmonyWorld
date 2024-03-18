import { RouterConstants } from '../model/Constants'
import { HomeMenuEntity } from '../model/HomeMenuEntity'

export class EntryVM {
  homeMenuList: HomeMenuEntity[] = [
    new HomeMenuEntity("悬浮窗", RouterConstants.FLOAT_MANAGER)
  ]
}