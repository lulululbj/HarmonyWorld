/**
 * Description: 悬浮窗管理
 * Author: luyao
 * Date: 2024/3/14 16:29
 */

import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { Log, PreferenceUtil } from '@ohos/utils/Index';
import { FloatPreferenceKey } from '../model/Constants';

const TAG = "[FloatManager]"

class FloatManager {
  windowStage_: window.WindowStage | null = null
  sub_windowClass: window.Window | null = null
  locationX = 200
  locationY = 200
  size = 100

  init(windowStage: window.WindowStage, locationX: number, locationY: number) {
    this.windowStage_ = windowStage
    this.locationX = locationX
    this.locationY = locationY
  }

  saveLocation() {
    PreferenceUtil.getInstance().setValue(FloatPreferenceKey.locationX, this.locationX)
    PreferenceUtil.getInstance().setValue(FloatPreferenceKey.locationY, this.locationY)
  }

  updateLocation(offSetX: number, offsetY: number) {
    if (this.sub_windowClass != null) {
      this.locationX = this.locationX + offSetX
      this.locationY = this.locationY + offsetY
      this.sub_windowClass.moveWindowTo(this.locationX, this.locationY, (err: BusinessError) => {

        let errCode: number = err.code;
        if (errCode) {
          Log.error(TAG, 'Failed to change the window size. Cause:' + JSON.stringify(err));
          return;
        }
        Log.info(TAG, `save float locatio: ${this.locationX} ${this.locationY}`)
      });
    }
  }

  showSubWindow() {
    if (this.windowStage_ == null) {
      Log.error(TAG, 'Failed to create the subwindow. Cause: windowStage_ is null');
    } else {
      this.windowStage_.createSubWindow("HarmonyWorld", (err: BusinessError, data) => {
        let errCode: number = err.code;
        if (errCode) {
          Log.error(TAG, 'Failed to create the subwindow. Cause: ' + JSON.stringify(err));
          return;
        }
        this.sub_windowClass = data;
        Log.info(TAG, 'Succeeded in creating the subwindow. Data: ' + `x: ${this.locationX}`);

        // 2.子窗口创建成功后，设置子窗口的位置、大小及相关属性等。
        this.sub_windowClass.moveWindowTo(Math.floor(this.locationX), Math.floor(this.locationY), (err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            Log.error(TAG, 'Failed to move the window. Cause:' + JSON.stringify(err));
            return;
          }
        }
        )
        ;
        this.sub_windowClass.resize(this.size, this.size, (err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            Log.error(TAG, 'Failed to change the window size. Cause:' + JSON.stringify(err));
            return;
          }
        });
        // this.sub_windowClass.setUIContent("pages/FloatPage", (err: BusinessError) => {
        this.sub_windowClass.loadContentByName("floatPage", (err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            Log.error(TAG, 'Failed to load the content. Cause:' + JSON.stringify(err));
            return;
          }
          // 3.显示子窗口。
          (this.sub_windowClass as window.Window).showWindow((err: BusinessError) => {
            let errCode: number = err.code;
            if (errCode) {
              Log.error(TAG, 'Failed to show the window. Cause: ' + JSON.stringify(err));
              return;
            }
            data.setWindowBackgroundColor("#00000000")
          });
        });
      }
      )
    }
  }

  destroyFloatWindow() {
    if (this.sub_windowClass) {
      this.sub_windowClass.destroyWindow((err: BusinessError) => {
        let errCode: number = err.code;
        if (errCode) {
          Log.error(TAG, 'Failed to destroy the window. Cause: ' + JSON.stringify(err));
          return;
        }
      })
    }
  }
}

export default new FloatManager()