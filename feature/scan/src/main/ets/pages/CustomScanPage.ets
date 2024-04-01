import { customScan, scanBarcode, scanCore } from '@kit.ScanKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { display, promptAction } from '@kit.ArkUI'
import { checkAndRequestPermission, NavigationManager } from '@ohos/utils/Index'
import { TitleComponent } from '@ohos/components/src/main/ets/components/TitleComponent'

@Component
export struct CustomScanPage {
  @State userGrant: boolean = false
  @State surfaceId: string = ''
  @State isShowBack: boolean = false
  @State isFlashLightEnable: boolean = false
  // 设置预览流高度，默认单位：vp
  @State cameraHeight: number = 640
  // 设置预览流宽度，默认单位：vp
  @State cameraWidth: number = 360
  private mXComponentController: XComponentController = new XComponentController()
  private TAG: string = '[customScanPage]'
  @State flashLightSwitch: boolean = false
  @State continueScanSwitch: boolean = false
  @State scanResultRect: scanBarcode.ScanCodeRect | undefined = undefined

  setDisplay() {
    this.cameraWidth = display.getDefaultDisplaySync().height
    this.cameraHeight = display.getDefaultDisplaySync().width
  }

  aboutToAppear(): void {
    this.onPageShow()
  }

  aboutToDisappear(): void {
    this.onPageHide()
  }

  build() {
    Stack() {
      if (this.userGrant) {
        Column() {
          XComponent({
            id: 'componentId',
            type: 'surface',
            controller: this.mXComponentController
          }) {
            if (this.scanResultRect) {
              Rect()
                .position({
                  x: `${this.scanResultRect.left}px`,
                  y: `${this.scanResultRect.top}px`
                })
                .width(`${this.scanResultRect.right - this.scanResultRect.left}px`)
                .height(`${this.scanResultRect.bottom - this.scanResultRect.top}px`)
                .fillOpacity(0)
                .stroke(Color.Green)
                .strokeWidth(4)
            }
          }
          .onLoad(async () => {
            // 获取XComponent组件的surfaceId
            this.surfaceId = this.mXComponentController.getXComponentSurfaceId();
            this.startScan()
          }) // XComponent宽、高，默认单位vp，支持px、lpx、vp
          // .width(this.cameraWidth)
          // .height(this.cameraHeight)
          // .position({ x: 0, y: 0 })
        }
        .height('100%')
        .width('100%')
      }

      Column() {
        TitleComponent({
          title: "自定义扫码",
          onBack: () => {
            NavigationManager.getInstance().pop()
          },
          bgColor: $r('app.color.transparent')
        })
        Column()
          .layoutWeight(1)
          .width('100%')

        Row() {
          Column() {
            Toggle({ type: ToggleType.Switch, isOn: this.flashLightSwitch })
              .onChange(() => {
                this.onFlashSwitchChange()
              })
            Blank().height(4)
            Text("闪光灯").fontColor($r('app.color.white'))
          }.visibility((this.userGrant && this.isFlashLightEnable) ? Visibility.Visible : Visibility.None)

          Blank().width(10)

          Column() {
            Toggle({ type: ToggleType.Switch, isOn: this.continueScanSwitch })
              .onChange((isOn) => {
                this.continueScanSwitch = isOn
              })
            Blank().height(4)
            Text("连续扫描").fontColor($r('app.color.white'))
          }
        }
        .margin({ bottom: 40 })
      }
    }
    // 建议相机流设置为全屏
    .width('100%')
    .height('100%')
  }

  async onPageShow() {
    this.userGrant = await checkAndRequestPermission(getContext(), ['ohos.permission.CAMERA']);
    let options: scanBarcode.ScanOptions = {
      scanTypes: [scanCore.ScanType.ALL],
      enableMultiMode: true,
      enableAlbum: true
    }
    this.setDisplay();
    try {
      customScan.init(options);
    } catch (error) {
      hilog.error(0x0001, this.TAG, 'init fail, error: %{public}s ', JSON.stringify(error));
    }
  }

  async onPageHide() {
    // 页面消失或隐藏时，停止并释放相机流
    this.userGrant = false;
    try {
      await customScan.stop();
    } catch (error) {
      hilog.error(0x0001, this.TAG, 'Catch: stop error %{public}s', JSON.stringify(error));
    }
    this.releaseScan()
  }

  async showScanResult(result: Array<scanBarcode.ScanResult>) {
    if (result.length > 0) {
      this.scanResultRect = result[0].scanCodeRect
      await this.stopScan()
      if (this.continueScanSwitch) {
        this.startScan()
      }

      // 使用toast显示出扫码结果
      try {
        promptAction.showToast({
          message: JSON.stringify(result),
          duration: 5000
        });
      } catch (error) {
        hilog.error(0x0001, this.TAG, 'showToast error: %{public}s ', JSON.stringify(error));
      }
      this.isShowBack = true;
      this.isFlashLightEnable = false;
    }
  }

  startScan() {
    let viewControl: customScan.ViewControl = {
      width: this.cameraWidth,
      height: this.cameraHeight,
      surfaceId: this.surfaceId
    };
    // 启动相机进行扫码
    try {
      this.isFlashLightEnable = true;
      customScan.start(viewControl)
        .then(async (result: Array<scanBarcode.ScanResult>) => {
          // 处理扫码结果
          this.showScanResult(result);
        })
    } catch (error) {
      hilog.error(0x0001, this.TAG, 'start fail, error: %{public}s ', JSON.stringify(error));
    }
  }

  async stopScan() {
    try {
      this.isFlashLightEnable = false;
      await customScan.stop()
    } catch (error) {
      hilog.error(0x0001, this.TAG, 'stop failed error: %{public}s ', JSON.stringify(error));
    }
  }

  releaseScan() {
    try {
      customScan.release().then(() => {
        hilog.info(0x0001, this.TAG, 'release success!');
        this.isFlashLightEnable = false;
      }).catch((error: BusinessError) => {
        hilog.error(0x0001, this.TAG, 'release failed error: %{public}s ', JSON.stringify(error));
      })
    } catch (error) {
      hilog.error(0x0001, this.TAG, 'Catch: release error %{public}s', JSON.stringify(error));
    }
  }

  onFlashSwitchChange() {
    if (customScan.getFlashLightStatus()) {
      customScan.closeFlashLight();
    } else {
      customScan.openFlashLight();
    }
  }
}