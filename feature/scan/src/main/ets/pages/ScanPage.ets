import { NormalButton, TitleComponent } from '@ohos/components/Index'
import { scanBarcode, scanCore } from '@kit.ScanKit'
import { Log, NavigationManager } from '@ohos/utils/Index'

@Component
export struct ScanPage {
  @State scanResult: string = ""

  build() {
    Column() {

      TitleComponent({
        title: "Scan Kit",
        onBack: () => {
          NavigationManager.getInstance().pop()
        }
      })

      TextInput({
        text: this.scanResult
      }).enableKeyboardOnFocus(false)

      NormalButton({
        text: "默认扫码",
        click: () => {
          let options: scanBarcode.ScanOptions = {
            scanTypes: [scanCore.ScanType.ALL],
            enableMultiMode: true,
            enableAlbum: true
          }
          try {
            scanBarcode.startScanForResult(getContext(this), options)
              .then((result) => {
                this.scanResult = `${result.scanType} ${result.originalValue}`
              })
          } catch (e) {
            Log.error("默认扫描", "error: " + JSON.stringify(e))
          }
        }
      })

      NormalButton({
        text: "自定义扫码",
        click: () => {
          NavigationManager.getInstance().pushPathByName("CustomScanPage")
        }
      })
    }
  }
}