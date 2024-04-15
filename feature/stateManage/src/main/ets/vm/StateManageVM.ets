import { ObservedArray } from '@ohos/utils/Index'
import { MenuEntity, MenuGroupEntity } from '../entity/MenuEntity'

@Observed
export class StateManageVM {
  isEditing: boolean = false
  myMenuData: ObservedArray<MenuEntity> = new ObservedArray()
  menuGroupData: ObservedArray<MenuGroupEntity> = new ObservedArray()

  changeEditStatus() {
    this.isEditing = !this.isEditing
  }

  addToMyMenu(menu: MenuEntity) {
    const index = this.myMenuData.findIndex((item: MenuEntity) => item.menuName === menu.menuName)
    if (index === -1) {
      this.myMenuData.push(menu)
      // 更新
    }
  }

  removeFromMyMenu(menu: MenuEntity) {
    const index = this.myMenuData.findIndex((item: MenuEntity) => item.menuName === menu.menuName)
    if (index !== -1) {
      this.myMenuData.splice(index, 1)
      // 从我的应用中移除之后，需要更新分组菜单中的数据状态
      this.menuGroupData.forEach((group: MenuGroupEntity) => {
        const index = group.menuList.findIndex((item: MenuEntity) => item.menuName === menu.menuName)
        if (index !== -1) {
          group.menuList[index].isChecked = false
          return
        }
      })
    }
  }

  getMenuGroupData() {
    this.menuGroupData.push(
      new MenuGroupEntity("便民生活", [
        new MenuEntity($r('app.media.ic_alipay'), "支付宝"),
        new MenuEntity($r('app.media.ic_baidu'), "百度"),
        new MenuEntity($r('app.media.ic_bilibili'), "Bilibili"),
        new MenuEntity($r('app.media.ic_dingding'), " 钉钉"),
        new MenuEntity($r('app.media.ic_douban'), "豆瓣"),
        new MenuEntity($r('app.media.ic_eleme'), "饿了么"),
        new MenuEntity($r('app.media.ic_iqiyi'), "爱奇艺"),
        new MenuEntity($r('app.media.ic_ks'), "快手"),
        new MenuEntity($r('app.media.ic_kugou'), "酷狗"),
        new MenuEntity($r('app.media.ic_momo'), "陌陌"),
        new MenuEntity($r('app.media.ic_qq_music'), "QQ 音乐"),
        new MenuEntity($r('app.media.ic_qq'), "QQ"),
        new MenuEntity($r('app.media.ic_sina'), " 新浪"),
        new MenuEntity($r('app.media.ic_taobao'), "淘宝"),
        new MenuEntity($r('app.media.ic_wechat'), "微信"),
        new MenuEntity($r('app.media.ic_wyy'), "网易云音乐"),
        new MenuEntity($r('app.media.ic_xhs'), "小红书"),
        new MenuEntity($r('app.media.ic_zhihu'), "知乎"),
      ]),
      new MenuGroupEntity("购物娱乐", [
        new MenuEntity($r('app.media.ic_behance'), " Behance"),
        new MenuEntity($r('app.media.ic_facebook'), "Facebook"),
        new MenuEntity($r('app.media.ic_google'), "Google"),
        new MenuEntity($r('app.media.ic_instagram'), "Instagram"),
        new MenuEntity($r('app.media.ic_linkedin'), "Linkedin"),
        new MenuEntity($r('app.media.ic_pinterest'), "Pinterest"),
        new MenuEntity($r('app.media.ic_tiktok'), "Tiktok"),
        new MenuEntity($r('app.media.ic_tumber'), "Tumber"),
        new MenuEntity($r('app.media.ic_twitter'), "Twitter"),
        new MenuEntity($r('app.media.ic_vk'), "Vk"),
        new MenuEntity($r('app.media.ic_whatsapp'), "Whatsapp"),
        new MenuEntity($r('app.media.ic_youtube'), "Youtube"),
      ]))

    this.myMenuData.push(new MenuEntity($r('app.media.ic_tiktok'), "Tiktok"),
      new MenuEntity($r('app.media.ic_facebook'), "Facebook"),)
  }
}