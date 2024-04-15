import { RouterConstants } from '../model/Constants'
import { HomeMenuEntity } from '../model/HomeMenuEntity'

export class EntryVM {
  homeMenuList: HomeMenuEntity[] = [
    new HomeMenuEntity("悬浮窗", RouterConstants.FLOAT_MANAGER),
    new HomeMenuEntity("har && hsp", RouterConstants.HAR_HSP),
    new HomeMenuEntity("Scan Kit", RouterConstants.SCAN),
    new HomeMenuEntity("Web", RouterConstants.Web),
    new HomeMenuEntity("状态管理", RouterConstants.StateManagePage)
  ]
}